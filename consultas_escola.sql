/*	    
	2. Implementar um script SQL chamado ‘consultas_escola.sql’ com os comandos que respondam às seguintes consultas. :
        a. Produza um relatório que contenha os dados dos alunos matriculados em todos os cursos oferecidos pela escola.
        b. Produza um relatório com os dados de todos os cursos, com suas respectivas disciplinas, oferecidos pela escola.
        c. Produza um relatório que contenha o nome dos alunos e as disciplinas em que estão matriculados.
        d. Produza um relatório com os dados dos professores e as disciplinas que ministram.
        e. Produza um relatório com os nomes das disciplinas e seus pré-requisitos.
        f. Produza um relatório com a média de idade dos alunos matriculados em cada curso.
        g. Produza um relatório com os cursos oferecidos por cada departamento.

Entregar as consultas, bem como as respostas de cada uma em um arquivo separado ou organizado no mesmo arquivo.
O resultado da consulta pode ficar comentado após cada query.
Considere que:
    1. O SGBD adotado para o projeto deve ser o MySQL.
    2. Os scripts devem ser implementados de modo que sua execução seja direta e aconteça sem erros em qualquer ambiente MySQL.
    3. O domínio dos atributos (tipo de dados, formato, etc.) fica a critério do aluno.
    4. O aluno tem liberdade de criar novos atributos ou relações que julgar necessário para enriquecimento do modelo.
    5. Data de entrega do trabalho: 08/04/22.
    6. Enviar os scripts no class onde será criado uma tarefa a parteetapa 2 do projeto.
*/

USE escola;

-- -----------------------------------------------------
-- a. Produza um relatório que contenha os dados dos alunos matriculados em todos os cursos oferecidos pela escola.
-- -----------------------------------------------------

SELECT * FROM aluno
WHERE matriculado IS NOT NULL
ORDER BY nome;

-- -----------------------------------------------------
-- b. Produza um relatório com os dados de todos os cursos, com suas respectivas disciplinas, oferecidos pela escola.
-- -----------------------------------------------------

SELECT curso.nome_curso,  disciplina.cod_disciplina, disciplina.nome_disciplina
FROM disciplina JOIN curso
ON curso.codigo_curso = disciplina.compoe
ORDER BY curso.codigo_curso;

-- -----------------------------------------------------
-- c. Produza um relatório que contenha o nome dos alunos e as disciplinas em que estão matriculados.
-- -----------------------------------------------------

SELECT aluno.nome, cursa.cod_disciplina
FROM aluno JOIN cursa
ON aluno.cpf = cursa.cpf
ORDER BY aluno.nome;

-- -----------------------------------------------------
-- d. Produza um relatório com os dados dos professores e as disciplinas que ministram.
-- -----------------------------------------------------

SELECT professor.nome, disciplina.nome_disciplina
FROM disciplina JOIN professor
ON professor.matricula_professor = disciplina.leciona
ORDER BY professor.nome;

-- -----------------------------------------------------
-- e. Produza um relatório com os nomes das disciplinas e seus pré-requisitos. 
-- -----------------------------------------------------

SELECT disciplina.nome_disciplina, prerequisito.cod_dependencia
FROM disciplina JOIN prerequisito
ON disciplina.cod_disciplina = prerequisito.cod_disciplina
ORDER BY disciplina.cod_disciplina;

-- -----------------------------------------------------
-- f. Produza um relatório com a média de idade dos alunos matriculados em cada curso. 
-- -----------------------------------------------------

SELECT AVG(TIMESTAMPDIFF(year,nascimento,now())) AS 'media de idade'
FROM aluno;

-- -----------------------------------------------------
-- g. Produza um relatório com os cursos oferecidos por cada departamento. 
-- -----------------------------------------------------

SELECT cod_departamento, codigo_curso, nome_curso FROM curso
ORDER BY cod_departamento;