use myfuncs;

DELIMITER $$
CREATE FUNCTION IF NOT EXISTS validar_NIF(nif VARCHAR(9))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE D1 INT;
    DECLARE D2 INT;
    DECLARE D3 INT;
    DECLARE D4 INT;
    DECLARE D5 INT;
    DECLARE D6 INT;
    DECLARE D7 INT;
    DECLARE D8 INT;
    DECLARE C INT;
    DECLARE total INT;
    DECLARE resto INT;
    DECLARE check_digit_esperado INT;

    -- Verifica se o NIF tem 9 caracteres e se todos são dígitos
    IF LENGTH(nif) != 9 OR nif NOT REGEXP '^[0-9]+$' THEN
        RETURN FALSE;
    END IF;

    -- Converter os dígitos para inteiros
    SET D1 = CAST(SUBSTRING(nif,1,1) AS UNSIGNED);
    SET D2 = CAST(SUBSTRING(nif,2,1) AS UNSIGNED);
    SET D3 = CAST(SUBSTRING(nif,3,1) AS UNSIGNED);
    SET D4 = CAST(SUBSTRING(nif,4,1) AS UNSIGNED);
    SET D5 = CAST(SUBSTRING(nif,5,1) AS UNSIGNED);
    SET D6 = CAST(SUBSTRING(nif,6,1) AS UNSIGNED);
    SET D7 = CAST(SUBSTRING(nif,7,1) AS UNSIGNED);
    SET D8 = CAST(SUBSTRING(nif,8,1) AS UNSIGNED);
    SET C = CAST(SUBSTRING(nif,9,1) AS UNSIGNED);

    -- Verifica se o NIF começa com um dos prefixos válidos
    IF NOT (LEFT(nif,1) IN (1,2,3,5,6)
    OR LEFT(nif,2) IN (45, 70, 71, 72, 74, 75, 77, 78, 79, 90, 91, 98, 99))
    THEN RETURN FALSE;
    END IF;

    -- Calcula o total conforme a fórmula fornecida
    SET total = 9*D1 + 8*D2  + 7*D3 + 6*D4 + 5*D5 + 4*D6 + 3*D7 + 2*D8;

    -- Calcula o resto da divisão por 11
    SET resto = total % 11;

    -- Determina o check digit esperado
    IF resto < 2 THEN
        SET check_digit_esperado = 0;
    ELSE
        SET check_digit_esperado = 11 - resto;
    END IF;

    -- Retorna se o check digit calculado corresponde ao fornecido
    RETURN check_digit_esperado = C;
END $$
DELIMITER ;