

DROP DATABASE IF EXISTS Loja;
CREATE DATABASE Loja;
USE Loja;

CREATE TABLE Cliente (
    ID_CLIENTE INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    TELEFONE VARCHAR(20),
    DATA_NASCIMENTO DATE,
    CIDADE VARCHAR(100),
    ESTADO CHAR(2),
    CRIADO_EM TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produto (
    ID_PRODUTO INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    CATEGORIA VARCHAR(50),
    PRECO DECIMAL(10,2) NOT NULL,
    CUSTO DECIMAL(10,2),
    ATIVO BOOLEAN DEFAULT TRUE
);

CREATE TABLE Pedido (
    ID_PEDIDO INT AUTO_INCREMENT PRIMARY KEY,
    ID_CLIENTE INT NOT NULL,
    DATA_PEDIDO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    STATUS VARCHAR(20) DEFAULT 'CRIADO',
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES Cliente(ID_CLIENTE)
);

CREATE TABLE Item_Pedido (
    ID_ITEM_PEDIDO INT AUTO_INCREMENT PRIMARY KEY,
    ID_PEDIDO INT NOT NULL,
    ID_PRODUTO INT NOT NULL,
    QUANTIDADE INT NOT NULL DEFAULT 1,
    PRECO_UNITARIO DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_pedido
        FOREIGN KEY (ID_PEDIDO)
        REFERENCES Pedido(ID_PEDIDO),
    CONSTRAINT fk_item_produto
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES Produto(ID_PRODUTO)
);


INSERT INTO Cliente (NOME, EMAIL, TELEFONE, DATA_NASCIMENTO, CIDADE, ESTADO) VALUES
('Paulo Cavalcante', 'paulo@gmail.com', '11999990001', '1994-08-12', 'São Paulo', 'SP'),
('Maria Silva',      'maria@gmail.com', '21999990002', '1998-02-03', 'Rio de Janeiro', 'RJ'),
('João Santos',      'joao@gmail.com',  '31999990003', '1990-11-25', 'Belo Horizonte', 'MG'),
('Ana Costa',        'ana@gmail.com',   '81999990004', '2000-06-18', 'Recife', 'PE'),
('Carla Lima',       'carla@gmail.com', '83999990005', '1996-01-09', 'João Pessoa', 'PB'),
('Rafael Souza',     'rafael@gmail.com','84999990006', '1992-09-30', 'Natal', 'RN'),
('Bruna Rocha',      'bruna@gmail.com', '71999990007', '1999-12-14', 'Salvador', 'BA'),
('Diego Alves',      'diego@gmail.com', '61999990008', '1988-04-22', 'Brasília', 'DF');


INSERT INTO Produto (NOME, CATEGORIA, PRECO, CUSTO, ATIVO) VALUES
('Mouse Gamer',           'Periféricos', 120.00, 70.00,  TRUE),
('Teclado Mecânico',      'Periféricos', 200.00, 120.00, TRUE),
('Headset USB',           'Áudio',       180.00, 95.00,  TRUE),
('Monitor 24"',           'Monitores',   899.90, 650.00, TRUE),
('Mousepad XL',           'Periféricos',  49.90, 18.00,  TRUE),
('SSD 1TB',               'Armazenamento',499.90, 360.00,TRUE),
('Cabo HDMI 2m',          'Acessórios',   29.90,  8.00,  TRUE),
('Webcam Full HD',        'Acessórios',  159.90, 90.00,  TRUE),
('Hub USB',               'Acessórios',   89.90, 45.00,  TRUE),
('Teclado Membrana',      'Periféricos',  79.90, 35.00,  TRUE),
('Mouse Sem Fio',         'Periféricos',  99.90, 55.00,  TRUE),
('Cadeira Gamer',         'Móveis',      1299.90, 920.00,TRUE);

INSERT INTO Pedido (ID_CLIENTE, STATUS) VALUES
(1, 'PAGO'),
(2, 'PAGO'),
(3, 'CRIADO'),
(4, 'ENVIADO'),
(5, 'PAGO'),
(6, 'CANCELADO'),
(7, 'PAGO'),
(8, 'PAGO'),
(1, 'ENVIADO'),
(2, 'PAGO');

INSERT INTO Item_Pedido (ID_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO_UNITARIO) VALUES
-- Pedido 1 (Paulo)
(1,  1, 2, 120.00),
(1,  5, 1,  49.90),
(1,  7, 2,  29.90),

-- Pedido 2 (Maria)
(2,  2, 1, 200.00),
(2,  3, 1, 180.00),

-- Pedido 3 (João) - ainda CRIADO
(3,  6, 1, 499.90),
(3,  7, 1,  29.90),

-- Pedido 4 (Ana) - ENVIADO
(4,  4, 1, 899.90),
(4,  7, 1,  29.90),
(4,  9, 1,  89.90),

-- Pedido 5 (Carla) - PAGO
(5,  8, 1, 159.90),
(5,  1, 1, 120.00),
(5, 11, 1,  99.90),

-- Pedido 6 (Rafael) - CANCELADO
(6, 12, 1, 1299.90),

-- Pedido 7 (Bruna) - PAGO
(7,  6, 2, 499.90),
(7,  2, 1, 200.00),
(7,  7, 3,  29.90),

-- Pedido 8 (Diego) - PAGO
(8,  4, 2, 899.90),
(8,  3, 1, 180.00),
(8,  5, 2,  49.90),

-- Pedido 9 (Paulo) - ENVIADO
(9, 10, 1,  79.90),
(9,  9, 1,  89.90),

-- Pedido 10 (Maria) - PAGO
(10, 11, 2,  99.90),
(10,  5, 1,  49.90);



SELECT
    c.NOME AS CLIENTE,
    c.CIDADE,
    c.ESTADO,
    p.ID_PEDIDO,
    p.DATA_PEDIDO,
    p.STATUS,
    pr.ID_PRODUTO,
    pr.NOME AS PRODUTO,
    pr.CATEGORIA,
    ip.QUANTIDADE,
    ip.PRECO_UNITARIO,
    (ip.QUANTIDADE * ip.PRECO_UNITARIO) AS TOTAL_ITEM
FROM Pedido p
JOIN Cliente c       ON c.ID_CLIENTE = p.ID_CLIENTE
JOIN Item_Pedido ip  ON ip.ID_PEDIDO = p.ID_PEDIDO
JOIN Produto pr      ON pr.ID_PRODUTO = ip.ID_PRODUTO
ORDER BY p.ID_PEDIDO, pr.NOME;


