SHOW DATABASES;
USE sustentabilidade;

CREATE TABLE registro_diario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    agua FLOAT NOT NULL,
    energia FLOAT NOT NULL,
    residuos_nao_reciclaveis FLOAT NOT NULL,
    residuos_reciclaveis FLOAT NOT NULL,
    transporte_publico BOOLEAN NOT NULL,
    bicicleta BOOLEAN NOT NULL,
    caminhada BOOLEAN NOT NULL,
    carro_combustivel BOOLEAN NOT NULL,
    carro_eletrico BOOLEAN NOT NULL,
    carona BOOLEAN NOT NULL,
    nivel_agua VARCHAR(255),
    nivel_energia VARCHAR(255),
    nivel_residuos VARCHAR(255),
    nivel_transporte VARCHAR(255),
    indice_sustentabilidade FLOAT
);

SELECT * FROM registro_diario;
