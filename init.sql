DROP DATABASE IF EXISTS ds_estore_db;
CREATE DATABASE ds_estore_db;
DROP USER IF EXISTS 'ds_estore_db'@'localhost';
CREATE USER 'ds_estore_db'@'localhost' IDENTIFIED BY 'ds_estore_db';
GRANT ALL ON ds_estore_db.* TO 'ds_estore_db'@'localhost';
USE ds_estore_db;


CREATE TABLE product (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  slug VARCHAR(128) NOT NULL,
  shortDescription VARCHAR(512) NOT NULL,
  description VARCHAR(2048) NOT NULL,
  sku VARCHAR(128) NOT NULL,
  price FLOAT NOT NULL,
  onsale BOOLEAN NOT NULL,
  onsalePrice FLOAT,
  externalUrl VARCHAR(2048),
  meta JSON,
  unavailable BOOLEAN DEFAULT FALSE,
  productImage VARCHAR(2048),
  createdAt DATETIME DEFAULT NOW(),
  modifiedAt DATETIME
);

CREATE TABLE category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  slug VARCHAR(128) NOT NULL,
  shortDescription VARCHAR(512) NOT NULL,
  description VARCHAR(2048) NOT NULL,
  meta JSON,
  categoryImage VARCHAR(2048),
  createdAt DATETIME DEFAULT NOW(),
  modifiedAt DATETIME
);

CREATE TABLE tag (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  slug VARCHAR(128) NOT NULL,
  meta JSON,
  createdAt DATETIME DEFAULT NOW(),
  modifiedAt DATETIME
);

CREATE TABLE `order` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  address VARCHAR(128) NOT NULL,
  state VARCHAR(128) NOT NULL,
  country VARCHAR(128) NOT NULL,
  town VARCHAR(128) NOT NULL,
  phone VARCHAR(24) NOT NULL,
  email VARCHAR(320) NOT NULL,
  zipCode VARCHAR(24) NOT NULL,
  note TEXT,
  meta JSON,
  closed DATETIME,
  createdAt DATETIME DEFAULT NOW(),
  modifiedAt DATETIME
);

CREATE TABLE parent_category_links (
  id INT AUTO_INCREMENT PRIMARY KEY,
  parentCategoryId INT,
  childCategoryId INT,
  FOREIGN KEY (parentCategoryId) REFERENCES category(id),
  FOREIGN KEY (childCategoryId) REFERENCES category(id)
);

CREATE TABLE order_products_links (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orderId INT,
  productId INT,
  amount INT,
  FOREIGN KEY (orderId) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES `product`(id) ON DELETE CASCADE
);



CREATE TABLE product_category_links (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoryId INT,
  productId INT,
  FOREIGN KEY (categoryId) REFERENCES category(id),
  FOREIGN KEY (productId) REFERENCES product(id)
);

CREATE TABLE product_tag_links (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tagId INT,
  productId INT,
  FOREIGN KEY (tagId) REFERENCES tag(id),
  FOREIGN KEY (productId) REFERENCES product(id)
);

