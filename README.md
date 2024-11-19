# U5085 - Criação de Estrutura de Base de Dados em SQL

## Ficha 1: Tabela e TRIGGERS

1. Crie a tabela `River_log` (id, modification, datetime, user) na base de dados `SalmonRiver`.
2. Crie os TRIGGERS necessários para o preenchimento da tabela `River_log` acionados depois de INSERT, UPDATE e DELETE.

## Ficha 2: Funções de Futebol

1. Construa uma função na base de dados `EuropeFootballLeagues` que devolva opcionalmente o número de jogos jogados em casa ou fora de casa para uma dada equipa.
2. Construa uma função na base de dados `EuropeFootballLeagues` que devolva opcionalmente o número de vitórias em casa ou fora de casa para uma dada equipa.

## Ficha 3: Validação de NIF

Crie uma função que determine se um número de contribuinte recebido como argumento é válido. A função deve devolver `true` se for válido ou `false` se for inválido.

### Exemplo de Cálculo

- **NIF**: 501903623
- **Cálculo**: 9x5 + 8x0 + 7x1 + 6x9 + 5x0 + 4x3 + 3x6 + 2x2 = 140
- **Resto**: 140 % 11 = 8
- **Check Digit**: 11 - 8 = 3
- O NIF é válido porque o resultado corresponde ao "check digit".

## Ficha 4: Validação de Cartão de Cidadão

1. Crie uma função que determine se um número de cartão de cidadão recebido como argumento é válido. A função deve devolver `true` se for válido ou `false` se for inválido.

## Ficha 5: Índices e Funções Diversas

1. Faça   a   criação   de   índices   para   as   tabelas  country(country),  city(city)   e  airport(airport,IATA_FAA,ICAO) da base de dados Airport.
2. Crie uma função que receba um número de um cartão de crédito. A função deve devolver uma String com os últimos 4 dígitos visíveis e os restantes dígitos substituídos por um asterisco.
3. Crie uma função que receba uma data e que calcule a idade em anos completos.
4. Crie uma função que receba um nome completo e que devolva uma String com o primeiro e último nome

## Trabalho Prático - Criação de estrutura e base de dados SQL

Elaborar um script em SQL que crie uma base de dados relacional em MySQL com, no mínimo, duas tabelas. O script deve incluir os seguintes elementos:

1. Tabelas e índices
2. Triggers
3. Functions
4. Procedures
