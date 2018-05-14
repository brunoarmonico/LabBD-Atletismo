create database Atletismo
go
use Atletismo

create table pais(

codigo char (3) primary key,
nome varchar (50) not null
)

create table atleta(

codigo int identity(1,1) primary key,
nome varchar(50) not null,
sexo char(1) not null,
codigo_pais char (3) references pais (codigo)
)

create table prova(

id_prova int identity(1,1) primary key,
nome_prova varchar(50) not null,
sexo char(1) not null
)

create table resultado(
id_resultado int identity(1,1) primary key,
id_prova int,
id_atleta int,
tempo varchar(15) null,
bateria int not null,
distancia varchar(15) null,
fase varchar (20) not null

foreign key(id_prova) references prova(id_prova),
foreign key(id_atleta) references atleta(codigo)
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

create function fn_bateria (@id_prova int, @bateria int)
returns @resultado table(
id_prova int,
nome_prova varchar (50),
id_atleta int,
nome_atleta varchar (50),
tempo varchar (15) null,
distancia varchar (15) null,
fase varchar (20)
)
as
begin
	select 
return 
end