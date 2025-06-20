CREATE TABLE republicas (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  endereco VARCHAR(255)
);

CREATE TABLE moradores (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100),
  republica_id INT
);

CREATE TABLE despesas (
  id INT PRIMARY KEY,
  descricao VARCHAR(100),
  valor DECIMAL(10,2),
  vencimento DATE,
  republica_id INT
);

CREATE TABLE pagamentos (
  id INT PRIMARY KEY,
  morador_id INT,
  despesa_id INT,
  valor_pago DECIMAL(10,2),
  data_pagamento DATE
);

CREATE TABLE divisao (
  id INT PRIMARY KEY,
  morador_id INT,
  despesa_id INT,
  valor_a_pagar DECIMAL(10,2)
);

-- Inserções nas tabelas

INSERT INTO republicas VALUES
(1, 'República Alfa', 'Rua A, 100'),
(2, 'República Beta', 'Rua B, 200'),
(3, 'República Gama', 'Rua C, 300'),
(4, 'República Delta', 'Rua D, 400'),
(5, 'República Épsilon', 'Rua E, 500'),
(6, 'República Zeta', 'Rua F, 600'),
(7, 'República Eta', 'Rua G, 700'),
(8, 'República Teta', 'Rua H, 800'),
(9, 'República Iota', 'Rua I, 900'),
(10, 'República Kapa', 'Rua J, 1000'),
(11, 'República Lambda', 'Rua K, 1100'),
(12, 'República Mi', 'Rua L, 1200'),
(13, 'República Ni', 'Rua M, 1300'),
(14, 'República Xi', 'Rua N, 1400'),
(15, 'República Omicron', 'Rua O, 1500');

INSERT INTO moradores VALUES
(1, 'João', 'joao@email.com', 1),
(2, 'Maria', 'maria@email.com', 1),
(3, 'Carlos', 'carlos@email.com', 1),
(4, 'Ana', 'ana@email.com', 2),
(5, 'Bruno', 'bruno@email.com', 2),
(6, 'Laura', 'laura@email.com', 3),
(7, 'Pedro', 'pedro@email.com', 4),
(8, 'Julia', 'julia@email.com', 5),
(9, 'Fernando', 'fernando@email.com', 6),
(10, 'Beatriz', 'beatriz@email.com', 7),
(11, 'Lucas', 'lucas@email.com', 8),
(12, 'Mariana', 'mariana@email.com', 9),
(13, 'Thiago', 'thiago@email.com', 10),
(14, 'Rafaela', 'rafaela@email.com', 11),
(15, 'Igor', 'igor@email.com', 12);

INSERT INTO despesas VALUES
(1, 'Aluguel', 1500.00, '2025-05-10', 1),
(2, 'Luz', 200.00, '2025-05-12', 1),
(3, 'Água', 180.00, '2025-05-15', 2),
(4, 'Internet', 250.00, '2025-05-08', 2),
(5, 'Faxina', 120.00, '2025-05-05', 3),
(6, 'Gás', 90.00, '2025-05-06', 4),
(7, 'Aluguel', 1700.00, '2025-05-10', 5),
(8, 'Luz', 220.00, '2025-05-12', 6),
(9, 'Água', 190.00, '2025-05-15', 7),
(10, 'Internet', 230.00, '2025-05-08', 8),
(11, 'Faxina', 130.00, '2025-05-05', 9),
(12, 'Gás', 85.00, '2025-05-06', 10),
(13, 'Manutenção', 300.00, '2025-05-07', 11),
(14, 'Condomínio', 400.00, '2025-05-03', 12),
(15, 'Seguro', 250.00, '2025-05-01', 13);

INSERT INTO pagamentos VALUES
(1, 1, 1, 500.00, '2025-05-02'),
(2, 2, 1, 500.00, '2025-05-03'),
(3, 3, 1, 500.00, '2025-05-04'),
(4, 4, 3, 90.00, '2025-05-06'),
(5, 5, 4, 125.00, '2025-05-07'),
(6, 6, 5, 120.00, '2025-05-06'),
(7, 7, 6, 90.00, '2025-05-06'),
(8, 8, 7, 850.00, '2025-05-08'),
(9, 9, 8, 110.00, '2025-05-09'),
(10, 10, 9, 190.00, '2025-05-10'),
(11, 11, 10, 230.00, '2025-05-11'),
(12, 12, 11, 130.00, '2025-05-12'),
(13, 13, 12, 85.00, '2025-05-13'),
(14, 14, 13, 150.00, '2025-05-14'),
(15, 15, 14, 400.00, '2025-05-15');

INSERT INTO divisao VALUES
(1, 1, 1, 500.00),
(2, 2, 1, 500.00),
(3, 3, 1, 500.00),
(4, 1, 2, 100.00),
(5, 2, 2, 100.00),
(6, 4, 3, 90.00),
(7, 5, 4, 125.00),
(8, 6, 5, 120.00),
(9, 7, 6, 90.00),
(10, 8, 7, 850.00),
(11, 9, 8, 110.00),
(12, 10, 9, 190.00),
(13, 11, 10, 230.00),
(14, 12, 11, 130.00),
(15, 13, 12, 85.00);

-- Consultas

SELECT m.nome AS morador, r.nome AS republica
FROM moradores m
JOIN republicas r ON m.republica_id = r.id;

SELECT d.descricao, d.valor, d.vencimento, r.nome AS republica
FROM despesas d
JOIN republicas r ON d.republica_id = r.id
WHERE r.nome = 'República Alfa';

SELECT m.nome AS morador, d.descricao AS despesa, p.valor_pago, p.data_pagamento
FROM pagamentos p
JOIN moradores m ON p.morador_id = m.id
JOIN despesas d ON p.despesa_id = d.id;

SELECT m.nome, SUM(p.valor_pago) AS total_pago
FROM pagamentos p
JOIN moradores m ON p.morador_id = m.id
GROUP BY m.nome;

SELECT r.nome AS republica, SUM(d.valor) AS total_despesas
FROM despesas d
JOIN republicas r ON d.republica_id = r.id  
GROUP BY r.nome;