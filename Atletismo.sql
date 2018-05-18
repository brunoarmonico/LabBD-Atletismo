create database Atletismo
go
use Atletismo

create table pais(

codigo char (3) primary key,
nome varchar (50) not null
)

drop table pais

select * from pais

select cast(nome as int) from pais

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

create table atleta(

codigo int identity(1,1) primary key,
nome varchar(50) not null,
sexo char(1) not null,
codigo_pais char (3) references pais (codigo)
)

drop table atleta

create trigger t_atleta
on atleta
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

create table prova(

id_prova int identity(1,1) primary key,
nome_prova varchar(50) not null,
sexo char(1) not null
)

insert into prova (nome_prova, sexo) values
('Lançamento do Dardo', 'f'),
('Salto em Distancia', 'm'),
('Salto com Vara', 'm'),
('400m com barreira', 'm'),
('100m','f'),
('Arremesso de Peso','f'),
('100m','m'),
('3000m','m'),
('Lançamento de Disco','m'),
('3000m com obstaculo','f'),
('Salto Triplo','f'),
('400m','m'),
('800m','f'),
('800m','m'),
('200m','f'),
('200m','m')

select * from atleta

create procedure pr_adicionaAtleta(@nome varchar (50), @sexo char (1), @codigoPais char(3), @saida varchar (max) output)
as
begin
	insert into atleta values (@nome, @sexo, @codigoPais)e
	set @saida = 'Atleta Cadastrado com Sucesso!!!'
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

select * from resultado
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

select * from resultado
where (id_prova = 15) and (bateria = 2) and (fase = 'final')

drop table resultado

create trigger t_resultado
on resultado
after update, delete
as
begin
	rollback transaction
	raiserror('NÃO É POSSSIVEL EXCLUIR OU ALTERAR A TABELA', 16,1)
end

create procedure pr_adicionaResultado(@id_Prova int, @id_atleta int,  @tempo varchar(12), @bateria int, @distancia decimal (7,2), @fase varchar(20), @saida varchar(max) output)
as
begin
	insert into resultado values (@id_Prova, @id_atleta, convert(time, @tempo), @bateria, @distancia, @fase)
	set @saida = 'RESULTADO INSERIDO COM SUCESSO!'
end


DECLARE @SAIDA VARCHAR(MAX)
EXEC pr_adicionaResultado 2, 1, '00:40:30:444', 2, null, 'final', @saida output
PRINT @SAIDA


select * from resultado

select * from fn_resultadoBateria (1, 1, 'inicial')

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
	if ((select tempo from resultado  where id_prova = @id_prova) is not null)
	begin
		insert into @resultado (nome_atleta, nome_pais, tempo)
		select al.nome, pa.nome, re.tempo from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where (re.id_prova = 15) and (re.bateria = 2) and (re.fase = 'final') 
		order by tempo
	end
	else
	begin
		insert @resultado (nome_atleta, nome_pais, distancia)
		select al.nome, pa.nome, re.distancia from resultado re
		inner join atleta al
		on re.id_atleta = al.codigo
		inner join pais pa
		on al.codigo_pais = pa.codigo
		where (re.id_prova = @id_prova) and re.bateria = @bateria and re.fase = @fase 
		--group by max(@maxFase)
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
	select * from fn_lista_pais()        