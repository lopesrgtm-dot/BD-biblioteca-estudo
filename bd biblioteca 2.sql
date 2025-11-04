create database bdBblioteca;

create table alunos
(
idAluno int auto_increment primary key,
nome varchar(255) not null,
tell varchar(255) not null,
dtNasc date
);

create table autores
(
idAutor int auto_increment primary key,
nome varchar(255) not null
);
 create table livros
 (
 idLivro int auto_increment primary key,
 titulo varchar(255) not null,
 genero varchar(255) not null,
 idAutor int,
 constraint fk_idAutor_livro foreign key (idAutor)
 references autores(idAutor),
 status ENUM ('emprestado','disponivel') not null
 );
 
 create table emprestimos
 (
 idEmprestimo int auto_increment primary key,
 dtEmprestimo date not null,
 idAluno int,
 constraint fk_idAluno_emprestimo foreign key (idAluno)
 references alunos(idAluno),
 idLivro int,
 constraint fk_idLivro_emprestimo foreign key (idLivro)
 references livros(idLivro),
 dtDevolucao date not null,
  status ENUM ('devolvido','em atraso', 'emprestado') not null
 );
 
select * from alunos;
select * from emprestimos;
select * from autores; 
select * from livros;
 
INSERT INTO Alunos (nome, tell, dtNasc) values
("Ana Beatriz Oliveira", "13912345678", "2004-03-15"),
("João Pedro Martins", "13998765432", "2003-07-22"),
("Larissa Costa Ferreira", "13987654321", "2005-11-09");

update alunos set nome='Ana Siva' where idaluno=1;
update alunos set tell='13991234567' where idaluno=1;
update alunos set dtNasc='2004-05-12' where idaluno=1;

update alunos set nome='Bruno Costa' where idaluno=2;
update alunos set tell='13998765432' where idaluno=2;
update alunos set dtNasc='2003-09-22' where idaluno=2;

update alunos set nome='Carla Souza' where idaluno=3;
update alunos set tell='13998765432' where idaluno=3;
update alunos set dtNasc='2005-01-10' where idaluno=3;

INSERT INTO Autores (nome) values
('Machado de Assis'),
('Clarice Lispector'),
('J.K Rowling'),
('Gerge Orwell');

INSERT INTO livros (Titulo, Genero, idAutor, Status) values
('Dom Casmurro', 'Romance', 1, 'Emprestado'),
('A Hora de Estrela', 'Ficção', 2, 'Disponivel'),
('Harry Potter e a Pedra Filosofal', 'Fantasia', 3, 'Emprestado'),
('1984', 'Distopia', 4, 'Disponivel'),
('Memórias Póstumas de Brás Cubas', 'Romance', 1, 'Disponivel');

select * from livros;
select * from emprestimos;
select * from alunos;

INSERT INTO Emprestimos (idAluno, idLivro, dtEmprestimo, dtDevolucao, status) VALUES
(1, 2, "2025-10-10", "2025-10-17", "Devolvido"),
(2, 1, "2025-10-15", "2025-10-22", "Emprestado"),
(3, 3, "2025-10-05", "2025-10-12", "Em Atraso");

 
 # organizar a tabela em forma alfabetica ou crescente 
 # SELECT coluna ou * FROM tabela ORDER BY coluna ASC
SELECT * FROM Alunos ORDER BY nome ASC;

 # organizar a tabela em forma alfabetica ou descrecente 
 # SELECT coluna ou * FROM tabela ORDER BY coluna DESC
SELECT * FROM Alunos ORDER BY nome DESC;

#organizei da data mais velha para mais nova, da pessoa com a idade maior para menor
SELECT * FROM Alunos ORDER BY dtNasc ASC;

#organizei da data mais nova para mais velha, da pessoa com a idade menor para maior
SELECT * FROM Alunos ORDER BY dtNasc DESC;
 
 #filtrar alunos que nasceram depois de 2004
select * FROM Alunos where dtNasc > "2004-12-31";


 #Quantos alunos nasceram em cada ano
 /*  Tradução e explicação linha por linha:
1. SELECT EXTRACT(YEAR FROM dtNasc) AS ano_nasc,
O que faz: Extrai apenas o ano da data de nascimento (dtNasc) de cada aluno.
Por que usar: Para agrupar os alunos por ano de nascimento.
AS ano_nasc: Dá um nome mais amigável à coluna resultante, chamada ano_nasc.
2. COUNT(*) AS total_alunos
O que faz: Conta quantos alunos existem em cada ano de nascimento.
AS total_alunos: Nomeia essa contagem como total_alunos.
3. FROM Alunos
O que faz: Indica que os dados estão vindo da tabela chamada Alunos.
4. GROUP BY EXTRACT(YEAR FROM dtNasc)
O que faz: Agrupa os registros por ano de nascimento.
Por que usar: Para que o COUNT(*) conte os alunos por ano, e não o total geral.
5. ORDER BY ano_nasc ASC;
O que faz: Ordena os resultados em ordem crescente de ano de nascimento.
ASC: Significa "Ascending" (crescente). Se fosse DESC, seria decrescente.
*/

SELECT EXTRACT(YEAR FROM dtNasc) AS ano_nasc,
       COUNT(*) AS total_alunos
FROM Alunos
GROUP BY extract(YEAR FROM dtNasc)
ORDER BY ano_nasc ASC;
 
 select * from livros;
 #listar todos os livros status disponiveis
 select * from livros where status = 'disponivel';               
 
 /* listar todos os livros emprestados, mais recentemente cadastrados primeiro (pelo id) */
 select * from livros where status = 'emprestado'  
 order by idLivro desc;
 
 #Mostrar todos os livros de um genero especifico 
 select * from livros where genero = 'fantasia';
 
 #quantos livros a por genero
select genero, count(genero) from livros group by (genero);

#quantos livros estao em cada status (Disponivel vs Emprestado)
select status, count(status) from livros group by (status);
 
 
 select * from emprestimos;
 #listar todos os emprestimos ainda em aberto (emprestado)
 select * from emprestimos where status = 'emprestado';
 
 #listar emprestimos atrasados, mostrando os mais antigos primeiro
  select * from emprestimos where status = 'em atraso'
  order by dtEmprestimo asc;
  
  #lisar emprestomos feitos em uma data especifica 15/10/2025
  select * from emprestimos where dtEmprestimo = '2025-10-15';
  
  #Quantos emprestimos existem por status 
  select status, count(status) as "quantidade" from emprestimos group by (status);
  
  /* SELECT status, COUNT(status) AS "quantidade"
Aqui você está pedindo para o banco de dados retornar duas colunas:
status: o valor da coluna status da tabela emprestimos.
COUNT(status): a contagem de quantas vezes cada status aparece.
 Essa contagem será exibida com o nome "quantidade". */
 
 #quantos emprestimos foram feitos em cada dia
 select dtEmprestimo , count(dtEmprestimo) as "quantidade" from emprestimos group by (dtEmprestimo);
 
  /*Explicação passo a passo:
SELECT dtEmprestimo, COUNT(dtEmprestimo) AS "quantidade"
Você está pedindo duas informações:
O valor da data de empréstimo (dtEmprestimo).
A quantidade de vezes que essa data aparece na tabela,
usando COUNT(dtEmprestimo), com o nome "quantidade".

FROM emprestimos
Os dados estão sendo buscados da tabela chamada emprestimos.

GROUP BY (dtEmprestimo)
Agrupa os registros por data de empréstimo. 
Ou seja, todos os registros que têm a mesma data serão agrupados juntos 
para que a contagem possa ser feita. */
 
#qual foi a maior data de devolução prevista para cada status
select status, max(dtDevolucao) as 'data devolucao' 
from emprestimos group by status;

/*SELECT status
Você está pedindo para mostrar os diferentes valores da coluna status da tabela emprestimos.
Por exemplo: "pendente", "concluído", "cancelado", etc.

MAX(dtDevolucao) AS 'data devolucao'
Aqui você está usando a função de agregação 
MAX() para encontrar a maior data de devolução (ou seja, 
a mais recente) dentro de cada grupo de status.
Essa data será exibida com o nome 'data devolucao'.

FROM emprestimos
Os dados estão sendo buscados da tabela chamada emprestimos.

GROUP BY status
Agrupa os registros da tabela com base nos diferentes valores da coluna status.
 Isso permite aplicar a função MAX() em cada grupo separadamente.
*/

#listar autores em ordem alfabetica de (z-a)
select * from autores;
SELECT * FROM autores ORDER BY nome DESC;

/*SELECT *d
Isso significa que você quer selecionar todas as colunas da tabela autores.

FROM autores
Indica que os dados estão sendo buscados da tabela chamada autores.

ORDER BY nome DESC
Aqui você está ordenando os resultados pela coluna nome, em ordem decrescente 
(DESC = descending).
Ou seja, os nomes serão exibidos do Z para o A. */


#Listar todos os autores que começem com letra "c"
select * from autores where nome LIKE "C%";

#Listar todos os autores que tenham "DE" no nome
select * from autores where nome LIKE "%DE%";

#Listar todos os autores que tenham a letra "W"
select * from autores where nome LIKE "%W%";

