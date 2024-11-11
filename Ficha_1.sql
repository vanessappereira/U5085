CREATE DATABASE SalmonRiver;

USE SalmonRiver;

-- Crie a tabela Country
CREATE TABLE Country (
    ID INT AUTO_INCREMENT PRIMARY KEY ,
    Country VARCHAR(50)
);

-- Crie a tabela Category
CREATE TABLE Category (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(50)
);

-- Crie a tabela River
CREATE TABLE River (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Location VARCHAR(50),
    CountryID INT,
    CategoryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(ID),
    FOREIGN KEY (CategoryID) REFERENCES Category(ID)
);

-- Crie a tabela River_log(id,modification,datetime,user) na base de dados SalmonRiver.
CREATE TABLE River_log (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    modification VARCHAR(50) NOT NULL,
    datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    user VARCHAR(50) NOT NULL
);

--  Crie os TRIGGERS necessários para o preenchimento da tabela River_log acionados depois de INSERT,UPDATE e DELETE.
-- Trigger para INSERT
DELIMITER $ $ CREATE TRIGGER trg_insert_river
AFTER
INSERT
    ON River FOR EACH ROW BEGIN
INSERT INTO
    River_log (modification, user)
VALUES
    ('Inseriu novo rio: ' || New.Name, CURRENT_USER);

END $ $ DELIMITER;

-- Trigger para UPDATE
DELIMITER $ $ CREATE TRIGGER trg_River_Update
AFTER
UPDATE
    ON River FOR EACH ROW BEGIN
INSERT INTO
    River_log (modification, user)
VALUES
    (
        'Atualizou rio: ' || OLD.Name || ' to ' || NEW.Name,
        CURRENT_USER
    );

END $ $ DELIMITER;

-- Trigger para DELETE
DELIMITER $ $ CREATE TRIGGER trg_River_Delete
AFTER
    DELETE ON River FOR EACH ROW BEGIN
INSERT INTO
    River_log (modification, user)
VALUES
    ('Apagou rio: ' || OLD.Name, CURRENT_USER);

END $ $ DELIMITER;
