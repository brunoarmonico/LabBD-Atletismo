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

create trigger t_resultado
on resultado
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

drop trigger t_max_competidores
create trigger t_max_competidores
on resultado
for insert
as
declare @prova int  = (select id_prova from inserted),
		@bateria int = (select bateria from inserted),
		@fase varchar (20)  = (select fase from inserted),
		@competidores int,
		@idAtleta int = (select id_atleta from inserted)
set @competidores = (select count(*) from resultado where id_prova = @prova and bateria = @bateria and fase = @fase)
if (@prova <= 6)
begin
	if ((select count(*) from resultado where id_prova = @prova and id_atleta = @idAtleta and bateria = @bateria and fase = @fase) <= 6)
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
	if ((select count(*) from resultado where id_prova = @prova and id_atleta = @idAtleta and bateria = @bateria and fase = @fase) < 1)
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

drop procedure pr_adicionaResultado
create procedure pr_adicionaResultado(@id_Prova int, @id_atleta int,  @tempo varchar(12), @bateria int, @distancia decimal (7,2), @fase varchar(20), @saida varchar(max) output)
as
begin
	if (@bateria >= 2 and @fase = 'inicial')
	begin
		if ((select @id_atleta from resultado where bateria = (@bateria - 1) and fase = 'inicial') is not null)
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
		if ((select @id_atleta from resultado where bateria = 6 and fase = 'inicial') is not null)
		begin
			if (@bateria >= 2 and @fase = 'final')
			begin
				if ((select @id_atleta from resultado where bateria = (@bateria - 1) and fase = 'final') is not null)
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


DECLARE @SAIDA VARCHAR(MAX)
EXEC pr_adicionaResultado 1, 1, '00:45:44:114', 1, null, 'inicial', @saida output
PRINT @SAIDA

drop function fn_resultadoBateria 
create function fn_resultadoBateria (@id_prova int, @bateria int, @fase varchar (20))
returns @resultado table(
nome_atleta varchar (50),
nome_pais varchar (50),
tempo time null,
distancia decimal (7,2) null
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
	if ((select top 1 tempo from resultado  where id_prova = @id_prova) is not null)
	begin
		insert into @resultado (nome_atleta, nome_pais, tempo)
		select top (@maxFase) al.nome, pa.nome, re.tempo from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where re.id_prova = @id_prova and re.bateria = @bateria and re.fase = @fase 
		order by tempo
	end
	else
	begin
		insert @resultado (nome_atleta, nome_pais, distancia)
		select top (@maxFase) al.nome, pa.nome, re.distancia from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where re.id_prova = @id_prova and re.bateria = @bateria and re.fase = @fase 
		order by distancia
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