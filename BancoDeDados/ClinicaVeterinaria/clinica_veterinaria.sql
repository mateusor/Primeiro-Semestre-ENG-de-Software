show databases;
USE BD170225428;
CREATE TABLE tutores_m (
id_tutor_m INT PRIMARY KEY,
nome_m VARCHAR(100),
telefone_m VARCHAR(15),
email_m VARCHAR(100),
endereco_m VARCHAR(150)
);

CREATE TABLE animais_m (
id_animal_m INT PRIMARY KEY,
nome_m VARCHAR(50),
especie_m VARCHAR(30),
raca_m VARCHAR(50),
idade_m INT,
peso_m DECIMAL(5,2),
sexo_m CHAR(1),
id_tutor_m INT,
FOREIGN KEY (id_tutor_m) REFERENCES tutores_m(id_tutor_m)
);

CREATE TABLE consultas_m (
id_consulta_m INT PRIMARY KEY,
id_animal_m INT,
data_consulta_m DATE,
procedimento_m VARCHAR(100),
valor_m DECIMAL(10,2),
retorno_m BOOLEAN,
FOREIGN KEY (id_animal_m) REFERENCES animais_m(id_animal_m)
);

INSERT INTO tutores_m (id_tutor_m, nome_m, telefone_m, email_m, endereco_m) VALUES
(1, 'Carlos Mendes', '11999887766', 'carlos@email.com', 'Rua das Flores, 123'),
(2, 'Ana Lúcia', '11988776655', 'ana@email.com', 'Av. Central, 456'),
(3, 'Juliana Silva', '11977665544', 'juliana@email.com', 'Rua Verde, 789'),
(4, 'Roberto Nunes', '11966554433', 'roberto@email.com', 'Travessa Sol, 321'),
(5, 'Fernanda Dias', '11955443322', 'fernanda@email.com', 'Alameda Azul, 852');

INSERT INTO animais_m (id_animal_m, nome_m, especie_m, raca_m, idade_m, peso_m, sexo_m, id_tutor_m) VALUES
(1, 'Toby', 'Cão', 'Labrador', 5, 28.5, 'M', 1),
(2, 'Mimi', 'Gato', 'Persa', 3, 4.2, 'F', 2),
(3, 'Rex', 'Cão', 'Vira-lata', 2, 12.7, 'M', 1),
(4, 'Luna', 'Gato', 'Siamês', 4, 5.1, 'F', 3),
(5, 'Bolinha', 'Cão', 'Poodle', 10, 7.8, 'F', 4),
(6, 'Thor', 'Cão', 'Husky', 6, 32.0, 'M', 5),
(7, 'Nina', 'Gato', 'Maine Coon', 2, 6.9, 'F', 3),
(8, 'Max', 'Cão', 'Bulldog', 4, 24.0, 'M', 4),
(9, 'Mel', 'Gato', 'SRD', 1, 3.5, 'F', 5),
(10, 'Bob', 'Cão', 'Beagle', 3, 10.2, 'M', 2);

INSERT INTO consultas_m (id_consulta_m, id_animal_m, data_consulta_m, procedimento_m, valor_m, retorno_m) VALUES
(1, 1, '2024-12-10', 'Vacinação Antirrábica', 80.0, False),
(2, 2, '2024-12-15', 'Consulta Rotina', 120.0, True),
(3, 3, '2025-01-10', 'Tratamento de pele', 200.0, False),
(4, 1, '2025-02-05', 'Retorno Vacinação', 0.0, False),
(5, 4, '2025-02-20', 'Exame de sangue', 150.0, True),
(6, 5, '2025-03-01', 'Consulta geriátrica', 160.0, True),
(7, 6, '2025-03-15', 'Cirurgia ortopédica', 800.0, False),
(8, 7, '2025-04-02', 'Tratamento vermífugo', 95.0, False),
(9, 8, '2025-04-10', 'Check-up', 180.0, True),
(10, 9, '2025-04-20', 'Consulta Rotina', 110.0, False),
(11, 10, '2025-04-25', 'Vacinação múltipla', 90.0, True),
(12, 2, '2025-05-05', 'Retorno Consulta', 0.0, False);

-- 1.
UPDATE animais_m 
SET peso_m = 33.5 
WHERE nome_m = 'Thor';

-- 2. 
DELETE FROM consultas_m 
WHERE id_consulta_m = 6;

-- 3. 
SELECT a.nome_m AS animal, t.nome_m AS tutor
FROM animais_m a
JOIN tutores_m t ON a.id_tutor_m = t.id_tutor_m;

-- 4. 
SELECT nome_m, especie_m, peso_m
FROM animais_m
WHERE peso_m > 25;

-- 5. 
UPDATE consultas_m c
INNER JOIN animais_m a ON c.id_animal_m = a.id_animal_m
SET c.retorno_m = TRUE
WHERE a.nome_m = 'Mimi';

-- 6.
DELETE FROM consultas_m
WHERE id_animal_m IN (
    SELECT id_animal_m FROM animais_m
    WHERE id_tutor_m IN (
        SELECT id_tutor_m FROM tutores_m
        WHERE nome_m = 'Juliana Silva'
    )
);

DELETE FROM animais_m
WHERE id_tutor_m IN (
    SELECT id_tutor_m FROM tutores_m
    WHERE nome_m = 'Juliana Silva'
);

-- 7.
SELECT a.nome_m, SUM(c.valor_m) AS total_gasto
FROM animais_m a
LEFT JOIN consultas_m c ON a.id_animal_m = c.id_animal_m
GROUP BY a.id_animal_m, a.nome_m;

-- 8. 
SELECT t.nome_m, COUNT(a.id_animal_m) AS quantidade_animais
FROM tutores_m t
LEFT JOIN animais_m a ON t.id_tutor_m = a.id_tutor_m
GROUP BY t.id_tutor_m, t.nome_m;

-- 9. 
UPDATE animais_m
SET idade_m = idade_m + 1
WHERE especie_m = 'Cão';

-- 10. 	
SELECT a.nome_m, c.data_consulta_m
FROM consultas_m c
JOIN animais_m a ON c.id_animal_m = a.id_animal_m
WHERE a.especie_m = 'Gato';