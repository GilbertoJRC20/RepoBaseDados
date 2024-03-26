create database ExemploTeorica01;

use ExemploTeorica01;


------DDL------
create table Cliente (
	idCliente int identity (1,1) PRIMARY KEY,
	nome varchar (50),
	cidade varchar (50),
	codPostal int,
	cc int unique not null
);

create table Venda (
	idVenda int identity (1,1) PRIMARY KEY,
	cliente int,
	foreign key (cliente) references Cliente (idCliente),
	data_venda datetime,
	desconto decimal (5,2)
);

create table Artigo (
	idArtigo int identity (1,1)	PRIMARY KEY,
	nome varchar (50),
	preco decimal (10,2),
	categoria varchar (20)
);

create table LinhaVenda (
	venda int,
	 foreign key (venda) references Venda (idVenda),
	artigo int,
	foreign key (artigo) references Artigo (idArtigo),
	quantidade int,
	primary key (venda, artigo)
);


------DML------
insert into Cliente (nome, cidade, codPostal, CC) values
('Ana', 'Maia', 4567, 123),
('Bruno', 'Porto', 4200, 456),
('Miguel', 'Porto', 4200, 789),
('Maria', 'Maia', 4567, 234),
('Joana', 'Maia', 4567, 678);

insert into Artigo (nome, preco, categoria) values
('Martelo', 5.5, 'Ferramentas'),
('Parafuso', 0.5, 'Ferramentas'),
('Prego', 0.2, 'Ferramentas'),
('Lampada', 1.5, 'Eletricidade'),
('Tripla', 5.5, 'Eletricidade');

insert into Venda (cliente, data_venda, desconto) values
(1, '2021-03-29', 0.05),
(1, '2021-03-31', 0.20),
(2, '2021-03-29', 0.5),
(4, '2021-03-29', 0.5);

insert into LinhaVenda (venda, artigo, quantidade) values
(1, 1, 2),
(1, 3, 10),
(2, 2, 20),
(3, 3, 100),
(4, 1, 5);


------DQL------
select * from Cliente;

select cidade
from CLiente

select distinct cidade
from Cliente

select * 
from Artigo

select idArtigo, nome, preco
from Artigo
where preco < 5

select nome, preco
from Artigo
where preco between 2 and 10

select nome, preco
from Artigo
where preco < 5 or preco > 10

select nome, preco
from Artigo
where preco not between 5 and 10

select nome, preco
from Artigo
where preco in (10, 100)

select * 
from Artigo
where nome like 'M%'

select * from Artigo
order by preco asc

select * from Artigo
order by preco desc

select * from Artigo
where preco > 500
order by preco desc

select count (nome) as TotalArtigos
from artigo

select sum (preco) as SomaPV
from Artigo

select avg (preco) as MediaPV
from Artigo

select max (preco) as MaximoPV
from Artigo

select min (preco) as MinimoPV

select * from Venda;

select * from LinhaVenda;

select Cliente.nome, Venda.data_venda, Artigo.nome
from Artigo, Cliente, Venda, LinhaVenda
where Cliente.idCliente = Venda.cliente and
Venda.idVenda = LinhaVenda.venda and
LinhaVenda.artigo = Artigo.idArtigo

select c.nome, v.data_venda, a.nome
from Artigo a, Cliente c, Venda v, LinhaVenda 1
where c.idCliente = v.cliente and
v.idVenda = 1.venda and
1.artigo = a.idArtigo

select c.nome, v.data_venda
from Cliente c
inner join Venda v on c.idCliente = v.cliente

select c.nome, v.data_venda
from CLiente c
left join Venda v on c.idCliente = v.cliente

select c.nome, v.data_venda, sum (1.quantidade *a.preco) as Total
from Artigo a, Cliente c, Venda v, LinhaVenda 1
where c.idCliente = v.cliente and v.idVenda = 1.venda and 1.artigo = a.idArtigo
group by c.nome, v.data_venda
select top(1) c.nome, v.data_venda
from Artigo a, Cliente c, Venda v, LinhaVenda 1
where c.idCliente = v.cliente and v.idVenda = 1.venda and 1.artigo = a.idArtigo
order by v.data_venda desc

select c.codPostal, count(c.codPostal)
from Cliente c
group by c.codPostal
having count(c.codPostal) > 2;

select a.categoria, count(a.nome) as TotalArtigos
from Artigo a
group by a.categoria

select c.nome
from Cliente c
where c.idCliente not in (select cliente from Venda)

select nome, (select count(*) from Venda where Venda.cliente = Cliente.idCliente)
from Cliente

select nome
from Artigo
where preco >= all (select preco
from Artigo)

select nome
from Artigo
where preco > any (select preco
from Artigo)