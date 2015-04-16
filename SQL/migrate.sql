CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON bookstoredb.* TO 'user'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;

CREATE DATABASE bookstoredb;

 Use bookstoredb;

CREATE TABLE products (id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),  name VARCHAR(25), price DOUBLE(16,2), status INT, description TEXT);

CREATE TABLE customers (id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), firstname VARCHAR(25), lastname VARCHAR(25), email VARCHAR(50), UNIQUE KEY(email), password VARCHAR(50));

CREATE TABLE customer_orders (id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), order_no VARCHAR(25), customer_id INT NOT NULL, total DOUBLE(16,2), date DATE, FOREIGN KEY(customer_id) REFERENCES customer(id));

CREATE TABLE order_lines (id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), order_id INT NOT NULL, product_id INT NOT NULL, qty INT DEFAULT 1, unit_price DOUBLE(16,2), total_price DOUBLE(16,2),
FOREIGN KEY(order_id) REFERENCES customer_order(id), FOREIGN KEY(product_id) REFERENCES product(id));

INSERT INTO product (name, price, status, description) values ("Book1", 160.00, 1, "Book by author1");
INSERT INTO product (name, price, status, description) values ("Book2", 170.00, 1, "Book by author2");
INSERT INTO product (name, price, status, description) values ("Book3", 180.00, 1, "Book by author3");
INSERT INTO product (name, price, status, description) values ("Book4", 180.00, 1, "Book by author4");
INSERT INTO product (name, price, status, description) values ("Book5", 190.00, 1, "Book by author5");
