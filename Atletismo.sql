create database Atletismo
go
use Atletismo

create table atleta(

codigo int identity(1,1) primary key,
nome varchar(50) not null,
sexo char(1) not null,
pais varchar(20) not null
)

create table prova(

id_prova int identity(1,1) primary key,
nome_prova varchar(50) not null,
sexo char(1) not null
)

create table resultado(

id_prova int,
id_atleta int,
tempo varchar(15) null,
distancia varchar(15) null

foreign key(id_prova) references prova(id_prova),
foreign key(id_atleta) references atleta(codigo)
)


