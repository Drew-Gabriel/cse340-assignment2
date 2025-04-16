-- Create ENUM type
CREATE TYPE account_type_enum AS ENUM ('Client', 'Admin');

-- Create account table
CREATE TABLE account (
  account_id SERIAL PRIMARY KEY,
  account_firstname VARCHAR(255) NOT NULL,
  account_lastname VARCHAR(255) NOT NULL,
  account_email VARCHAR(255) UNIQUE NOT NULL,
  account_password VARCHAR(255) NOT NULL,
  account_type account_type_enum DEFAULT 'Client'
);

-- Create classification table
CREATE TABLE classification (
  classification_id SERIAL PRIMARY KEY,
  classification_name VARCHAR(255) UNIQUE NOT NULL
);

-- Create inventory table
CREATE TABLE inventory (
  inv_id SERIAL PRIMARY KEY,
  inv_make VARCHAR(255) NOT NULL,
  inv_model VARCHAR(255) NOT NULL,
  inv_year INT NOT NULL,
  inv_description TEXT NOT NULL,
  inv_image TEXT NOT NULL,
  inv_thumbnail TEXT NOT NULL,
  inv_price NUMERIC(10,2) NOT NULL,
  inv_miles INT NOT NULL,
  inv_color VARCHAR(50) NOT NULL,
  classification_id INT REFERENCES classification(classification_id)
);

-- Insert data into classification
INSERT INTO classification (classification_name)
VALUES 
  ('SUV'),
  ('Sport'),
  ('Truck');

-- Insert data into inventory
INSERT INTO inventory (
  inv_make, inv_model, inv_year, inv_description,
  inv_image, inv_thumbnail, inv_price, inv_miles,
  inv_color, classification_id
) VALUES 
  ('GM', 'Hummer', 2021, 'Known for small interiors and powerful performance.',
   '/images/hummer.jpg', '/images/hummer-thumb.jpg', 65000.00, 12000, 'Black', 1),

  ('Ford', 'Mustang', 2022, 'Fast and sporty with modern features.',
   '/images/mustang.jpg', '/images/mustang-thumb.jpg', 55000.00, 5000, 'Red', 2),

  ('Chevy', 'Camaro', 2020, 'Classic muscle car for sport lovers.',
   '/images/camaro.jpg', '/images/camaro-thumb.jpg', 48000.00, 8000, 'Blue', 2);

-- TASK 1 QUERY 4: Update GM Hummer description
UPDATE inventory
SET inv_description = REPLACE(inv_description, 'small interiors', 'a huge interior')
WHERE inv_make = 'GM' AND inv_model = 'Hummer';

-- TASK 1 QUERY 6: Update image paths
UPDATE inventory
SET 
  inv_image = REPLACE(inv_image, '/images/', '/images/vehicles/'),
  inv_thumbnail = REPLACE(inv_thumbnail, '/images/', '/images/vehicles/');

