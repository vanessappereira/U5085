/* Elabore um script em SQL que faça a criação de uma base de dados relacional em MySQL com
no mínimo duas tabelas. O script deve conter os seguintes conteúdos:
1. (5 val.)  Tabelas e índices
2. (5 val.)  Triggers
3. (5 val.)  Functions
4. (5 val.)  Procedures */

-- Criação da base de dados 
CREATE DATABASE IF NOT EXISTS biblioteca_db;
USE biblioteca_db;

-- Criação das tabelas 
CREATE TABLE IF NOT EXISTS autores (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS livros (
    livro_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor_id INT,
    ano_publicacao YEAR,
    stock INT NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES autores (autor_id)
);

-- Criação dos índices
CREATE INDEX idx_autor_nome ON autores (nome);
CREATE INDEX idx_livro_titulo ON livros (titulo);

-- Criação de triggers 
DELIMITER $$ 
CREATE TRIGGER before_insert_livro 
BEFORE INSERT ON livros 
FOR EACH ROW 
BEGIN 
    DECLARE autor_existe INT;
    SELECT COUNT(*) INTO autor_existe FROM autores WHERE autor_id = NEW.autor_id;
    IF autor_existe = 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Autor não encontrado';
    END IF;
END $$ 
DELIMITER;

-- Criação de funções 
DELIMITER $$ 
CREATE FUNCTION contar_livros_autor (p_autor_id INT) 
RETURNS INT 
DETERMINISTIC
BEGIN 
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM livros WHERE autor_id = p_autor_id;
    RETURN IFNULL(total, 0);
END $$
DELIMITER ;

-- Criação de procedures 
DELIMITER $$
CREATE PROCEDURE adicionar_autor (
    IN p_nome_autor VARCHAR(100),
    IN p_nacionalidade_autor VARCHAR(50)
) 
BEGIN
    INSERT INTO autores (nome, nacionalidade) VALUES (p_nome_autor, p_nacionalidade_autor);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE adicionar_livro (
    IN p_titulo_livro VARCHAR(100),
    IN p_autor_id_livro INT,
    IN p_ano_publicacao_livro YEAR,
    IN p_stock_livro INT
) 
BEGIN
    INSERT INTO livros (titulo, autor_id, ano_publicacao, stock)
    VALUES (p_titulo_livro, p_autor_id_livro, p_ano_publicacao_livro, p_stock_livro);
END $$
DELIMITER ;

-- Exemplo de uso das procedures
-- Adicionar autores
CALL adicionar_autor('George R.R. Martin', 'Americano');
CALL adicionar_autor('Isaac Asimov', 'Russo-Americano');
CALL adicionar_autor('Agatha Christie', 'Britânica');
CALL adicionar_autor('J.R.R. Tolkien', 'Britânico');

-- Adicionar livros
-- Autor 1 J. K. Rowling
CALL adicionar_livro('Harry Potter e a Câmara Secreta', 1, 1998, 8);
CALL adicionar_livro('Harry Potter e a Pedra Filosofal', 1, 1997, 50);
CALL adicionar_livro('Harry Potter e a Câmara Secreta', 1, 1998, 45);
CALL adicionar_livro('Harry Potter e o Prisioneiro de Azkaban', 1, 1999, 40);
CALL adicionar_livro('Harry Potter e o Cálice de Fogo', 1, 2000, 35);
CALL adicionar_livro('Harry Potter e a Ordem da Fênix', 1, 2003, 30);
CALL adicionar_livro('Harry Potter e o Enigma do Príncipe', 1, 2005, 25);
CALL adicionar_livro('Harry Potter e as Relíquias da Morte', 1, 2007, 20);
-- Autor 2 George R.R. Martin
CALL adicionar_livro('A Guerra dos Tronos', 2, 1996, 15);
CALL adicionar_livro('A Fúria dos Reis', 2, 1998, 12);
-- Autor 3 Isaac Asimov
CALL adicionar_livro('Fundação', 3, 1951, 5);
CALL adicionar_livro('Eu, Robô', 3, 1950, 7);
-- Autor 4 Agatha Christie
CALL adicionar_livro('Assassinato no Expresso do Oriente', 4, 1934, 6);
CALL adicionar_livro('Assassinato no Expresso do Oriente', 4, 1934, 40); 
CALL adicionar_livro('O Caso dos Dez Negrinhos', 4, 1939, 35); 
CALL adicionar_livro('Morte no Nilo', 4, 1937, 25); 
CALL adicionar_livro('O Assassinato de Roger Ackroyd', 4, 1926, 30); 
CALL adicionar_livro('Cai o Pano', 4, 1975, 20);
-- Autor 5 J.R.R. Tolkien
CALL adicionar_livro('O Hobbit', 5, 1937, 9);
CALL adicionar_livro('O Senhor dos Anéis: A Sociedade do Anel', 5, 1954, 4);
CALL adicionar_livro('O Senhor dos Anéis: As Duas Torres', 5, 1954, 4);
CALL adicionar_livro('O Senhor dos Anéis: O Retorno do Rei', 5, 1955, 3);
CALL adicionar_livro('O Silmarillion', 5, 1977, 5);
CALL adicionar_livro('Contos Inacabados', 5, 1980, 6);

-- Exemplo de uso da função
SELECT contar_livros_autor(1) AS total_livros_autor_1; -- Contar livros do autor J.K. Rowling
SELECT contar_livros_autor(2) AS total_livros_autor_2; -- Contar livros do autor George R.R. Martin
SELECT contar_livros_autor(4) AS total_livros_autor_4; -- Contar livros do autor Agatha Christie
SELECT contar_livros_autor(5) AS total_livros_autor_5; -- Contar livros do autor J.R.R. Tolkien