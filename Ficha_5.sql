-- 1. Faça a criação de índices para as tabelas country(country), city(city) e airport(airport, IATA_FAA,ICAO) da base de dados Airport.
-- Criar índice para a tabela country
CREATE INDEX idx_country ON country(country);
-- Criar índice para a tabela city
CREATE INDEX idx_city ON city(city);
-- Criar índice para a tabela airport
CREATE INDEX idx_airport ON airport(airport, IATA_FAA, ICAO);

-- 2. Crie uma função que receba um número de um cartão de crédito. A função deve devolver uma String com os últimos 4 dígitos visíveis e os restantes dígitos substituídos por um asterisco. Os cartões de crédito normalmente têm entre 13 e 16 dígitos
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS ocultarCartao(nrCartao VARCHAR(16))
RETURNS VARCHAR(16)
DETERMINISTIC
BEGIN
    DECLARE nrCartaoOculto VARCHAR(16);
   
    SET nrCartaoOculto = CONCAT(REPEAT('*', LENGTH(nrCartao) - 4), RIGHT(nrCartao, 4));
   
    RETURN nrCartaoOculto;
END $$
DELIMITER ;

-- 3. Crie uma função que receba uma data e que calcule a idade em anos completos.
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS calcularIdade(dataNascimento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;
   
    SET idade = TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE());
   
    RETURN idade;
END $$
DELIMITER ;

-- 4. Crie uma função que receba um nome completo e que devolva uma String com o primeiro e último nome.
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS getFNameLName(nomeCompleto VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE nome VARCHAR(60);
    DECLARE apelido VARCHAR(60);
    
    SET nome = SUBSTRING_INDEX(nomeCompleto, ' ', 1);
    SET apelido = SUBSTRING_INDEX(nomeCompleto, ' ', -1);

    RETURN CONCAT(nome, ' ', apelido);
END $$
DELIMITER ;