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
   account_id UUID DEFAULT gen_random_uuid(),
   username VARCHAR(20) NOT NULL,
   mail VARCHAR(50) NOT NULL,
   account_password VARCHAR(64) NOT NULL,
   default_serving INTEGER DEFAULT 4,
   avatar VARCHAR(500),
   account_admin BOOLEAN DEFAULT FALSE,
   PRIMARY KEY(account_id),
   UNIQUE(mail)
);



------------------------------------------------------------
-- Table (Entity): account (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account(
--   account_id UUID,
--   username VARCHAR(20) NOT NULL,
--   mail VARCHAR(50) NOT NULL,
--   account_password VARCHAR(64) NOT NULL,
--   PRIMARY KEY(account_id),
--   UNIQUE(mail)
--);



------------------------------------------------------------
-- Table (Entity): account_user (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account_user(
--   account_id UUID,
--   default_serving INTEGER,
--   avatar VARCHAR(500),
--   PRIMARY KEY(account_id),
--   FOREIGN KEY(account_id) REFERENCES account(account_id)
--);



------------------------------------------------------------
-- Table (Entity): account_admin (V1)
------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS account_admin(
--   account_id UUID,
--   PRIMARY KEY(account_id),
--   FOREIGN KEY(account_id) REFERENCES account(account_id)
--);



------------------------------------------------------------
-- Table (Entity): recipe
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipe(
   recipe_id UUID DEFAULT gen_random_uuid(),
   recipe_label VARCHAR(60) NOT NULL,
   recipe_public BOOLEAN DEFAULT FALSE,
   instruction TEXT NOT NULL,
   duration INTEGER,
   recipe_picture VARCHAR(500),
   account_id UUID NOT NULL,
   PRIMARY KEY(recipe_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id)
);



------------------------------------------------------------
-- Table (Entity): unit
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS unit(
   unit_id UUID DEFAULT gen_random_uuid(),
   unit_label VARCHAR(20) NOT NULL,
   PRIMARY KEY(unit_id),
   UNIQUE(unit_label)
);



------------------------------------------------------------
-- Table (Entity): animal
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS animal(
   animal_id UUID DEFAULT gen_random_uuid(),
   animal_label VARCHAR(20) NOT NULL,
   PRIMARY KEY(animal_id),
   UNIQUE(animal_label)
);



------------------------------------------------------------
-- Table (Entity): ingredient
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ingredient(
   ingredient_id UUID DEFAULT gen_random_uuid(),
   ingredient_label VARCHAR(20) NOT NULL,
   vegetarian BOOLEAN NOT NULL,
   vegan BOOLEAN NOT NULL,
   gluten_free BOOLEAN NOT NULL,
   lactose_free BOOLEAN NOT NULL,
   calorie INTEGER NOT NULL,
   animal_id UUID,
   unit_id UUID NOT NULL,
   PRIMARY KEY(ingredient_id),
   FOREIGN KEY(animal_id) REFERENCES animal(animal_id),
   FOREIGN KEY(unit_id) REFERENCES unit(unit_id)
);



------------------------------------------------------------
-- Table (Relation): add_fridge
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS add_fridge(
   account_id UUID,
   ingredient_id UUID,
   add_fridge_quantity INTEGER NOT NULL,
   PRIMARY KEY(account_id, ingredient_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id)
);



------------------------------------------------------------
-- Table (Relation): compose
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS compose(
   recipe_id UUID,
   ingredient_id UUID,
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
   account_id UUID,
   ingredient_id UUID,
   PRIMARY KEY(account_id, ingredient_id),
   FOREIGN KEY(account_id) REFERENCES account(account_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id)
);



------------------------------------------------------------
-- Table (Relation): filter_recipe
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filter_recipe(
   account_id UUID,
   recipe_id UUID,
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
  (gen_random_uuid(), 'Pomme', TRUE, TRUE, TRUE, TRUE, 52, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Banane', TRUE, TRUE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Orange', TRUE, TRUE, TRUE, TRUE, 47, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Fraise', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Framboise', TRUE, TRUE, TRUE, TRUE, 53, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Myrtille', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pêche', TRUE, TRUE, TRUE, TRUE, 39, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Abricot', TRUE, TRUE, TRUE, TRUE, 49, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poire', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Raisin', TRUE, TRUE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cerise', TRUE, TRUE, TRUE, TRUE, 63, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Ananas', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mangue', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Kiwi', TRUE, TRUE, TRUE, TRUE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Melon', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pastèque', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Citron', TRUE, TRUE, TRUE, TRUE, 29, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lime', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pamplemousse', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Grenade', TRUE, TRUE, TRUE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Carotte', TRUE, TRUE, TRUE, TRUE, 85, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tomate', TRUE, TRUE, TRUE, TRUE, 18, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Concombre', TRUE, TRUE, TRUE, TRUE, 15, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poivron', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Aubergine', TRUE, TRUE, TRUE, TRUE, 24, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Courgette', TRUE, TRUE, TRUE, TRUE, 17, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Brocoli', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Chou-fleur', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Épinard', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Laitue', TRUE, TRUE, TRUE, TRUE, 11, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Oignon', TRUE, TRUE, TRUE, TRUE, 40, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Ail', TRUE, TRUE, TRUE, TRUE, 133, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pomme de terre', TRUE, TRUE, TRUE, TRUE, 93, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Patate douce', TRUE, TRUE, TRUE, TRUE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Maïs', TRUE, TRUE, TRUE, TRUE, 108, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Haricot vert', TRUE, TRUE, TRUE, TRUE, 31, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pois', TRUE, TRUE, TRUE, TRUE, 74, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Asperge', TRUE, TRUE, TRUE, TRUE, 20, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Champignon', TRUE, TRUE, TRUE, TRUE, 21, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Betterave', TRUE, TRUE, TRUE, TRUE, 43, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Céleri', TRUE, TRUE, TRUE, TRUE, 16, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poireau', TRUE, TRUE, TRUE, TRUE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Radis', TRUE, TRUE, TRUE, TRUE, 14, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Navet', TRUE, TRUE, TRUE, TRUE, 22, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Chou', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Citrouille', TRUE, TRUE, TRUE, TRUE, 26, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Potiron', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Filet', FALSE, FALSE, TRUE, TRUE, 217, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Côte', FALSE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Épaule', FALSE, FALSE, TRUE, TRUE, 236, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cuisse', FALSE, FALSE, TRUE, TRUE, 209, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poitrine', FALSE, FALSE, TRUE, TRUE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Foie', FALSE, FALSE, TRUE, TRUE, 136, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cœur', FALSE, FALSE, TRUE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Langue', FALSE, FALSE, TRUE, TRUE, 224, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Hachis', FALSE, FALSE, TRUE, TRUE, 332, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Jambon', FALSE, FALSE, TRUE, TRUE, 145, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Saucisse', FALSE, FALSE, TRUE, TRUE, 301, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Rôti', FALSE, FALSE, TRUE, TRUE, 213, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Escalope', FALSE, FALSE, TRUE, TRUE, 165, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Entrecôte', FALSE, FALSE, TRUE, TRUE, 291, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lardon', FALSE, FALSE, TRUE, TRUE, 541, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Rognon', FALSE, FALSE, TRUE, TRUE, 124, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Andouillette', FALSE, FALSE, TRUE, TRUE, 263, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Boudin', FALSE, FALSE, TRUE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cervelle', FALSE, FALSE, TRUE, TRUE, 125, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tripes', FALSE, FALSE, TRUE, TRUE, 94, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gigot', FALSE, FALSE, TRUE, TRUE, 294, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Magret', FALSE, FALSE, TRUE, TRUE, 337, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Paupiette', FALSE, FALSE, TRUE, TRUE, 220, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gésier', FALSE, FALSE, TRUE, TRUE, 147, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Saumon', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Thon', FALSE, FALSE, TRUE, TRUE, 184, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cabillaud', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crevettes', FALSE, FALSE, TRUE, TRUE, 99, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Moules', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sardines', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Truite', FALSE, FALSE, TRUE, TRUE, 141, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Maquereau', FALSE, FALSE, TRUE, TRUE, 205, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sole', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Dorade', FALSE, FALSE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lieu noir', FALSE, FALSE, TRUE, TRUE, 90, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Merlu', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Bar', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Anchois', FALSE, FALSE, TRUE, TRUE, 131, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Hareng', FALSE, FALSE, TRUE, TRUE, 203, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Huitres', FALSE, FALSE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Calmar', FALSE, FALSE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poulpe', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Homard', FALSE, FALSE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crabe', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Lait', TRUE, FALSE, TRUE, FALSE, 42, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Fromage', TRUE, FALSE, TRUE, FALSE, 404, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Yaourt', TRUE, FALSE, TRUE, FALSE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Beurre', TRUE, FALSE, TRUE, FALSE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crème', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Œuf', TRUE, FALSE, TRUE, TRUE, 144, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mozzarella', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Parmesan', TRUE, FALSE, TRUE, FALSE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Feta', TRUE, FALSE, TRUE, FALSE, 268, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Ricotta', TRUE, FALSE, TRUE, FALSE, 140, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mascarpone', TRUE, FALSE, TRUE, FALSE, 800, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crème fraîche', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Fromage blanc', TRUE, FALSE, TRUE, FALSE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Comté', TRUE, FALSE, TRUE, FALSE, 411, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Roquefort', TRUE, FALSE, TRUE, FALSE, 375, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Camembert', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Brie', TRUE, FALSE, TRUE, FALSE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Riz', TRUE, TRUE, TRUE, TRUE, 130, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pâtes', TRUE, TRUE, FALSE, TRUE, 158, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Quinoa', TRUE, TRUE, TRUE, TRUE, 120, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Avoine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Blé', TRUE, TRUE, FALSE, TRUE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Orge', TRUE, TRUE, FALSE, TRUE, 123, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Semoule', TRUE, TRUE, FALSE, TRUE, 360, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pain', TRUE, TRUE, FALSE, TRUE, 247, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tortilla', TRUE, TRUE, FALSE, TRUE, 298, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Couscous', TRUE, TRUE, FALSE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Boulgour', TRUE, TRUE, FALSE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Millet', TRUE, TRUE, TRUE, TRUE, 119, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sarrasin', TRUE, TRUE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Polenta', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tapioca', TRUE, TRUE, TRUE, TRUE, 358, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Lentilles', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pois chiches', TRUE, TRUE, TRUE, TRUE, 164, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Haricots rouges', TRUE, TRUE, TRUE, TRUE, 127, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Haricots blancs', TRUE, TRUE, TRUE, TRUE, 139, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Fèves', TRUE, TRUE, TRUE, TRUE, 110, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Soja', TRUE, TRUE, TRUE, TRUE, 173, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Edamame', TRUE, TRUE, TRUE, TRUE, 121, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Flageolets', TRUE, TRUE, TRUE, TRUE, 128, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Haricots noirs', TRUE, TRUE, TRUE, TRUE, 132, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pois cassés', TRUE, TRUE, TRUE, TRUE, 118, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Amande', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Noix', TRUE, TRUE, TRUE, TRUE, 661, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cacahuète', TRUE, TRUE, TRUE, TRUE, 575, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Noix de cajou', TRUE, TRUE, TRUE, TRUE, 561, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Graine de tournesol', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Graine de citrouille', TRUE, TRUE, TRUE, TRUE, 539, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sésame', TRUE, TRUE, TRUE, TRUE, 571, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Noix de pécan', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pistache', TRUE, TRUE, TRUE, TRUE, 568, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Noisette', TRUE, TRUE, TRUE, TRUE, 636, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Noix de macadamia', TRUE, TRUE, TRUE, TRUE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Graine de lin', TRUE, TRUE, TRUE, TRUE, 536, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Graine de chia', TRUE, TRUE, TRUE, TRUE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  (gen_random_uuid(), 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Chapelure', TRUE, TRUE, FALSE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Fécule de maïs', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Gélatine', FALSE, FALSE, TRUE, TRUE, 329, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Extrait de vanille', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Cacao en poudre', TRUE, TRUE, TRUE, TRUE, 240, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Levure chimique', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Vinaigre', TRUE, TRUE, TRUE, TRUE, 20, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile de tournesol', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile de colza', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile de sésame', TRUE, TRUE, TRUE, TRUE, 882, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile de noix', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 881, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 53, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  (gen_random_uuid(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 681, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 91, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  (gen_random_uuid(), 'Sauce aigre-douce', TRUE, TRUE, TRUE, TRUE, 110, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');