-- Criação do banco de dados para o cenário E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- Criar tabela cliente
CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Adress VARCHAR(30),
    CNPJ CHAR(14),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
 
    
    
);
ALTER TABLE cliente AUTO_INCREMENT = 1;



-- Inserir dados na tabela cliente
INSERT INTO cliente (Fname, Minit, Lname, CPF, Adress, CNPJ)
VALUES 
('Carlos', 'A.', 'Silva', '12345678901', 'Rua das Flores, 123', '11111111111111'),
('Ana', 'B.', 'Pereira', '98765432100', 'Avenida Brasil, 456', '22222222222222'),
('Marcos', 'C.', 'Santos', '45612378909', 'Rua do Sol, 789', '33333333333333');

-- Criar tabela payments
CREATE TABLE payments (
    idclient INT,
    idpayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Pix'),
    PRIMARY KEY (idclient, idpayment)
);

-- Inserir dados na tabela payments
INSERT INTO payments (idclient, idpayment, typePayment)
VALUES 
(1, 1, 'Pix'),
(2, 2, 'Cartão'),
(3, 3, 'Boleto');

-- Criar tabela product
CREATE TABLE product (
    idproduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10),
    Classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis') NOT NULL,
    Avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- Inserir dados na tabela product
INSERT INTO product (Pname, Classification_kids, category, Avaliacao, size)
VALUES 
('Celular', FALSE, 'Eletronico', 4.5, '10x5x1'),
('Camiseta', FALSE, 'Vestimenta', 4.0, 'M'),
('Boneca', TRUE, 'Brinquedos', 5.0, '20x10x5'),
('Chocolate', TRUE, 'Alimentos', 4.8, '100g');

-- Criar tabela orders
CREATE TABLE orders (
    idorder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    trackingCode VARCHAR(50),
    orderStatus ENUM('Cancelado', 'Confirmado', 'em processamento') NOT NULL,
    oderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES cliente(idCliente)
);

INSERT INTO cliente (Fname, Minit, Lname, CPF, Adress, clientType) 
VALUES ('Carlos', 'A.', 'Silva', '12345678901', 'Rua das Flores, 123', 'PF');

-- Inserir dados na tabela orders
INSERT INTO orders (idOrderClient, orderStatus, oderDescription, sendValue, paymentCash)
VALUES 
(1, 'Confirmado', 'Pedido de Eletrônicos', 15.0, TRUE),
(2, 'em processamento', 'Pedido de Roupas', 10.0, FALSE),
(3, 'Cancelado', 'Pedido de Brinquedos', 0.0, FALSE);

-- Criar tabela productOrder
CREATE TABLE productOrder (
    idProduct INT,
    idPOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('disponivel', 'Sem estoque') DEFAULT 'disponivel',
    PRIMARY KEY (idProduct, idPOrder),
    CONSTRAINT fk_productOrder_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productOrder_order FOREIGN KEY (idPOrder) REFERENCES orders(idorder)
);

-- Criar tabela productStorage
CREATE TABLE productStorage (
    idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

-- Criar tabela storageLocation
CREATE TABLE storageLocation (
    idProduct INT,
    idstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idProduct, idstorage),
    CONSTRAINT fk_storageLocation_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);



-- Criar tabela supplier
CREATE TABLE supplier (
    Idsupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- Inserir dados na tabela supplier
INSERT INTO supplier (SocialName, CNPJ, Contact)
VALUES 
('Fornecedor ABC', '55555555555555', '11987654321'),
('Fornecedor XYZ', '66666666666666', '11912345678');

-- Criar tabela seller
CREATE TABLE seller (
    Idseller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstractName VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(9),
    location VARCHAR(255),
    Contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- Criar tabela productSeller
CREATE TABLE productSeller (
    idPSeller INT,
    idProduct INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (idPSeller, idProduct),
    CONSTRAINT fk_productSeller_to_seller FOREIGN KEY (idPSeller) REFERENCES seller(IDseller),
    CONSTRAINT fk_productSeller_to_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

Use ecommerce;
-- Visualizar a estrutura da tabela productSeller
DESC productSeller;
Desc cliente

select * from orders;
select * from orders where orderstatus = "confirmado";

select count(*) from cliente;

select concat('fname','lname') as Client from cliente where fname like 'A%';



SELECT * FROM supplier where cnpj like '5%';

select count(*) from orders
		where orderStatus = 'Cancelado'

desc orders

SELECT 
    CASE 
        WHEN orderStatus = 'Confirmado' THEN 'Pedidos Confirmados'
        WHEN orderStatus = 'em processamento' THEN 'Pedidos Pendentes'
        ELSE 'Pedidos Cancelados'
    END AS CategoriaPedido,
    COUNT(*) AS TotalPedidos
FROM orders
GROUP BY CategoriaPedido;


SELECT * FROM orders
ORDER BY orderStatus;

SELECT idProduct, COUNT(poQuantity) AS totalQuantity
FROM productOrder
GROUP BY idProduct
HAVING COUNT(poQuantity) > 5;

ALTER TABLE cliente
ADD COLUMN clientType ENUM('PF', 'PJ') NOT NULL DEFAULT 'PF';

ALTER TABLE orders
ADD COLUMN Trackingcode varchar(50);



