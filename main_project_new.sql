-- Курсовой проект по SQL таблицам на тему "строительный магазин"

-- Создаем базу данных
CREATE DATABASE hardware_store;

-- Начинаем работу в базе данных
USE hardware_store;

-- Ниже представлены: способ удаления уже существующей таблицы и создание новой
-- Кроме того работа с ключами по столбцу id, а также работа с базовами DDL- командами
DROP TABLE IF EXISTS products;
CREATE TABLE products(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(145) NOT NULL,
	model VARCHAR(145) NOT NULL
);

-- ниже представлен пример ввода данных в таблицу
INSERT INTO products
VALUES 
	(DEFAULT, 'Плитка напольная', 'Kerama Marazzi'),
	(DEFAULT, 'Плитка настенная', 'Kerama Marazzi'),
	(DEFAULT, 'Керамонгранит', 'Laparet'),
	(DEFAULT, 'Затирка цементная', 'Litokol Litochrom'),
	(DEFAULT, 'Затирка влагостойкая', 'GLOMS Fuga'),
	(DEFAULT, 'Ламинат', 'Kronostar Ecotec'),
	(DEFAULT, 'Штучный паркет', 'Alster'),
	(DEFAULT, 'Шпатель зубчатый нержавеющая сталь', 'Stayer'),
	(DEFAULT, 'Шпатель резиновый', 'Stayer'),
	(DEFAULT, 'Эластичная силиконовая затирка', 'CERESIT');

-- ниже представлены примеры элементарного вывода данных из таблицы, полностью всех данных, так и конкретных столбцов
SELECT * FROM products;
SELECT name, model FROM products;


-- Ниже представлены навыки работу с определением времени создания и обновления данных, а также работа с внешними ключами
DROP TABLE IF EXISTS warehouse;
CREATE TABLE warehouse(
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	if_exists BOOL DEFAULT TRUE,
	has_arrived DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_products DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY(product_id) REFERENCES products (id)
);

INSERT INTO warehouse 
VALUES
	(1, DEFAULT, DEFAULT, DEFAULT),
	(2, DEFAULT, DEFAULT, DEFAULT),
	(3, DEFAULT, DEFAULT, DEFAULT),
	(4, DEFAULT, DEFAULT, DEFAULT),
	(5, DEFAULT, DEFAULT, DEFAULT),
	(6, DEFAULT, DEFAULT, DEFAULT),
	(7, DEFAULT, DEFAULT, DEFAULT),
	(8, DEFAULT, DEFAULT, DEFAULT),
	(9, DEFAULT, DEFAULT, DEFAULT),
	(10, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM warehouse;

DROP TABLE IF EXISTS shop;
CREATE TABLE shop(
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(145) NOT NULL,
	model VARCHAR(145) NOT NULL,
	price BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY(product_id) REFERENCES products (id)
);

INSERT INTO shop
VALUES 
	(1, 'Плитка напольная', 'Kerama Marazzi', 3000),
	(2, 'Плитка настенная', 'Kerama Marazzi', 1800),
	(3, 'Керамонгранит', 'Laparet', 4200),
	(4, 'Затирка цементная', 'Litokol Litochrom', 300),
	(5, 'Затирка влагостойкая', 'GLOMS Fuga', 499),
	(6, 'Ламинат', 'Kronostar Ecotec', 700),
	(7, 'Штучный паркет', 'Alster', 1300),
	(8, 'Шпатель зубчатый нержавеющая сталь', 'Stayer', 420),
	(9, 'Шпатель резиновый', 'Stayer', 250),
	(10, 'Эластичная силиконовая затирка', 'CERESIT', 500);

SELECT * FROM shop;

-- !!! Не уверен, что корректно представляют в своей голове работу трех вышенаписанных таблиц по взаимодействию между собой по категории
-- продукт, то есть насколько корретно я связад между собой данные внешними ключами и смогут ли они взаимодействовать и взаимодоплнять 
-- друг друга. Буду благодарен, за критику и советы по улучшению данного блока. !!!


-- Ниже представлена работа с данными с уникальными ключами
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(145) NOT NULL,
	lastname VARCHAR(145) NOT NULL,
	phone_nubmer CHAR(11) UNIQUE NOT NULL,
	mail VARCHAR(145) UNIQUE NOT NULL
);

INSERT INTO users
VALUES 
	(DEFAULT, 'Leonid', 'Ivanov', '89112123344', 'leon@mail.ru'),
	(DEFAULT, 'Kirill', 'Subar', '89182123344', 'kirill@mail.ru'),
	(DEFAULT, 'Oleg', 'Tinkov', '89116666666', 'tinkov@mail.ru'),
	(DEFAULT, 'Anna', 'Ahmatova', '89112143344', 'ahmatsila@mail.ru'),
	(DEFAULT, 'Zagir', 'Talibov', '89112123124', 'talibchik@mail.ru'),
	(DEFAULT, 'Kira', 'Kupchenko', '89112124124', 'kkupch@mail.ru'),
	(DEFAULT, 'Daria', 'Pavlova', '89112232344', 'pavlova@mail.ru'),
	(DEFAULT, 'Alexander', 'Timchenko', '89117686344', 'timon@mail.ru'),
	(DEFAULT, 'Piter', 'Griffin', '89112123764', 'grifon@mail.ru'),
	(DEFAULT, 'Ekaterina', 'Klimova', '89189453344', 'ek_klim@mail.ru');

SELECT * FROM users;

-- Ниже представлен пример функции ENUM и работы с данными булево-типа, а также двойной внешний ключ
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	city VARCHAR(130),
	country VARCHAR(130),
	premium_acc BOOL DEFAULT FALSE,
	order_id BIGINT UNSIGNED,
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (order_id) REFERENCES orders (id)
);

INSERT INTO profiles
VALUES 
	(1, 'm', '1978-01-12', 'Kirov', 'Russia', DEFAULT, 3),
	(2, 'm', '2000-05-23', 'Moscow', 'Russia', DEFAULT, 2),
	(3, 'm', '1999-03-18', 'Moscow', 'Russia', DEFAULT, 1),
	(4, 'f', '1993-09-30', 'Kiev', 'Ukraine', DEFAULT, 4),
	(5, 'm', '2001-12-23', 'Saint-Petersburg', 'Russia', DEFAULT, 5),
	(6, 'f', '1977-02-16', 'Kharkov', 'Ukraine', DEFAULT, 6),
	(7, 'f', '1988-04-27', 'Voronezh', 'Russia', DEFAULT, 10),
	(8, 'm', '1997-06-13', 'Simferopol', 'Russia', DEFAULT, 9),
	(9, 'm', '1999-07-19', 'Evpatoria', 'Russia', DEFAULT, 7),
	(10, 'f', '1974-10-10', 'Rostov-on-Don', 'Russia', DEFAULT, 8);

SELECT * FROM profiles;

-- Ниже представлен пример работы с индексированием данных, но опять же я не уверен, что корректно применил данную процедуру в 
-- контексте таблицы
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	id SERIAL PRIMARY KEY,
	order_number BIGINT UNSIGNED UNIQUE NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	product_id BIGINT UNSIGNED NOT NULL,
	worker_id BIGINT UNSIGNED NOT NULL,
	INDEX order_number_idx (order_number),
	FOREIGN KEY (product_id) REFERENCES products (id),
	FOREIGN KEY (worker_id) REFERENCES workers (id)
);

INSERT INTO orders 
VALUES 
	(DEFAULT, 001, DEFAULT, DEFAULT, 10, 5),
	(DEFAULT, 002, DEFAULT, DEFAULT, 9, 1),
	(DEFAULT, 003, DEFAULT, DEFAULT, 8, 3),
	(DEFAULT, 004, DEFAULT, DEFAULT, 7, 4),
	(DEFAULT, 005, DEFAULT, DEFAULT, 6, 1),
	(DEFAULT, 006, DEFAULT, DEFAULT, 5, 1),
	(DEFAULT, 007, DEFAULT, DEFAULT, 4, 4),
	(DEFAULT, 008, DEFAULT, DEFAULT, 3, 2),
	(DEFAULT, 009, DEFAULT, DEFAULT, 3, 5),
	(DEFAULT, 010, DEFAULT, DEFAULT, 1, 5);

SELECT * FROM orders;

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
	id SERIAL NOT NULL, 
	name_supp VARCHAR(145) NOT NULL,
	start_work_with DATETIME DEFAULT CURRENT_TIMESTAMP,
	product_id BIGINT UNSIGNED NOT NULL,
	phone VARCHAR(11) UNIQUE NOT NULL, 
	email VARCHAR(145) UNIQUE NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products (id)
)

INSERT INTO suppliers 
VALUES 
	(DEFAULT, 'OOO "KERAMO MARAZZI" ', DEFAULT, 1, 89122443121, 'kerammarazzi@mail.ru'),
	(DEFAULT, 'OOO "KERAMO MARAZZI" ', DEFAULT, 2, 89122443122, 'kerammarazzi2@mail.ru'),
	(DEFAULT, 'OOO "LAPARET" ', DEFAULT, 3, 89992443122, 'LAPARET@mail.ru'),
	(DEFAULT, 'OOO "LITOCOL" ', DEFAULT, 4, 89122443188, 'LITOCOL@mail.ru'),
	(DEFAULT, 'OOO "GLOMS" ', DEFAULT, 5, 89112443123, 'GLOMS@mail.ru'),
	(DEFAULT, 'OOO "KRONOSTAR" ', DEFAULT, 6, 89122235122, 'KRONOSTAR@mail.ru'),
	(DEFAULT, 'OOO "Alster" ', DEFAULT, 7, 89122442367, 'alster@mail.ru'),
	(DEFAULT, 'OOO "Stayer" ', DEFAULT, 8, 89181111111, 'stayer@mail.ru'),
	(DEFAULT, 'OOO "Stayer" ', DEFAULT, 9, 89181111112, 'stayer2@mail.ru'),
	(DEFAULT, 'OOO "CERESIT" ', DEFAULT, 10, 89122443999, 'CERESIT@mail.ru');

SELECT * FROM suppliers;

DROP TABLE IF EXISTS workers;
CREATE TABLE workers(
	id SERIAL NOT NULL,
	firstname VARCHAR(145) NOT NULL,
	lastname VARCHAR(145) NOT NULL,
	position_work VARCHAR(145) NOT NULL,
	birthday DATE NOT NULL,
	start_work DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO workers
VALUES 
	(DEFAULT, 'Pavel', 'Torkunov', 'main seller', '1991-03-08', DEFAULT),
	(DEFAULT, 'Vladislav', 'Pavlov', 'director', '2001-03-04', DEFAULT),
	(DEFAULT, 'Anastasia', 'Andrejchenko', 'seller', '1999-12-25', DEFAULT),
	(DEFAULT, 'Eugen', 'Ridchenko', 'seller', '2000-01-01', DEFAULT),
	(DEFAULT, 'Natalia', 'Pavlova', 'manager', '1978-06-07', DEFAULT);
	
SELECT * FROM workers;