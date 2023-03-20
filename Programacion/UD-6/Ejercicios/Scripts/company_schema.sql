

USE company_db;
CREATE TABLE regions (
  region_id INT AUTO_INCREMENT PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE countries (
  country_id CHAR(2) PRIMARY KEY,
  country_name VARCHAR(40) NOT NULL,
  region_id int,
  CONSTRAINT fk_countries_regions FOREIGN KEY(region_id) REFERENCES regions(region_id) ON DELETE CASCADE
);

CREATE TABLE locations (
  location_id INT AUTO_INCREMENT PRIMARY KEY,
  address VARCHAR(255) NOT NULL,
  postal_code VARCHAR(20),
  city VARCHAR(50),
  state VARCHAR(50),
  country_id CHAR(2),
  CONSTRAINT fk_locations_countries FOREIGN KEY(country_id) REFERENCES countries(country_id) ON DELETE CASCADE
);

CREATE TABLE warehouses (
  warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
  warehouse_name VARCHAR(255),
  location_id INT,
  CONSTRAINT fk_warehouses_locations FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  hire_date DATE NOT NULL,
  manager_id INT,
  -- fk
  job_title VARCHAR(255) NOT NULL,
  CONSTRAINT fk_employees_manager FOREIGN KEY(manager_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE product_categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  description VARCHAR(2000),
  standard_cost DECIMAL(9, 2),
  list_price DECIMAL(9, 2),
  category_id INT NOT NULL,
  CONSTRAINT fk_products_categories FOREIGN KEY(category_id) REFERENCES product_categories(category_id) ON DELETE CASCADE
);

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  website VARCHAR(255),
  credit_limit DECIMAL(8, 2)
);

CREATE TABLE contacts (
  contact_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  customer_id INT,
  CONSTRAINT fk_contacts_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  status VARCHAR(20) NOT NULL,
  salesman_id INT,
  order_date DATE NOT NULL,
  CONSTRAINT fk_orders_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
  CONSTRAINT fk_orders_employees FOREIGN KEY(salesman_id) REFERENCES employees(employee_id) ON DELETE
  SET NULL
);

CREATE TABLE order_items (
  order_id INT,
  item_id INT,
  product_id INT NOT NULL,
  quantity DECIMAL(8, 2) NOT NULL,
  unit_price DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY(order_id, item_id),
  CONSTRAINT fk_order_items_products FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_orders FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

CREATE TABLE inventories (
  product_id INT,
  warehouse_id INT,
  quantity INT NOT NULL,
  PRIMARY KEY(product_id, warehouse_id),
  CONSTRAINT fk_inventories_products FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE,
  CONSTRAINT fk_inventories_warehouses FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE
);