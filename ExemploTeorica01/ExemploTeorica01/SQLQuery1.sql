create database ExemploTeorica01;

use ExemploTeorica01;

create table Cliente( 
    idCliente int identity(1,1) PRIMARY KEY,
    nome varchar (50),
    cidade varchar(50),
    codPostal int,
    cc int unique not null 
);

create table Venda( 
    idVenda int identity(1,1)PRIMARY KEY,
    cliente int,
    foreign key (cliente) references Cliente(idCliente),
    data datetime,
    desconto decimal(5,2) 
);

create table Artigo( 
    idArtigo int identity(1,1) PRIMARY KEY,
    nome varchar(50),
    preco decimal(10,2),
    categoria varchar(20) 
);

create table LinhaVenda( 
    venda int,
     foreign key (venda) references Venda(idVEnda),
    artigo int,
    foreign key (artigo) references Artigo(idArtigo),
    quantidade int,
    primary key (venda, artigo) 
);

insert into Cliente (nome, cidade, codPostal, CC) values 
("Ana", 'Maia', 4567, 123),
('Bruno', 'Porto', 4200, 456),
('Miguel', 'Porto', 4200, 789),
('Maria', 'Maia', 4567, 234),
('Joana', 'Maia', 4567, 678);
insert into Artigo (nome, preco, categoria) values 
('Martelo', 5.5, 'Ferramentas'),
('Parafuso', 0.5, 'Ferramentas'),
('Prego', 0.2, 'Ferramentas'),
('Lampada', 1.5, 'Electricidade'),
('Tripla', 5.5, 'Electricidade');
insert into Venda (cliente, data, desconto) values 
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

SELECT *  
FROM Artigo 
SELECT idArtigo, nome, preco 
FROM Artigo 
WHERE preco<5 
SELECT nome, preco 
FROM Artigo 
WHERE preco>=2 AND preco<=10 
SELECT nome, preco 
FROM Artigo 
WHERE preco BETWEEN 2 AND 10 
SELECT nome, preco 
FROM Artigo 
WHERE preco<5 OR preco>10 
SELECT nome, preco 
FROM Artigo 
WHERE preco NOT BETWEEN 5 AND 10 
SELECT nome, preco 
FROM Artigo 

WHERE preco IN (10,100) 
SELECT * 
FROM Artigo 
WHERE nome LIKE ‘M%’ 
SELECT * FROM Artigo 
ORDER BY preco ASC 
SELECT * FROM Artigo 
ORDER BY preco DESC 
SELECT * FROM Artigo 
WHERE preco >500 
ORDER BY preco DESC 
SELECT COUNT(nome) AS TotalArtigos 
FROM Artigo 
SELECT SUM(preco) AS SomaPV 
FROM Artigo 
SELECT AVG(preco) AS MediaPV 
FROM Artigo 
SELECT MAX(preco) AS MaximoPV 
FROM Artigo 
SELECT MIN(preco) AS MinimoPV 
FROM Artigo 
SELECT cidade 
FROM Cliente 
SELECT DISTINCT cidade 
FROM Cliente 
SELECT Cliente.nome, Venda.data, Artigo.nome 
FROM Artigo, Cliente, Venda, LinhaVenda 
WHERE Cliente.idCliente = Venda.cliente AND 
Venda.idVenda = LinhaVenda.venda AND 
LinhaVenda.artigo = Artigo.idArtigo 
SELECT c.nome, v.data, a.nome 
FROM Artigo a, Cliente c, Venda v, LinhaVenda l 
WHERE c.idCliente = v.cliente AND 
v.idVenda = l.venda AND 
l.artigo = a.idArtigo 
SELECT c.nome, v.data 
FROM Cliente c 
INNER JOIN Venda v ON c.idCliente = v.cliente 
SELECT c.nome, v.data 
FROM Cliente c 
LEFT JOIN Venda v ON c.idCliente = v.cliente 
SELECT c.nome, v.data, SUM(l.quantidade*a.preco) AS Total 
FROM Artigo a, Cliente c, Venda v, LinhaVenda l 

WHERE c.idCliente = v.cliente AND v.idVenda = l.venda AND l.artigo = a.idArtigo  
GROUP BY c.nome, v.data 
SELECT TOP(1) c.nome, v.data 
FROM Artigo a, Cliente c, Venda v, LinhaVenda l 
WHERE c.idCliente = v.cliente AND v.idVenda = l.venda AND l.artigo = a.idArtigo 
ORDER BY v.data DESC 
 
SELECT c.codPostal, COUNT(c.codPostal) 
FROM Cliente c 
GROUP BY c.codPostal 
HAVING COUNT(c.codPostal) > 2; 
 
SELECT a.categoria, COUNT(a.nome) AS TotalArtigos 
FROM Artigo a 
GROUP BY a.categoria 
 
SELECT c.nome 
FROM Cliente c 
WHERE c.idCliente NOT IN (SELECT cliente FROM Venda) 
 
SELECT nome, (SELECT COUNT(*) FROM Venda WHERE Venda.cliente = Cliente.idCliente) 
FROM Cliente 
 
SELECT nome 
FROM Artigo 
WHERE preco >= ALL (SELECT preco 
FROM Artigo) 
 
SELECT nome 
FROM Artigo 
WHERE preco > ANY (SELECT preco 
FROM Artigo) 