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