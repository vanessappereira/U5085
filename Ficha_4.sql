-- Verificar se o número de documento tem o tamanho correto.
-- Substituir as letras pelos seus respectivos valores conforme a tabela de conversão.
-- Calcular o check digit conforme a lógica de validação.
-- Retornar true se o número for válido e false caso contrário.

use myfuncs;
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS validar_CartaoCidadao(nrDocumento VARCHAR(12))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE i INT;
    DECLARE soma INT DEFAULT 0;
    DECLARE segundoDigito BOOLEAN DEFAULT FALSE;
    DECLARE valor INT;

    -- Verificar se o tamanho do número de documento é de 12 caracteres
    IF LENGTH(nrDocumento) != 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tamanho inválido para número de documento.';
        RETURN FALSE;
    END IF;

    -- Substituir as letras pelos seus respectivos valores conforme a tabela de conversão.
    SET i = 12;
    WHILE i > 0 DO
        SET i = i - 1;
        SET valor = CASE
            WHEN SUBSTRING(nrDocumento, i + 1, 1) BETWEEN '0' AND '9'
                THEN CAST(SUBSTRING(nrDocumento, i + 1, 1) AS UNSIGNED)
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'A' THEN 10
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'B' THEN 11
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'C' THEN 12
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'D' THEN 13
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'E' THEN 14
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'F' THEN 15
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'G' THEN 16
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'H' THEN 17
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'I' THEN 18
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'J' THEN 19
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'K' THEN 20
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'L' THEN 21
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'M' THEN 22
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'N' THEN 23
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'O' THEN 24
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'P' THEN 25
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'Q' THEN 26
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'R' THEN 27
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'S' THEN 28
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'T' THEN 29
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'U' THEN 30
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'V' THEN 31
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'W' THEN 32
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'X' THEN 33
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'Y' THEN 34
            WHEN SUBSTRING(nrDocumento, i + 1, 1) = 'Z' THEN 35
            ELSE 0
        END;

        -- Calcular o check digit conforme a lógica de validação.
        IF segundoDigito THEN
            SET valor = valor * 2;
            IF valor >= 10 THEN
                SET valor = valor - 9;
            END IF;
        END IF;
            SET soma = soma + valor;
            SET segundoDigito = NOT segundoDigito;
    END WHILE;

    -- Verifica se a soma é múltipla de 10
    RETURN (soma % 10) = 0;
END $$
DELIMITER ;