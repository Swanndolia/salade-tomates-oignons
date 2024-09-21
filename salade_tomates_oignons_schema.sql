------------------------------------------------------------
--        Script PostgreSQL (V2)
------------------------------------------------------------



------------------------------------------------------------
-- Schema
------------------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS salade_tomates_oignons;



------------------------------------------------------------
-- Table (Entity): account (V2)
------------------------------------------------------------
 CREATE TABLE IF NOT EXISTS account(
   account_id UUID  ,
   username VARCHAR(20)  NOT NULL,
   mail VARCHAR(50)  NOT NULL,
   account_password VARCHAR(64)  NOT NULL,
   default_serving INTEGER DEFAULT 4,
   avatar VARCHAR(500) ,
   account_admin BOOLEAN DEFAULT FALSE ,
   PRIMARY KEY(account_id),
   UNIQUE(mail)
);



------------------------------------------------------------
-- Table (Entity): account (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account(
--   account_id UUID  ,
--   username VARCHAR(20)  NOT NULL,
--   mail VARCHAR(50)  NOT NULL,
--   account_password VARCHAR(64)  NOT NULL,
--   PRIMARY KEY(account_id),
--   UNIQUE(mail)
--);



------------------------------------------------------------
-- Table (Entity): account_user (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account_user(
--   account_id UUID  ,
--   default_serving INTEGER,
--   avatar VARCHAR(500) ,
--   PRIMARY KEY(account_id),
--   FOREIGN KEY(account_id) REFERENCES account(account_id)
--);



------------------------------------------------------------
-- Table (Entity): account_admin (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account_admin(
--   account_id UUID  ,
--   PRIMARY KEY(account_id),
--   FOREIGN KEY(account_id) REFERENCES account(account_id)
--);



------------------------------------------------------------
-- Table (Entity): recipe
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipe(
   recipe_id UUID  ,
   recipe_label VARCHAR(60)  NOT NULL,
   recipe_public BOOLEAN DEFAULT FALSE,
   instruction TEXT NOT NULL,
   duration INTEGER,
   recipe_picture VARCHAR(500) ,
   account_id UUID   NOT NULL,
   PRIMARY KEY(recipe_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id)
);



------------------------------------------------------------
-- Table (Entity): unit
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS unit(
   unit_id UUID  ,
   unit_label VARCHAR(20)  NOT NULL,
   PRIMARY KEY(unit_id),
   UNIQUE(unit_label)
);



------------------------------------------------------------
-- Table (Entity): animal
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS animal(
   animal_id UUID  ,
   animal_label VARCHAR(20)  NOT NULL,
   PRIMARY KEY(animal_id),
   UNIQUE(animal_label)
);



------------------------------------------------------------
-- Table (Entity): ingredient
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ingredient(
   ingredient_id UUID  ,
   ingredient_label VARCHAR(20)  NOT NULL,
   vegetarian BOOLEAN NOT NULL,
   vegan BOOLEAN NOT NULL,
   gluten_free BOOLEAN NOT NULL,
   lactose_free BOOLEAN NOT NULL,
   calorie INTEGER NOT NULL,
   animal_id UUID  ,
   unit_id UUID   NOT NULL,
   PRIMARY KEY(ingredient_id),
   FOREIGN KEY(animal_id) REFERENCES animal(animal_id),
   FOREIGN KEY(unit_id) REFERENCES unit(unit_id)
);



------------------------------------------------------------
-- Table (Relation): add_fridge
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS add_fridge(
   account_id UUID  ,
   ingredient_id UUID  ,
   add_fridge_quantity INTEGER NOT NULL,
   PRIMARY KEY(account_id, ingredient_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id)
);



------------------------------------------------------------
-- Table (Relation): compose
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS compose(
   recipe_id UUID  ,
   ingredient_id UUID  ,
   quantity DOUBLE PRECISION NOT NULL,
   consumed BOOLEAN NOT NULL,
   PRIMARY KEY(recipe_id, ingredient_id),
   FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id)
);



------------------------------------------------------------
-- Table (Relation): filter_ingredient
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filter_ingredient(
   account_id UUID  ,
   ingredient_id UUID  ,
   PRIMARY KEY(account_id, ingredient_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id)
);



------------------------------------------------------------
-- Table (Relation): filter_recipe
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filter_recipe(
   account_id UUID  ,
   recipe_id UUID  ,
   rating INTEGER,
   favorite BOOLEAN,
   PRIMARY KEY(account_id, recipe_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id),
   FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
);

  INSERT INTO unit(unit_id, unit_label) VALUES
  ('886ef1ff-004d-4446-b8b5-37fd9d9e8710', 'g'),
  ('9a7b330d-a7cc-4c32-9d69-a6983b01bfb5', 'kg'),
  ('b5c07b4d-1a7b-4b8f-8b4a-93d6c2c8db4a', 'l'),
  ('c3f7e8d9-5a6b-4c1d-9e2f-8b7a6b5c4d3e', 'ml'),
  ('d2e1f0a9-8b7c-4d6e-5f4a-3c2b1a0d9e8f', 'pc'),
  ('f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9', 'cl');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Pomme', TRUE, TRUE, TRUE, TRUE, 52, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Banane', TRUE, TRUE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Orange', TRUE, TRUE, TRUE, TRUE, 47, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Fraise', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Framboise', TRUE, TRUE, TRUE, TRUE, 53, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Myrtille', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pêche', TRUE, TRUE, TRUE, TRUE, 39, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Abricot', TRUE, TRUE, TRUE, TRUE, 49, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poire', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Raisin', TRUE, TRUE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cerise', TRUE, TRUE, TRUE, TRUE, 63, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Ananas', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mangue', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Kiwi', TRUE, TRUE, TRUE, TRUE, 93, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Melon', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pastèque', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Citron', TRUE, TRUE, TRUE, TRUE, 29, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lime', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pamplemousse', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Grenade', TRUE, TRUE, TRUE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Carotte', TRUE, TRUE, TRUE, TRUE, 85, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tomate', TRUE, TRUE, TRUE, TRUE, 18, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Concombre', TRUE, TRUE, TRUE, TRUE, 15, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poivron', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Aubergine', TRUE, TRUE, TRUE, TRUE, 24, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Courgette', TRUE, TRUE, TRUE, TRUE, 17, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Brocoli', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Chou-fleur', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Épinard', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Laitue', TRUE, TRUE, TRUE, TRUE, 11, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Oignon', TRUE, TRUE, TRUE, TRUE, 40, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Ail', TRUE, TRUE, TRUE, TRUE, 133, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pomme de terre', TRUE, TRUE, TRUE, TRUE, 93, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Patate douce', TRUE, TRUE, TRUE, TRUE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Maïs', TRUE, TRUE, TRUE, TRUE, 108, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Haricot vert', TRUE, TRUE, TRUE, TRUE, 31, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pois', TRUE, TRUE, TRUE, TRUE, 74, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Asperge', TRUE, TRUE, TRUE, TRUE, 20, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Champignon', TRUE, TRUE, TRUE, TRUE, 21, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Betterave', TRUE, TRUE, TRUE, TRUE, 43, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Céleri', TRUE, TRUE, TRUE, TRUE, 16, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poireau', TRUE, TRUE, TRUE, TRUE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Radis', TRUE, TRUE, TRUE, TRUE, 14, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Navet', TRUE, TRUE, TRUE, TRUE, 22, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Chou', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Citrouille', TRUE, TRUE, TRUE, TRUE, 26, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Potiron', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Filet', FALSE, FALSE, TRUE, TRUE, 217, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Côte', FALSE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Épaule', FALSE, FALSE, TRUE, TRUE, 236, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cuisse', FALSE, FALSE, TRUE, TRUE, 209, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poitrine', FALSE, FALSE, TRUE, TRUE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Foie', FALSE, FALSE, TRUE, TRUE, 136, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cœur', FALSE, FALSE, TRUE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Langue', FALSE, FALSE, TRUE, TRUE, 224, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Hachis', FALSE, FALSE, TRUE, TRUE, 332, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Jambon', FALSE, FALSE, TRUE, TRUE, 145, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Saucisse', FALSE, FALSE, TRUE, TRUE, 301, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Rôti', FALSE, FALSE, TRUE, TRUE, 213, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Escalope', FALSE, FALSE, TRUE, TRUE, 165, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Entrecôte', FALSE, FALSE, TRUE, TRUE, 291, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lardon', FALSE, FALSE, TRUE, TRUE, 541, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Rognon', FALSE, FALSE, TRUE, TRUE, 124, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Andouillette', FALSE, FALSE, TRUE, TRUE, 263, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Boudin', FALSE, FALSE, TRUE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cervelle', FALSE, FALSE, TRUE, TRUE, 125, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tripes', FALSE, FALSE, TRUE, TRUE, 94, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gigot', FALSE, FALSE, TRUE, TRUE, 294, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Magret', FALSE, FALSE, TRUE, TRUE, 337, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Paupiette', FALSE, FALSE, TRUE, TRUE, 220, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gésier', FALSE, FALSE, TRUE, TRUE, 147, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Saumon', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Thon', FALSE, FALSE, TRUE, TRUE, 184, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cabillaud', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crevettes', FALSE, FALSE, TRUE, TRUE, 99, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Moules', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sardines', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Truite', FALSE, FALSE, TRUE, TRUE, 141, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Maquereau', FALSE, FALSE, TRUE, TRUE, 205, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sole', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Dorade', FALSE, FALSE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lieu noir', FALSE, FALSE, TRUE, TRUE, 90, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Merlu', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Bar', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Anchois', FALSE, FALSE, TRUE, TRUE, 131, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Hareng', FALSE, FALSE, TRUE, TRUE, 203, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Huitres', FALSE, FALSE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Calmar', FALSE, FALSE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poulpe', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Homard', FALSE, FALSE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crabe', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Lait', TRUE, FALSE, TRUE, FALSE, 42, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Fromage', TRUE, FALSE, TRUE, FALSE, 404, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Yaourt', TRUE, FALSE, TRUE, FALSE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Beurre', TRUE, FALSE, TRUE, FALSE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crème', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Œuf', TRUE, FALSE, TRUE, TRUE, 144, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mozzarella', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Parmesan', TRUE, FALSE, TRUE, FALSE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Feta', TRUE, FALSE, TRUE, FALSE, 268, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Ricotta', TRUE, FALSE, TRUE, FALSE, 140, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mascarpone', TRUE, FALSE, TRUE, FALSE, 800, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crème fraîche', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Fromage blanc', TRUE, FALSE, TRUE, FALSE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Comté', TRUE, FALSE, TRUE, FALSE, 411, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Roquefort', TRUE, FALSE, TRUE, FALSE, 375, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Camembert', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Brie', TRUE, FALSE, TRUE, FALSE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Riz', TRUE, TRUE, TRUE, TRUE, 130, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pâtes', TRUE, TRUE, FALSE, TRUE, 158, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Quinoa', TRUE, TRUE, TRUE, TRUE, 120, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Avoine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Blé', TRUE, TRUE, FALSE, TRUE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Orge', TRUE, TRUE, FALSE, TRUE, 123, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Semoule', TRUE, TRUE, FALSE, TRUE, 360, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pain', TRUE, TRUE, FALSE, TRUE, 247, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tortilla', TRUE, TRUE, FALSE, TRUE, 298, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Couscous', TRUE, TRUE, FALSE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Boulgour', TRUE, TRUE, FALSE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Millet', TRUE, TRUE, TRUE, TRUE, 119, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sarrasin', TRUE, TRUE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Polenta', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tapioca', TRUE, TRUE, TRUE, TRUE, 358, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Lentilles', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pois chiches', TRUE, TRUE, TRUE, TRUE, 164, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Haricots rouges', TRUE, TRUE, TRUE, TRUE, 127, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Haricots blancs', TRUE, TRUE, TRUE, TRUE, 139, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Fèves', TRUE, TRUE, TRUE, TRUE, 110, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Soja', TRUE, TRUE, TRUE, TRUE, 173, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Edamame', TRUE, TRUE, TRUE, TRUE, 121, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Flageolets', TRUE, TRUE, TRUE, TRUE, 128, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Haricots noirs', TRUE, TRUE, TRUE, TRUE, 132, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pois cassés', TRUE, TRUE, TRUE, TRUE, 118, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Amande', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Noix', TRUE, TRUE, TRUE, TRUE, 661, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cacahuète', TRUE, TRUE, TRUE, TRUE, 575, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Noix de cajou', TRUE, TRUE, TRUE, TRUE, 561, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Graine de tournesol', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Graine de citrouille', TRUE, TRUE, TRUE, TRUE, 539, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sésame', TRUE, TRUE, TRUE, TRUE, 571, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Noix de pécan', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pistache', TRUE, TRUE, TRUE, TRUE, 568, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Noisette', TRUE, TRUE, TRUE, TRUE, 636, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Noix de macadamia', TRUE, TRUE, TRUE, TRUE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Graine de lin', TRUE, TRUE, TRUE, TRUE, 536, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Graine de chia', TRUE, TRUE, TRUE, TRUE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (uuid_generate_v4(), 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Chapelure', TRUE, TRUE, FALSE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Fécule de maïs', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Gélatine', FALSE, FALSE, TRUE, TRUE, 329, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Extrait de vanille', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Cacao en poudre', TRUE, TRUE, TRUE, TRUE, 240, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Levure chimique', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Vinaigre', TRUE, TRUE, TRUE, TRUE, 20, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile de tournesol', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile de colza', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile de sésame', TRUE, TRUE, TRUE, TRUE, 882, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile de noix', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 881, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 53, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (uuid_generate_v4(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 681, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 91, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (uuid_generate_v4(), 'Sauce aigre-douce', TRUE, TRUE, TRUE, TRUE, 110, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');