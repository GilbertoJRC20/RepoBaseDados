create table cliente (cliente_id int identity(1,1) primary key, nome text);
create table contrato (contrato_id int identity(1,1) primary key, data_inicio date, data_fim date, cliente_id int);
create table elevador (elevador_id int identity(1,1) primary key, contrato_id int, marca text);
create table visita (visita_id int identity(1,1) primary key, contrato_id int, data_visita date, tecnico_id int);
create table relatorio (relatorio_id int identity(1,1) primary key, elevador_id int, visita_id int);
create table proposta (proposta_id int identity(1,1) primary key, relatorio_id int, aceite bit);
create table pecas_proposta (proposta_id int not null, peca_id int not null, custo decimal(10,2));

alter table pecas_proposta 
add primary key (proposta_id, peca_id);
alter table contrato
add foreign key (cliente_id) references cliente(cliente_id);
alter table elevador
add foreign key (contrato_id) references contrato(contrato_id);
alter table visita
add foreign key (contrato_id) references contrato(contrato_id);
alter table relatorio
add foreign key (elevador_id) references elevador(elevador_id);
alter table relatorio
add foreign key (visita_id) references visita(visita_id);
alter table proposta
add foreign key (relatorio_id) references relatorio(relatorio_id);
alter table pecas_proposta
add foreign key (proposta_id) references proposta(proposta_id);

insert into cliente (nome) values ('Maria'), ('Manuel');
select * from cliente;
insert into contrato (data_inicio, data_fim, cliente_id) values ('2021-11-9', '2021-11-10', 1), ('2021-05-9', '2021-05-10', 2);
select * from contrato;
insert into elevador (contrato_id, marca) values (1,'XPTO'), (2,'XPTO10');
select * from elevador;
insert into visita (contrato_id, data_visita, tecnico_id) values (1,'2021-11-9', 101), (2,'2021-11-9', 102);
select * from visita;
insert into relatorio (elevador_id, visita_id) values (1,1);
select * from relatorio;
insert into proposta (relatorio_id, aceite) values (1,1);
select * from proposta;
insert into pecas_proposta (proposta_id, peca_id, custo) values (1,1005,10.3);
select * from pecas_proposta;


----tabelas----
select * from cliente;
select * from contrato;
select * from elevador;
select * from visita;
select * from relatorio;
select * from proposta;



----Exercício 6----

--a)
select c.nome, o.data_fim
from cliente c, contrato o
where c.cliente_id = o.cliente_id and o.data_fim > getdate();


-- b)
select count(o.contrato_id)
from contrato o
where o.cliente_id in (select c.cliente_id
	from cliente c, contrato o
	where c.cliente_id = o.cliente_id and data_fim > getdate()) and o.data_fim > getdate();

-- c) Os contratos que têm mais do que 1 elevador
insert into elevador (contrato_id, marca) values (1,'XPTO100'), (1,'XPTO200');
select * from elevador;

select o.contrato_id, count(e.elevador_id) 
from contrato o
inner join elevador e
on o.contrato_id=e.contrato_id
group by o.contrato_id
having count(e.elevador_id) > 1;

-- d) Quais os técnicos que fizeram intervenções no mês de Maio,
--	em contratos com mais do que um contrato?
select o.contrato_id, count(e.elevador_id)
from contrato o, elevador e
where o.contrato_id=e.contrato_id
group by o.contrato_id
having count(e.elevador_id) > 1

-- e)
update contrato
set data_fim='2025-03-01'
where contrato_id=1;

select o.contrato_id, count(e.elevador_id) 
from contrato o
inner join elevador e
on o.contrato_id=e.contrato_id
where o.data_fim > GETDATE() 
group by o.contrato_id
having count(e.elevador_id) > 1;

-- f)
select visita_id
from visita
where contrato_id in (select o.contrato_id
						from contrato o
						inner join elevador e
						on o.contrato_id=e.contrato_id
						where o.data_fim > GETDATE() 
						group by o.contrato_id
						having count(e.elevador_id) > 1)		

-- g)
select *
from visita
where contrato_id in (select o.contrato_id
						from contrato o
						inner join elevador e
						on o.contrato_id=e.contrato_id
						where o.data_fim > GETDATE() 
						group by o.contrato_id
						having count(e.elevador_id) > 1)

-- h)
select distinct tecnico_id
from visita
where contrato_id not in (select o.contrato_id
						from contrato o
						inner join elevador e
						on o.contrato_id=e.contrato_id
						group by o.contrato_id
						having count(e.elevador_id) > 1)

-- i)
select sum(pp.custo), o.contrato_id
from pecas_proposta pp, proposta p, relatorio r, elevador e, contrato o
where pp.proposta_id = p.proposta_id and p.relatorio_id=r.relatorio_id and
r.elevador_id=e.elevador_id and e.contrato_id=o.contrato_id and
o.contrato_id in (select o.contrato_id
from contrato o
where o.data_fim < getdate())
group by o.contrato_id;

-- j)
select count(v.visita_id), tecnico_id
from visita v
where v.data_visita between '2021-05-1' and '2021-12-30'
group by tecnico_id 

-- k) 
insert into visita (contrato_id, data_visita, tecnico_id) values (1,'2022-11-9', 101), (1,'2023-11-9', 101);
select * from visita;

-- Todos os técnicos
select distinct tecnico_id
from visita

-- Total de técnicos
select count(distinct tecnico_id)
from visita

-- Total de visitas
select count(visita_id)
from visita

-- Média de visitas
select count(visita_id)/count(distinct tecnico_id) 
from visita

-- Quais os técnicos com mais intervenções que a média dos técnicos, relativamente a Junho de 2020?
select tecnico_id, count(v.visita_id)
from visita v
where month(v.data_visita) = 6 and year(v.data_visita) = 2020
group by tecnico_id
having count(v.visita_id) > (select count(visita_id)/count(distinct tecnico_id) 
								from visita)

-- l)
select e.elevador_id
from pecas_proposta pp, proposta p, relatorio r, elevador e, contrato o, visita v
where pp.proposta_id = p.proposta_id and p.relatorio_id=r.relatorio_id and
r.elevador_id=e.elevador_id and e.contrato_id=o.contrato_id 
and v.contrato_id=o.contrato_id and
o.contrato_id in (select o.contrato_id
from contrato o
where o.data_fim > getDate())
group by e.elevador_id
having count(pp.peca_id)=0 and count(v.visita_id)=0;

-- m)
select count(e.elevador_id)
from elevador e, contrato o, visita v
where e.contrato_id=o.contrato_id and v.contrato_id=o.contrato_id and
o.contrato_id in (select o.contrato_id
from contrato o
where o.data_fim > getDate())
group by e.elevador_id
having count(v.visita_id)>1;

-- n)
select o.contrato_id, count(e.elevador_id)
from elevador e, contrato o, visita v
where e.contrato_id=o.contrato_id and v.contrato_id=o.contrato_id and
o.contrato_id in (select o.contrato_id
from contrato o
where o.data_fim > getDate())
group by o.contrato_id
order by 2;
								
-- Triggers


-- a)
CREATE TRIGGER VerificarDatasContratos ON contrato INSTEAD OF INSERT, UPDATE AS --
BEGIN
    DECLARE @cliente_id INT, @data_inicio DATE, @data_fim DATE;

    SELECT @cliente_id = cliente_id, @data_inicio = data_inicio, @data_fim = data_fim FROM inserted;

    IF @data_fim < @data_inicio
    BEGIN
        RAISERROR ('A data de fim não pode ser anterior à data de início.', 16, 1);
    END
    ELSE
    BEGIN
        -- Verificar se é um UPDATE ou INSERT verificando a existência do registo ou contrato ativo
        IF ((SELECT count(*) FROM contrato WHERE cliente_id = @cliente_id and data_inicio = @data_inicio) > 0) OR
			(SELECT count(*) FROM contrato WHERE cliente_id = @cliente_id and data_fim > GETDATE()) > 0
        BEGIN
            UPDATE contrato
            SET data_fim = @data_fim
            WHERE cliente_id = @cliente_id;
        END
        ELSE
        BEGIN
            INSERT INTO contrato (data_inicio, data_fim, cliente_id)
            SELECT data_inicio, data_fim, cliente_id from inserted;
        END
    END
END

insert into contrato (data_inicio, data_fim, cliente_id) values ('2024-11-9', '2023-11-10', 1); -- Tem de dar ERRO

insert into contrato (data_inicio, data_fim, cliente_id) values ('2024-11-9', '2026-11-10', 1); -- Tem ATUALIZAR
select * from contrato;