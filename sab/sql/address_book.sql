CREATE DATABASE s_address;
USE s_address;

CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    city VARCHAR(100),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO contacts (name, phone, email, address, city)
VALUES
('Alice Johnson', '9876543210', 'alice@example.com', '123 Main Street', 'New York'),
('Bob Martin', '9123456789', 'bobmartin@example.com', '45 Park Avenue', 'Chicago'),
('Charlie Lee', '9988776655', 'charlie@example.com', 'Sunset Blvd', 'Los Angeles'),
('David Miller', '9898989898', 'david@example.com', 'Palm Street', 'Miami'),
('Eve Adams', '9876501234', 'eve@example.com', 'Baker Street', 'New York');

CREATE TABLE address_details (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    contact_id INT,
    state VARCHAR(100),
    country VARCHAR(100),
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
);

INSERT INTO address_details (contact_id, state, country)
VALUES
(1, 'New York', 'USA'),
(2, 'Illinois', 'USA'),
(5, 'Texas', 'USA');

SELECT * FROM contacts;
SELECT name, phone FROM contacts;
SELECT DISTINCT city FROM contacts;
SELECT * FROM contacts WHERE city = 'New York';
SELECT * FROM contacts WHERE name='Alice Johnson' AND phone='9876543210';
SELECT * FROM contacts WHERE name='Alice Johnson' OR phone='9876543210';
SELECT * FROM contacts WHERE name IN ('Alice Johnson', 'Bob Martin');
SELECT * FROM contacts WHERE name LIKE 'A%';
SELECT * FROM contacts WHERE id BETWEEN 1 AND 2;
SELECT * FROM contacts WHERE phone LIKE '98%';
SELECT * FROM contacts WHERE email IS NULL;

UPDATE contacts
SET name = 'Alice Smith', phone = '9998887777', email = 'alice.smith@example.com', address = 'New Street, NY'
WHERE id = 1;
SELECT * FROM contacts;

DELETE FROM contacts WHERE id = 2;
SELECT * FROM contacts;

ALTER TABLE contacts
ADD COLUMN age INT;
ALTER TABLE contacts
MODIFY COLUMN phone VARCHAR(20);
ALTER TABLE contacts
CHANGE COLUMN phone mobile VARCHAR(20);
ALTER TABLE contacts
RENAME TO customers;
ALTER TABLE contacts
DROP COLUMN age;
ALTER TABLE contacts
ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE contacts
ADD PRIMARY KEY (id);
ALTER TABLE contacts
ALTER COLUMN address SET DEFAULT 'Not Provided';

SELECT * FROM contacts ORDER BY name ASC;
SELECT * FROM contacts ORDER BY name DESC;
SELECT * FROM contacts LIMIT 3;

SELECT city, COUNT(*) AS total_contacts
FROM contacts
GROUP BY city;

SELECT COUNT(*) FROM contacts;

SELECT address, COUNT(*) 
FROM contacts 
GROUP BY address
HAVING COUNT(*) > 0;

SELECT 
    contacts.name,
    contacts.city,
    address_details.state,
    address_details.country
FROM contacts
INNER JOIN address_details
ON contacts.id = address_details.contact_id;

SELECT 
    contacts.name,
    contacts.city,
    address_details.state,
    address_details.country
FROM contacts
LEFT JOIN address_details
ON contacts.id = address_details.contact_id;

SELECT 
    contacts.name,
    contacts.city,
    address_details.state,
    address_details.country
FROM contacts
RIGHT JOIN address_details
ON contacts.id = address_details.contact_id;

SELECT 
    contacts.name,
    contacts.city,
    address_details.state,
    address_details.country
FROM contacts
LEFT JOIN address_details
ON contacts.id = address_details.contact_id
UNION
SELECT 
    contacts.name,
    contacts.city,
    address_details.state,
    address_details.country
FROM contacts
RIGHT JOIN address_details
ON contacts.id = address_details.contact_id;

SELECT 
    address_details.country,
    COUNT(contacts.id) AS total_contacts
FROM contacts
INNER JOIN address_details
ON contacts.id = address_details.contact_id
GROUP BY address_details.country;

SHOW TABLES;
SHOW DATABASES;
DESC contacts;
TRUNCATE TABLE contacts;
DROP TABLE contacts;
DROP DATABASE s_address;