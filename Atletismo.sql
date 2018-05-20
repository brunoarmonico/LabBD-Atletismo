create database Atletismo
go
use Atletismo

drop table pais
create table pais(
codigo char (3) primary key,
nome varchar (50) not null
)

insert pais values 
('BRA','Brasil'),
('USA', 'Estados Unidos da America'),
('CAN', 'Canada'),
('MEX', 'Mexico'),
('GUA', 'Guatemala'),
('ARG', 'Argentina'),
('URU', 'Uruguai'),
('BOL', 'Bolivia'),
('COL', 'Colombia'),
('PER', 'Peru'),
('VEN', 'Venezuela'),
('CHI', 'Chile'),
('CRC', 'Costa Rica'),
('CUB', 'Cuba'),
('JAM', 'Jamaica'),
('ECU', 'Equador'),
('DOM', 'Republica Dominicana')

create trigger t_pais
on pais
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

drop table atleta
create table atleta(
codigo int identity(1,1) primary key,
nome varchar(50) not null,
sexo char(1) not null,
codigo_pais char (3) references pais (codigo)
)

create trigger t_atleta
on atleta
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

create table prova(
id_prova int primary key,
nome_prova varchar(50) not null,
sexo char(1) not null
)

insert into prova values
(1, 'Lançamento do Dardo', 'f'),
(2, 'Salto em Distancia', 'm'),
(3, 'Salto com Vara', 'm'),
(4, 'Salto Triplo', 'f'),
(5, 'Arremesso de Peso', 'f'),
(6, 'Lançamento de Disco', 'm'),
(7, '3000m com obstaculo', 'f'),
(8, '400m com barreira', 'm'),
(9, '100m', 'm'),
(10, '3000m', 'm'),
(11, '100m', 'f'),
(12, '400m', 'm'),
(13, '800m', 'f'),
(14, '800m', 'm'),
(15, '200m', 'f'),
(16, '200m', 'm')

create procedure pr_adicionaAtleta(@nome varchar (50), @sexo char (1), @codigoPais char(3), @saida varchar (max) output)
as
begin
	insert into atleta values (@nome, @sexo, @codigoPais)
	set @saida = 'Atleta Cadastrado com Sucesso!!!' + ' Codigo do atleta: ' + convert(varchar(5), (select top (1) codigo from atleta order by codigo desc))
end

DECLARE @SAIDA VARCHAR(MAX)
EXEC pr_adicionaAtleta 'fulano','m','BRA', @saida output
PRINT @SAIDA

create function fn_retorna_prova ()
returns @prova table(
id_prova int ,
nome_prova varchar(50),
sexo char(1)
)
as
begin
	insert into @prova 
	select * from prova
return
end

select * from fn_retorna_prova()

drop table resultado
create table resultado(
id_resultado int identity(1,1) primary key,
id_prova int not null,
id_atleta int not null,
tempo time null,
bateria int not null,
distancia decimal (7,2) null,
fase varchar (20) not null

foreign key(id_prova) references prova(id_prova),
foreign key(id_atleta) references atleta(codigo),
)

create table record (
nome varchar (100) not null,
pais varchar (100) not null,
resultado varchar (20) not null,
idprova int not null,
tipo varchar (20) not null,
novorecord varchar (20) null
)
select cast(resultado as time) from record where idprova = 8 and tipo = 'world'
select * from record
select * from resultado
drop table record

insert into record values
('fulano', 'uganda', '00:30:40.7752', 8, 'world', null),
('fulano', 'uganda', '40', 1, 'world', null)


create trigger t_resultado
on resultado
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

drop trigger t_verifica_resultado

create trigger t_verifica_resultado
on resultado
for insert
as
declare @prova int  = (select id_prova from inserted),
		@bateria int = (select bateria from inserted),
		@fase varchar (20)  = (select fase from inserted),
		@competidores int,
		@idAtleta int = (select id_atleta from inserted),
		@participacoes int,
		@sexoProva char (1)
set @competidores = (select count(*) from resultado where id_prova = @prova and bateria = @bateria and fase = @fase)
set @participacoes = (select count(*) from resultado where id_prova = @prova and id_atleta = @idAtleta and bateria = @bateria and fase = @fase)
set @sexoProva = (select sexo from prova where id_prova = @prova)
if (@sexoProva != (select sexo from atleta inner join inserted on inserted.id_atleta = atleta.codigo))
begin 
	rollback transaction
	raiserror('SEXO INCOMPATIVEL COM ESTA PROVA', 16,1)
end
else if (@prova <= 6)
begin
	if (@participacoes <= 6)
	begin
		if (@competidores > 20 and @fase = 'inicial')
		begin
			rollback transaction
			raiserror('NUMERO MAXIMO DE COMPETIDORES ALCANÇADO', 16,1)
		end
		else
		if (@competidores > 8 and @fase != 'inicial')
		begin
			rollback transaction
			raiserror('NUMERO MAXIMO DE COMPETIDORES ALCANÇADO', 16,1)
		end
	end
	else
	begin
		rollback transaction
		raiserror('ATLETA JA PARTICIPOU 6 VEZES NESTA BATERIA', 16,1)
	end
end
else
begin
	if (@participacoes = 1)
	begin
		if (@competidores > 20 and @fase = 'inicial')
		begin
			rollback transaction
			raiserror('NUMERO MAXIMO DE COMPETIDORES ALCANÇADO', 16,1)
		end
		else
		if (@competidores > 8 and @fase != 'inicial')
		begin
			rollback transaction
			raiserror('NUMERO MAXIMO DE COMPETIDORES ALCANÇADO', 16,1)
		end
	end
	else
	begin
		rollback transaction
		raiserror('ATLETA JA PARTICIPOU DESTA BATERIA', 16,1)
	end
end
if (@prova <= 6)
begin
	if ((select resultado from record where idprova = @prova and tipo = 'event') is null)
	begin
		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, distancia), @prova, 'event', null from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
	if ((select distancia from inserted) > (select convert(decimal (7,2), resultado) from record where idprova = @prova and tipo = 'world'))
	begin
		delete from record where idprova = @prova and tipo = 'world'

		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, distancia), @prova, 'world', 'green' from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
	if ((select distancia from inserted) > (select convert(decimal (7,2), resultado) from record where idprova = @prova and tipo = 'event'))
	begin
		delete from record where idprova = @prova and tipo = 'event'

		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, distancia), @prova, 'event', 'blue' from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
end
else
begin
	if ((select resultado from record where idprova = @prova and tipo = 'event') is null)
	begin
		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, tempo), @prova, 'event', null from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
	if ((select tempo from inserted) < (select convert(time, resultado) from record where idprova = @prova and tipo = 'world'))
	begin
		delete from record where idprova = @prova and tipo = 'world'

		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, tempo), @prova, 'world', 'green' from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
	if ((select tempo from inserted) < (select convert(time, resultado) from record where idprova = @prova and tipo = 'event'))
	begin
		delete from record where idprova = @prova and tipo = 'event'

		insert into record (nome, pais, resultado, idprova, tipo, novorecord)
		select al.nome, pa.nome, convert(varchar, tempo), @prova, 'event', 'blue' from inserted ins
			inner join atleta al
			on al.codigo = ins.id_atleta
			inner join pais pa
			on pa.codigo = al.codigo_pais
	end
end

select * from resultado

drop procedure pr_adicionaResultado
create procedure pr_adicionaResultado(@id_Prova int, @id_atleta int,  @tempo varchar(12), @bateria int, @distancia decimal (7,2), @fase varchar(20), @saida varchar(max) output)
as
begin
	if (@distancia = 0)
	begin
		set @distancia = null
	end
	if (@tempo = '')
	begin
		set @tempo = null
	end
	if (@bateria >= 2 and @fase = 'inicial')
	begin
		if ((select @id_atleta from resultado where bateria = (@bateria - 1) and fase = 'inicial' and id_prova = @id_Prova) is not null)
		begin
			insert into resultado values (@id_Prova, @id_atleta, convert(time, @tempo), @bateria, @distancia, @fase)
			set @saida = 'RESULTADO INSERIDO COM SUCESSO!'
		end
		else
		begin
			set @saida = 'ATLETA NÃO ESTA CADASTRADO NESTE EVENTO'
		end
	end
	else
	if (@fase = 'final')
	begin
		if ((select @id_atleta from resultado where bateria = 3 and fase = 'inicial') is not null)
		begin
			if (@bateria >= 2 and @fase = 'final')
			begin
				if ((select @id_atleta from resultado where bateria = (@bateria - 1) and fase = 'final' and id_prova = @id_Prova) is not null)
				begin
					insert into resultado values (@id_Prova, @id_atleta, convert(time, @tempo), @bateria, @distancia, @fase)
					set @saida = 'RESULTADO INSERIDO COM SUCESSO!'
				end
				else
				begin
					set @saida = 'ATLETA NÃO ESTA CADASTRADO NESTE EVENTO'
				end
			end
			else
			if (@bateria = 1 and @fase = 'final')
			begin
				insert into resultado values (@id_Prova, @id_atleta, convert(time, @tempo), @bateria, @distancia, @fase)
				set @saida = 'RESULTADO INSERIDO COM SUCESSO!'
			end
		end
		else
		begin
			set @saida = 'ATLETA NÃO ESTA CADASTRADO NESTE EVENTO'
		end
	end
	if (@bateria = 1 and @fase = 'inicial')
	begin
		insert into resultado values (@id_Prova, @id_atleta, convert(time, @tempo), @bateria, @distancia, @fase)
		set @saida = 'RESULTADO INSERIDO COM SUCESSO!'
	end
end

select * from record

DECLARE @SAIDA VARCHAR(MAX)
EXEC pr_adicionaResultado 8, 2, '00:10:55:9711', 2, 0, 'inicial', @saida output
PRINT @SAIDA

select * from resultado

select * from fn_resultadoBateria(8, 1, 'inicial')
drop function fn_resultadoBateria 
create function fn_resultadoBateria (@id_prova int, @bateria int, @fase varchar (20))
returns @retorna table(
id_atleta int,
atleta varchar (50),
pais varchar(20),
resultado varchar(40),
posicao varchar (10) null
)
as
begin
	declare @maxFase int
	if (@fase = 'inicial')
	begin
		set @maxFase = 8
	end
	else
	begin
		set @maxFase = 3
	end
	if (@id_prova <= 6)
	begin
		insert into @retorna (id_atleta, atleta, pais, resultado, posicao)
		select top (@maxFase) re.id_atleta, max(al.nome), max(pa.nome), max(re.distancia), null from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where re.id_prova = @id_prova and re.bateria = @bateria and re.fase = @fase 
		group by re.id_atleta
		order by max(re.distancia) desc
	end
	else
	begin
		insert @retorna (id_atleta, atleta, pais, resultado, posicao)
		select top (@maxFase) re.id_atleta, al.nome, pa.nome, convert(varchar, re.tempo), null from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where id_prova = @id_prova and bateria = @bateria and fase = @fase 
		order by re.tempo

		update @retorna
		set posicao =  'Ouro'
		where posicao = 1

		update @retorna
		set posicao =  'Prata'
		where posicao = 2

		update @retorna
		set posicao =  'Bronze'
		where posicao = 3

	end
return
end

create function fn_lista_pais() 
returns @pais table (

codigo char(3),
nome varchar(50)
)
as 
begin
	insert into @pais
	select * from pais
return
end

select * from resultado


select * from resultado
select * from atleta

select top (8) re.id_atleta, al.nome, pa.nome, convert(varchar,re.tempo) from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where id_prova = 8 and bateria =1 and fase = 'inicial'
		order by re.tempo