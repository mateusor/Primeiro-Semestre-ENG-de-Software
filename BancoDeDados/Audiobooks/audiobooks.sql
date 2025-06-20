SHOW DATABASES;

USE BD170225428;

-- Resolução exercício 1:
CREATE TABLE autores_m (id_autor_m INT PRIMARY KEY, nome_m VARCHAR(100), nacionalidade_m VARCHAR(50));

-- Resolução exercício 2:
CREATE TABLE editoras_m (id_editora_m INT PRIMARY KEY, nome_m VARCHAR(100), pais_m VARCHAR(50));

-- Resolução exercício 3:
CREATE TABLE audiobooks_m (id_audiobook_m INT PRIMARY KEY, titulo_m VARCHAR(150), genero_m VARCHAR(50), id_autor_m INT, id_editora_m INT);

-- Resolução exercício 4:
ALTER TABLE audiobooks_m ADD CONSTRAINT fk_autor_m FOREIGN KEY (id_autor_m) REFERENCES autores_m(id_autor_m);

-- Resolução exercício 5:
ALTER TABLE audiobooks_m ADD CONSTRAINT fk_editora_m FOREIGN KEY (id_editora_m) REFERENCES editoras_m(id_editora_m);

-- Resolução exercício 6:
ALTER TABLE audiobooks_m ADD duracao_m INT;

-- Resolução exercício 7:
ALTER TABLE audiobooks_m ADD data_lancamento_m DATE;

-- Resolução exercício 8:
INSERT INTO autores_m (id_autor_m, nome_m, nacionalidade_m) VALUES (1, 'Machado de Assis', 'Brasileira');

-- Resolução exercício 9:
INSERT INTO editoras_m (id_editora_m, nome_m, pais_m) VALUES (1, 'Editora Brasil', 'Brasil');

-- Resolução exercício 10:
INSERT INTO audiobooks_m (id_audiobook_m, titulo_m, genero_m, id_autor_m, id_editora_m, duracao_m, data_lancamento_m) VALUES (1, 'Dom Casmurro', 'Romance', 1, 1, 480, '1899-01-01');

-- Resolução exercício 11:
INSERT INTO autores_m (id_autor_m, nome_m, nacionalidade_m) VALUES (2, 'Douglas Adams', 'Britânica');

-- Resolução exercício 12:
INSERT INTO audiobooks_m (id_audiobook_m, titulo_m, genero_m, id_autor_m, id_editora_m, duracao_m, data_lancamento_m) VALUES (2, 'O Guia do Mochileiro das Galáxias', 'Ficção Científica', 2, 1, 700, '1979-10-12');

-- Resolução exercício 13:
ALTER TABLE audiobooks_m DROP CONSTRAINT fk_editora_m;

-- Resolução exercício 14:
ALTER TABLE audiobooks_m DROP COLUMN id_editora_m;

-- Resolução exercício 15:
DROP TABLE editoras_m;
