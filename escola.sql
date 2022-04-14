/*	
	1. Implementar um script SQL chamado ‘escola.sql’ com os comandos de criação do banco de dados escola. 
	Mais especificamente, o script deverá:
		a. Criar um banco de dados vazio chamado escola.
		b. Criar todas as tabelas que fazem parte do banco, a partir do modelo relacional.
		c. Definir as restrições de integridade referencial (chaves estrangeiras) nas tabelas necessárias.
		d. Definir as chaves primárias das tabelas.
		e. Definir as restrições de domínio de atributo.
		f. Conter comandos de inserção de dados em todas as tabelas. Os dados inseridos serão utilizados na etapa 2 do projeto.
*/

CREATE DATABASE IF NOT EXISTS escola;

USE escola;

-- SHOW TABLES; -- (COMANDO QUE MOSTRA QUAIS SÃO AS TABELAS QUE EXISTEM NO SEU BANCO DE DADOS)

-- -----------------------------------------------------
-- Table escola.aluno
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS aluno (
  cpf CHAR(11) NOT NULL,
  nome VARCHAR(45) NULL,
  telefone CHAR(11) NOT NULL UNIQUE,
  nascimento DATE NOT NULL,
  PRIMARY KEY (cpf)
  );
  
INSERT INTO aluno 
(cpf, nome, telefone, nascimento) 
VALUES 
('22222222222','BERNARDO GODOI','11666998855','1981-03-22'),
('33333333333','MARIANA FERREIRA','21888996677','1990-09-06'),
('44444444444','CAMILA MARIA','11999665588','1987-05-01'),
('55555555555','LENADRO MURTA','11555772244','1996-06-10'),
('66666666666','JUREMA VALÉRIA','21557772244','1979-01-20'),
('77777777777','OTÁVIO CUNHA','21447772244','1985-11-23'),
('88888888888','MARCELO MARINHO','21555333244','1981-10-15'),
('99999999999','PAULA SILVA','21555666444','1988-008-09'),
('10101010101','JOÃO NEVES','21333885566','1999-05-25');

SELECT * FROM aluno;

-- -----------------------------------------------------
-- Table escola.departamento
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS departamento (
  cod_departamento ENUM('I','II','III'),
  nome_departamento VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (cod_departamento)
  );

INSERT INTO departamento
(cod_departamento,nome_departamento) 
VALUES
('I','CIÊNCIAS EXATAS'),
('II','CIÊNCIAS BIOLÓGICAS'),
('III','CIÊNCIAS HUMANAS');

SELECT * FROM departamento;

-- -----------------------------------------------------
-- Table escola.curso
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS curso (
  codigo_curso INT NOT NULL,
  nome_curso VARCHAR(20) NOT NULL UNIQUE,
  descricao TEXT,
  PRIMARY KEY (codigo_curso)
  );

INSERT INTO curso 
(codigo_curso,nome_curso,descricao) 
VALUES
('11','MATEMÁTICA','AQUI SERÁ COLOCADO UMA DESCRIÇÃO DO CURSO DE MATEMÁTICA'),
('22','HISTÓRIA','AQUI SERÁ COLOCADO UMA DESCRIÇÃO DO CURSO DE HISTÓRIA'),
('33','BIOLOGIA','AQUI SERÁ COLOCADO UMA DESCRIÇÃO DO CURSO DE BIOLOGIA');

SELECT * FROM curso;

-- -----------------------------------------------------
-- Table escola.professor
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS professor (
  matricula_professor INT NOT NULL,
  nome VARCHAR(45) NULL,
  endereco VARCHAR(50) NOT NULL,
  telefone CHAR(11) NOT NULL UNIQUE,
  nascimento DATE NOT NULL,
  data_contratacao DATE NOT NULL,
  PRIMARY KEY (matricula_professor)
  );

INSERT INTO professor 
(matricula_professor,nome,endereco,telefone,nascimento,data_contratacao) 
VALUES 
('201701','SILVANA AMAVEL','RUA DAS FLORES, 123','11555772288','1996-06-10','2017-08-30'),
('201702','MARILIA SANTANA','RUA DAS ARVORES, 88','11558882211','1999-05-17','2017-06-30'),
('202001','ADRIANO SILVEIRA','RUA DOS PÁSSAROS, 7','11443331144','1992-02-28','2020-01-31'),
('202101','RONALDO MARIANO','RUA DAS MARGARIDAS, 15','21442211144','1990-12-13','2021-01-01');

SELECT * FROM professor;

-- -----------------------------------------------------
-- Table escola.disciplia
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS disciplina (
  cod_disciplina INT NOT NULL,
  creditos ENUM('2','3','4'),
  nome_disciplina VARCHAR(45) NULL UNIQUE,
  PRIMARY KEY (cod_disciplina)
  );

INSERT INTO disciplina 
(cod_disciplina,nome_disciplina,creditos)
VALUES
('1101','Cálculo','4'),
('1102','Álgebra','3'),
('1103','Noções de Estatística','2'),
('2201','Português','4'),
('2202','História Antiga','4'),
('2203','História da Educação','3'),
('3301','Genética','2'),
('4400','Trabalho Conclusão de Curso','4'),
('3302','Biologia Celular','4'),
('3303','Fauna, Flora e Ambiente','3');

SELECT * FROM disciplina;

-- -----------------------------------------------------
-- controla
-- -----------------------------------------------------

ALTER TABLE curso ADD cod_departamento ENUM('I','II','III');

ALTER TABLE curso 
ADD FOREIGN KEY (cod_departamento)
REFERENCES departamento(cod_departamento);

SELECT * FROM curso;

-- -----------------------------------------------------
-- matricula
-- -----------------------------------------------------

ALTER TABLE aluno ADD matriculado INT;

ALTER TABLE aluno 
ADD FOREIGN KEY (matriculado)
REFERENCES curso(codigo_curso);

SELECT * FROM aluno;

-- -----------------------------------------------------
-- cursa
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS cursa (
  cpf CHAR(11) NOT NULL,
  cod_disciplina INT NOT NULL,
  CONSTRAINT matricula PRIMARY KEY (cpf,cod_disciplina), 
  FOREIGN KEY (cpf) REFERENCES aluno(cpf),
  FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina)
  );

INSERT INTO cursa
(cpf,cod_disciplina) 
VALUES 
('11111111111','1101'),
('22222222222','2202'),
('22222222222','2203'),
('33333333333','3302'),
('33333333333','3303'),
('44444444444','4400'),
('55555555555','2201'),
('66666666666','1102'),
('66666666666','1103'),
('77777777777','4400'),
('88888888888','1103'),
('99999999999','2203'),
('99999999999','4400');

-- -----------------------------------------------------
-- pre_requisito
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS prerequisito (
  cod_disciplina INT NOT NULL,
  cod_dependencia INT NOT NULL,
  CONSTRAINT compoe PRIMARY KEY (cod_disciplina,cod_dependencia), 
  FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina),
  FOREIGN KEY (cod_dependencia) REFERENCES disciplina(cod_disciplina)
);

INSERT INTO prerequisito
(cod_disciplina,cod_dependencia)  
VALUES
('1102','1101'),
('1103','1101'),
('2202','2201'),
('2203','2201'),
('3302','3301'),
('3303','3301'),
('4400','1103'),
('4400','2203'),
('4400','3303');

-- -----------------------------------------------------
-- compoe
-- -----------------------------------------------------

ALTER TABLE disciplina ADD compoe INT;

ALTER TABLE disciplina 
ADD FOREIGN KEY (compoe)
REFERENCES curso(codigo_curso);

SELECT * FROM disciplina;

-- -----------------------------------------------------
-- leciona
-- -----------------------------------------------------

ALTER TABLE disciplina ADD leciona INT;

ALTER TABLE disciplina 
ADD FOREIGN KEY (leciona)
REFERENCES professor(matricula_professor);

SELECT * FROM disciplina;

-- -----------------------------------------------------
-- contrata
-- -----------------------------------------------------

ALTER TABLE professor ADD contatado_por ENUM('I','II','III');

ALTER TABLE professor 
ADD FOREIGN KEY (contatado_por)
REFERENCES departamento(cod_departamento);

SELECT * FROM professor;

-- -----------------------------------------------------
-- idade
-- -----------------------------------------------------
