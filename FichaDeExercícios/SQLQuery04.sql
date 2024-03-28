use GestaoComercial;

--DDL
create table Cliente(
	id int identity (1,1) primary key,
	nome varchar (50) not null,
	morada varchar (250),
	estado bit
);

create table Produto(
	id int identity(1,1) primary key,
	descricao varchar (100) not null,
	preco decimal (12,2)
);

create table Venda(
	prod int references Produto (id),
	cli int references Cliente(id),
	data_venda datetime, 
	qtd int,
	primary key (prod, cli, data_venda)
);


--DML
insert into CLiente
values ('Helena Monteiro', 'Perafita', 1),
('Raúl Simas', 'Palmela', 0);

insert into Produto
values ('Rato Logitec', 10),
('Monitor Sony', 120);

insert into Venda
values (1,1, '2012-04-05', 1),
(1,2, '2012-04-05', 5);

--DQL
select * from Cliente;
select * from Produto;
select * from Venda;

update Venda
set qtd = 10
where prod = 1 
		and cli = 2 
		and data_venda =  '2012-04-05 00:00:00.000'


create procedure alteraMorada (
 @morada varchar (100), @cli int 
)
as
	update Cliente
	set morada = @morada
	where id = @cli;
go

Exec alteraMorada
@morada = 'Porto', @cli = 2;

go

--5.b
create view clientesAtivos as
select nome from Cliente
where estado = 1
go

select * from clientesAtivos;
go

--5.e
create procedure quantasVendas_cli (
@cli int)
as
	select count(v.cli) as contagem
	from venda v
	where v.cli = @cli
go
Exec quantasVendas_cli @cli = 2
go

--5.f
select max (preco)
from produto
go

--5.f
create view NomeProdMaisCaro as
select descricao, preco
from Produto
where preco = (select max (preco) as Maxim
					from produto)
go

select * from NomeProdMaisCaro
go

--5.h
create view ClientesNuncaCompraram as
select nome
from Cliente
where id not in (select cli from venda)
go

select * from ClientesNuncaCompraram
go