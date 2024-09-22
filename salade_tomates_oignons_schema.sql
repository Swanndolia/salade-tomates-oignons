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
   vegetarian BOOLEAN DEFAULT FALSE,
   vegan BOOLEAN DEFAULT FALSE,
   gluten_free BOOLEAN DEFAULT FALSE,
   lactose_free BOOLEAN DEFAULT FALSE,
   PRIMARY KEY(account_id),
   UNIQUE(mail)
);



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
   ingredient_label VARCHAR(30) NOT NULL,
   vegetarian BOOLEAN NOT NULL,
   vegan BOOLEAN NOT NULL,
   gluten_free BOOLEAN NOT NULL,
   lactose_free BOOLEAN NOT NULL,
   calorie INTEGER NOT NULL,
   animal_id UUID DEFAULT NULL,
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



INSERT INTO animal(animal_id, animal_label) VALUES
(gen_random_uuid(), 'Poule'),
(gen_random_uuid(), 'Bœuf'),
(gen_random_uuid(), 'Mouton'),
(gen_random_uuid(), 'Veau'),
(gen_random_uuid(), 'Agneau'),
(gen_random_uuid(), 'Porc'),
(gen_random_uuid(), 'Saumon'),
(gen_random_uuid(), 'Cheval'),
(gen_random_uuid(), 'Truite'),
(gen_random_uuid(), 'Dinde'),
(gen_random_uuid(), 'Moule'),
(gen_random_uuid(), 'Huître'),
(gen_random_uuid(), 'Bison'),
(gen_random_uuid(), 'Cerf'),
(gen_random_uuid(), 'Oie'),
(gen_random_uuid(), 'Canard'),
(gen_random_uuid(), 'Sanglier'),
(gen_random_uuid(), 'Faisan'),
(gen_random_uuid(), 'Pintade'),
(gen_random_uuid(), 'Lapin'),
(gen_random_uuid(), 'Grenouille');



INSERT INTO unit(unit_id, unit_label) VALUES
('886ef1ff-004d-4446-b8b5-37fd9d9e8710', 'g'),
('9a7b330d-a7cc-4c32-9d69-a6983b01bfb5', 'kg'),
('b5c07b4d-1a7b-4b8f-8b4a-93d6c2c8db4a', 'l'),
('c3f7e8d9-5a6b-4c1d-9e2f-8b7a6b5c4d3e', 'ml'),
('d2e1f0a9-8b7c-4d6e-5f4a-3c2b1a0d9e8f', 'pc'),
('f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9', 'cl');



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
(gen_random_uuid(), 'Lait', TRUE, FALSE, TRUE, FALSE, 42, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Fromage', TRUE, FALSE, TRUE, FALSE, 404, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Yaourt', TRUE, FALSE, TRUE, FALSE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Beurre', TRUE, FALSE, TRUE, FALSE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Crème', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Œuf', TRUE, FALSE, TRUE, TRUE, 144, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Mozzarella', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Parmesan', TRUE, FALSE, TRUE, FALSE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Feta', TRUE, FALSE, TRUE, FALSE, 268, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Ricotta', TRUE, FALSE, TRUE, FALSE, 140, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Mascarpone', TRUE, FALSE, TRUE, FALSE, 800, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Crème fraîche', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
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
(gen_random_uuid(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');
-- Ingrédients de base
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9');

-- Herbes et épices
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

-- Sauces et condiments
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 881, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sauce aigre-douce', TRUE, TRUE, TRUE, TRUE, 110, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9');

-- Boissons
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9');

-- Sucres et édulcorants
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

-- Produits sucrés
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

-- Alternatives végétales
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

-- Plats préparés
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

-- Autres ingrédients
INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
(gen_random_uuid(), 'Chapelure', TRUE, TRUE, FALSE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Fécule de maïs', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Gélatine', FALSE, FALSE, TRUE, TRUE, 329, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Extrait de vanille', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Cacao en poudre', TRUE, TRUE, TRUE, TRUE, 240, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Levure chimique', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
(gen_random_uuid(), 'Vinaigre', TRUE, TRUE, TRUE, TRUE, 20, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Huile de tournesol', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Huile de colza', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Huile de sésame', TRUE, TRUE, TRUE, TRUE, 882, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9'),
(gen_random_uuid(), 'Huile de noix', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6e7f8a9');

-- Create admin account
INSERT INTO account (account_id, username, mail, account_password, default_serving, avatar, account_admin)
VALUES (
    gen_random_uuid(),
    'admin',
    'admin@example.com',
    'admin_password',
    4,
    NULL,
    TRUE
);

-- Curry de Poulet
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Curry de Poulet', TRUE, '1. Faites chauffer l''huile dans une grande poêle à feu moyen.
2. Ajoutez les oignons émincés et cuisez jusqu''à ce qu''ils soient translucides, environ 5 minutes.
3. Ajoutez l''ail et le gingembre hachés, cuisez pendant 1 minute.
4. Incorporez la poudre de curry, le curcuma et le cumin, cuisez 30 secondes.
5. Ajoutez le poulet coupé en dés et cuisez jusqu''à ce qu''il ne soit plus rose, environ 5-7 minutes.
6. Versez le lait de coco et les tomates en dés, portez à frémissement.
7. Réduisez le feu et laissez mijoter pendant 15-20 minutes.
8. Ajoutez la coriandre ciselée et assaisonnez de sel et de poivre.
9. Servez chaud sur du riz.', 60, 'curry_poulet.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Cuisse', 'Poule', 400),
    ('Oignon', NULL, 100),
    ('Lait de coco', NULL, 400),
    ('Tomate', NULL, 200),
    ('Poudre de curry', NULL, 15)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Curry de Poulet';

-- Saumon Grillé
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Saumon Grillé', TRUE, '1. Préchauffez le gril à feu moyen-vif.
2. Séchez les filets de saumon avec du papier absorbant.
3. Badigeonnez les deux côtés du saumon d''huile d''olive.
4. Assaisonnez de sel, de poivre et de zeste de citron.
5. Huilez les grilles du gril pour éviter que le poisson ne colle.
6. Placez le saumon sur le gril, côté peau vers le haut.
7. Grillez pendant 4-5 minutes.
8. Retournez délicatement le saumon et grillez encore 3-4 minutes.
9. Retirez du gril lorsque la température interne atteint 63°C.
10. Laissez reposer 5 minutes avant de servir.
11. Garnissez de quartiers de citron et d''aneth frais.', 30, 'saumon_grille.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Filet', 'Saumon', 300),
    ('Huile d''olive', NULL, 15),
    ('Citron', NULL, 1),
    ('Sel', NULL, 5),
    ('Poivre', NULL, 2)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Saumon Grillé';

-- Poulet Rôti aux Herbes
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Poulet Rôti aux Herbes', TRUE, '1. Préchauffez le four à 190°C.
2. Mélangez les herbes, l''ail, le sel et le poivre.
3. Frottez le mélange sur et sous la peau du poulet.
4. Placez le poulet dans un plat allant au four.
5. Enfournez pour 1h30, en arrosant toutes les 30 minutes.
6. Vérifiez la cuisson et laissez reposer 10 minutes avant de servir.', 100, 'poulet_roti_herbes.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Poulet entier', 'Poule', 1500),
    ('Thym', NULL, 10),
    ('Romarin', NULL, 10),
    ('Ail', NULL, 15),
    ('Sel', NULL, 10),
    ('Poivre', NULL, 5)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Poulet Rôti aux Herbes';

-- Pâtes à la Carbonara
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Pâtes à la Carbonara', TRUE, '1. Faites cuire les pâtes dans l''eau bouillante salée.
2. Pendant ce temps, faites revenir les lardons dans une poêle.
3. Battez les œufs avec le parmesan râpé et le poivre.
4. Égouttez les pâtes et remettez-les dans la casserole.
5. Ajoutez les lardons et le mélange d''œufs, remuez rapidement.
6. Servez immédiatement avec du parmesan supplémentaire.', 20, 'pates_carbonara.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Spaghetti', NULL, 400),
    ('Lardons', 'Porc', 150),
    ('Œuf', 'Poule', 3),
    ('Parmesan', NULL, 100),
    ('Poivre', NULL, 5)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Pâtes à la Carbonara';

-- Salade César
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Salade César', TRUE, '1. Lavez et coupez la laitue romaine.
2. Préparez la sauce en mélangeant l''ail, les anchois, le jaune d''œuf, le jus de citron, la moutarde et l''huile d''olive.
3. Faites griller les croûtons à la poêle.
4. Grillez le poulet et coupez-le en morceaux.
5. Mélangez la salade avec la sauce, ajoutez le poulet, les croûtons et le parmesan.
6. Servez immédiatement.', 25, 'salade_cesar.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Laitue romaine', NULL, 300),
    ('Filet', 'Poule', 200),
    ('Pain', NULL, 100),
    ('Parmesan', NULL, 50),
    ('Anchois', NULL, 20),
    ('Œuf', 'Poule', 1),
    ('Huile d''olive', NULL, 30),
    ('Citron', NULL, 1),
    ('Moutarde', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Salade César';

-- Ratatouille
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Ratatouille', TRUE, '1. Coupez tous les légumes en dés.
2. Faites revenir l''oignon et l''ail dans l''huile d''olive.
3. Ajoutez les aubergines et les courgettes, cuisez 10 minutes.
4. Ajoutez les poivrons et les tomates, cuisez encore 15 minutes.
5. Assaisonnez avec les herbes, le sel et le poivre.
6. Laissez mijoter à feu doux pendant 30 minutes.
7. Servez chaud ou froid.', 70, 'ratatouille.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Aubergine', NULL, 300),
    ('Courgette', NULL, 300),
    ('Poivron', NULL, 200),
    ('Tomate', NULL, 400),
    ('Oignon', NULL, 100),
    ('Ail', NULL, 15),
    ('Huile d''olive', NULL, 30),
    ('Thym', NULL, 5),
    ('Romarin', NULL, 5)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Ratatouille';


-- Tarte aux pommes
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Tarte aux pommes', TRUE, '1. Préchauffez le four à 180°C.
2. Étalez la pâte brisée dans un moule à tarte.
3. Épluchez et coupez les pommes en tranches.
4. Disposez les pommes sur la pâte.
5. Mélangez le sucre, la cannelle et le beurre fondu.
6. Versez le mélange sur les pommes.
7. Enfournez pour 30-35 minutes.', 50, 'tarte_aux_pommes.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Pâte brisée', NULL, 250),
    ('Pomme', NULL, 1000),
    ('Sucre', NULL, 100),
    ('Cannelle', NULL, 5),
    ('Beurre', NULL, 50)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Tarte aux pommes';

-- Salade de tomates et oignons
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Salade de tomates et oignons', TRUE, '1. Lavez et coupez les tomates en quartiers.
2. Épluchez et émincez finement l''oignon rouge.
3. Dans un saladier, mélangez les tomates et l''oignon.
4. Ajoutez l''huile d''olive, le vinaigre balsamique, le sel et le poivre.
5. Mélangez délicatement.
6. Parsemez de basilic frais ciselé avant de servir.', 15, 'salade_tomates_oignons.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Tomate', NULL, 500),
    ('Oignon rouge', NULL, 100),
    ('Huile d''olive', NULL, 30),
    ('Vinaigre balsamique', NULL, 15),
    ('Sel', NULL, 5),
    ('Poivre', NULL, 2),
    ('Basilic', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Salade de tomates et oignons';
-- Pad thaï
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Pad thaï', TRUE, '1. Faites tremper les nouilles de riz dans l''eau tiède pendant 15 minutes.
2. Dans un wok, faites chauffer l''huile et faites revenir l''ail et les crevettes.
3. Ajoutez le tofu et faites-le dorer.
4. Poussez les ingrédients sur le côté et faites cuire l''œuf brouillé.
5. Ajoutez les nouilles égouttées, la sauce de poisson, le sucre et le jus de citron vert.
6. Incorporez les pousses de soja et les oignons verts.
7. Servez garni de cacahuètes concassées et de coriandre fraîche.', 30, 'pad_thai.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Nouilles de riz', NULL, 200),
    ('Crevettes', 'Crevette', 150),
    ('Tofu', NULL, 100),
    ('Œuf', 'Poule', 50),
    ('Sauce de poisson', NULL, 30),
    ('Citron vert', NULL, 20),
    ('Pousses de soja', NULL, 50),
    ('Oignon vert', NULL, 30),
    ('Cacahuètes', NULL, 20),
    ('Coriandre', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Pad thaï';

-- Paella valenciana
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Paella valenciana', TRUE, '1. Faites chauffer l''huile d''olive dans une grande poêle à paella.
2. Faites revenir le poulet et le lapin jusqu''à ce qu''ils soient dorés.
3. Ajoutez les haricots verts, les tomates et l''ail, puis faites cuire pendant 5 minutes.
4. Incorporez le riz et le safran, en remuant pour bien enrober.
5. Versez le bouillon chaud et laissez mijoter à feu doux pendant 15 minutes.
6. Ajoutez les escargots et les artichauts, puis continuez la cuisson pendant 10 minutes.
7. Garnissez de quartiers de citron et servez chaud.', 60, 'paella_valenciana.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Riz', NULL, 400),
    ('Poulet', 'Poulet', 300),
    ('Lapin', 'Lapin', 200),
    ('Haricots verts', NULL, 150),
    ('Tomate', NULL, 200),
    ('Ail', NULL, 20),
    ('Safran', NULL, 1),
    ('Bouillon de volaille', NULL, 1000),
    ('Escargots', 'Escargot', 100),
    ('Artichaut', NULL, 200)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Paella valenciana';

-- Sushi maki
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Sushi maki', TRUE, '1. Rincez le riz jusqu''à ce que l''eau soit claire, puis faites-le cuire.
2. Mélangez le riz cuit avec le vinaigre de riz, le sucre et le sel.
3. Placez une feuille d''algue nori sur un tapis à sushi.
4. Étalez une fine couche de riz sur l''algue, en laissant un bord libre.
5. Disposez les ingrédients (concombre, avocat, saumon) en ligne au centre.
6. Roulez fermement à l''aide du tapis bambou.
7. Coupez le rouleau en 6-8 morceaux avec un couteau bien aiguisé.
8. Servez avec de la sauce soja, du wasabi et du gingembre mariné.', 45, 'sushi_maki.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Riz à sushi', NULL, 300),
    ('Vinaigre de riz', NULL, 45),
    ('Algue nori', NULL, 20),
    ('Concombre', NULL, 100),
    ('Avocat', NULL, 100),
    ('Saumon', 'Saumon', 150),
    ('Sauce soja', NULL, 30),
    ('Wasabi', NULL, 10),
    ('Gingembre mariné', NULL, 30)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Sushi maki';

-- Bœuf bourguignon
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Bœuf bourguignon', TRUE, '1. Coupez le bœuf en cubes et faites-le mariner dans le vin rouge pendant 2 heures.
2. Faites revenir les lardons dans une cocotte, puis réservez.
3. Dans la même cocotte, faites dorer la viande égouttée par petites quantités.
4. Ajoutez les oignons, l''ail et les carottes, puis saupoudrez de farine.
5. Versez le vin de la marinade et le bouillon, ajoutez le bouquet garni.
6. Laissez mijoter à feu doux pendant 2h30.
7. 30 minutes avant la fin, ajoutez les champignons sautés et les lardons.
8. Servez chaud avec des pommes de terre vapeur ou des pâtes.', 180, 'boeuf_bourguignon.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Bœuf', 'Bœuf', 800),
    ('Vin rouge', NULL, 750),
    ('Lardons', 'Porc', 150),
    ('Oignon', NULL, 200),
    ('Ail', NULL, 20),
    ('Carotte', NULL, 200),
    ('Farine', NULL, 30),
    ('Bouillon de bœuf', NULL, 500),
    ('Champignons de Paris', NULL, 250)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Bœuf bourguignon';

-- Falafel
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Falafel', TRUE, '1. Faites tremper les pois chiches secs pendant une nuit.
2. Égouttez et mixez les pois chiches avec l''oignon, l''ail, le persil et la coriandre.
3. Ajoutez les épices, le sel, le poivre et la farine. Mélangez bien.
4. Formez des petites boules avec la préparation.
5. Faites chauffer l''huile dans une casserole.
6. Faites frire les falafels par petites quantités jusqu''à ce qu''ils soient dorés.
7. Égouttez sur du papier absorbant.
8. Servez chaud dans du pain pita avec de la salade et de la sauce tahini.', 40, 'falafel.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Pois chiches', NULL, 250),
    ('Oignon', NULL, 100),
    ('Ail', NULL, 15),
    ('Persil', NULL, 30),
    ('Coriandre', NULL, 30),
    ('Cumin', NULL, 10),
    ('Farine', NULL, 30),
    ('Huile de friture', NULL, 1000),
    ('Pain pita', NULL, 200),
    ('Sauce tahini', NULL, 100)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Falafel';

-- Poutine
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Poutine', TRUE, '1. Préparez la sauce brune : faites un roux avec du beurre et de la farine, ajoutez le bouillon de bœuf et laissez épaissir.
2. Coupez les pommes de terre en frites et faites-les tremper dans l''eau froide pendant 30 minutes.
3. Égouttez et séchez bien les frites.
4. Faites frire les pommes de terre une première fois à 150°C pendant 5-7 minutes.
5. Augmentez la température de l''huile à 190°C et faites frire une seconde fois jusqu''à ce qu''elles soient dorées et croustillantes.
6. Disposez les frites dans un plat, ajoutez le fromage en grains.
7. Versez la sauce chaude sur le dessus.
8. Servez immédiatement et dégustez pendant que c''est chaud.', 60, 'poutine.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Pomme de terre', NULL, 1000),
    ('Fromage en grains', 'Vache', 300),
    ('Beurre', 'Vache', 50),
    ('Farine', NULL, 50),
    ('Bouillon de bœuf', NULL, 500),
    ('Huile de friture', NULL, 1000)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Poutine';

-- Bobotie
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Bobotie', TRUE, '1. Faites tremper le pain dans le lait.
2. Dans une poêle, faites revenir l''oignon et l''ail dans l''huile.
3. Ajoutez la viande hachée et faites-la brunir.
4. Incorporez les épices, les raisins secs, la chutney et le pain essoré.
5. Versez le mélange dans un plat à gratin.
6. Battez les œufs avec le reste de lait et une pincée de sel.
7. Versez ce mélange sur la préparation de viande.
8. Ajoutez les feuilles de laurier sur le dessus.
9. Enfournez à 180°C pendant 45 minutes.
10. Servez chaud avec du riz jaune.', 75, 'bobotie.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Pain', NULL, 100),
    ('Lait', 'Vache', 250),
    ('Viande hachée', 'Bœuf', 500),
    ('Oignon', NULL, 150),
    ('Ail', NULL, 15),
    ('Curry en poudre', NULL, 15),
    ('Raisins secs', NULL, 50),
    ('Chutney', NULL, 30),
    ('Œuf', 'Poule', 150),
    ('Feuille de laurier', NULL, 5)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Bobotie';

-- Pad Thai
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Pad Thai', TRUE, '1. Faites tremper les nouilles de riz dans l''eau tiède pendant 15 minutes.
2. Dans un wok, faites chauffer l''huile et faites revenir l''ail et les crevettes.
3. Ajoutez le tofu et faites-le dorer.
4. Poussez les ingrédients sur le côté et cassez l''œuf dans le wok. Brouilllez-le.
5. Ajoutez les nouilles égouttées, la sauce de poisson, le sucre et le tamarin.
6. Incorporez les germes de soja et les oignons verts.
7. Faites sauter le tout pendant 2-3 minutes.
8. Servez garni de cacahuètes concassées et de coriandre fraîche.', 30, 'pad_thai.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Nouilles de riz', NULL, 200),
    ('Crevettes', 'Crevette', 150),
    ('Tofu', NULL, 100),
    ('Œuf', 'Poule', 50),
    ('Sauce de poisson', NULL, 30),
    ('Sucre', NULL, 20),
    ('Tamarin', NULL, 15),
    ('Germes de soja', NULL, 50),
    ('Oignon vert', NULL, 30),
    ('Cacahuètes', NULL, 30),
    ('Coriandre', NULL, 10),
    ('Ail', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Pad Thai';

-- Couscous Royal
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Couscous Royal', TRUE, '1. Préparez le bouillon avec les épices et les légumes.
2. Faites cuire séparément les merguez, l''agneau et le poulet.
3. Ajoutez les viandes au bouillon et laissez mijoter.
4. Préparez la semoule selon les instructions du paquet.
5. Disposez la semoule dans un grand plat.
6. Disposez les viandes et les légumes sur la semoule.
7. Arrosez de bouillon.
8. Servez avec du harissa à part.', 120, 'couscous_royal.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Semoule', NULL, 300),
    ('Agneau', 'Mouton', 200),
    ('Poulet', 'Poule', 200),
    ('Merguez', 'Mouton', 150),
    ('Carotte', NULL, 150),
    ('Courgette', NULL, 150),
    ('Navet', NULL, 100),
    ('Pois chiche', NULL, 100),
    ('Oignon', NULL, 100),
    ('Harissa', NULL, 30),
    ('Ras el hanout', NULL, 15)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Couscous Royal';

-- Sushi Rolls
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Sushi Rolls', TRUE, '1. Rincez le riz jusqu''à ce que l''eau soit claire. Cuisez-le selon les instructions.
2. Mélangez le vinaigre, le sucre et le sel. Versez sur le riz chaud et mélangez.
3. Coupez le concombre et l''avocat en fines lamelles.
4. Placez une feuille d''algue nori sur un tapis à sushi.
5. Étalez une fine couche de riz sur l''algue, en laissant un bord libre.
6. Disposez le saumon, le concombre et l''avocat sur le riz.
7. Roulez fermement à l''aide du tapis.
8. Coupez le rouleau en 6-8 morceaux.
9. Servez avec de la sauce soja, du wasabi et du gingembre mariné.', 60, 'sushi_rolls.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Riz à sushi', NULL, 300),
    ('Vinaigre de riz', NULL, 45),
    ('Sucre', NULL, 15),
    ('Sel', NULL, 5),
    ('Algue nori', NULL, 20),
    ('Saumon', 'Saumon', 150),
    ('Concombre', NULL, 100),
    ('Avocat', NULL, 100),
    ('Sauce soja', NULL, 30),
    ('Wasabi', NULL, 10),
    ('Gingembre mariné', NULL, 30)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Sushi Rolls';

-- Paella Valenciana
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Paella Valenciana', TRUE, '1. Faites chauffer l''huile dans une poêle à paella. Faites revenir le poulet et le lapin.
2. Ajoutez les haricots verts et les artichauts. Faites sauter pendant 5 minutes.
3. Incorporez le riz et remuez pour bien l''enrober d''huile.
4. Ajoutez le safran, le paprika et le bouillon chaud. Portez à ébullition.
5. Réduisez le feu et laissez mijoter sans remuer pendant 18 minutes.
6. Ajoutez les escargots et les petits pois. Continuez la cuisson pendant 5 minutes.
7. Augmentez le feu pour créer une croûte au fond (socarrat).
8. Retirez du feu, couvrez et laissez reposer 5-10 minutes avant de servir.', 60, 'paella_valenciana.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Riz bomba', NULL, 400),
    ('Poulet', 'Poule', 200),
    ('Lapin', 'Lapin', 200),
    ('Haricot vert', NULL, 100),
    ('Artichaut', NULL, 150),
    ('Escargot', 'Escargot', 100),
    ('Petit pois', NULL, 100),
    ('Safran', NULL, 1),
    ('Paprika', NULL, 10),
    ('Bouillon de volaille', NULL, 1000),
    ('Huile d''olive', NULL, 50)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Paella Valenciana';

-- Borscht
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Borscht', TRUE, '1. Dans une grande casserole, faites revenir l''oignon et l''ail dans l''huile.
2. Ajoutez le bœuf et faites-le brunir.
3. Incorporez les betteraves, les carottes et les pommes de terre. Faites cuire 5 minutes.
4. Ajoutez le chou et le bouillon. Portez à ébullition puis laissez mijoter 1 heure.
5. Ajoutez les tomates et le jus de citron. Cuisez encore 15 minutes.
6. Assaisonnez avec le sel, le poivre et l''aneth.
7. Servez chaud avec une cuillère de crème fraîche et du pain noir.', 90, 'borscht.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Bœuf', 'Bœuf', 300),
    ('Betterave', NULL, 300),
    ('Chou', NULL, 200),
    ('Carotte', NULL, 150),
    ('Pomme de terre', NULL, 200),
    ('Oignon', NULL, 100),
    ('Ail', NULL, 10),
    ('Tomate', NULL, 200),
    ('Bouillon de bœuf', NULL, 1500),
    ('Crème fraîche', 'Vache', 100),
    ('Jus de citron', NULL, 30),
    ('Aneth', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Borscht';

-- Moussaka
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Moussaka', TRUE, '1. Coupez les aubergines en tranches et faites-les dégorger avec du sel.
2. Préparez la sauce tomate : faites revenir l''oignon et l''ail, ajoutez la viande hachée, puis les tomates et les épices.
3. Faites frire légèrement les tranches d''aubergine.
4. Préparez la béchamel : faites fondre le beurre, ajoutez la farine, puis le lait progressivement. Ajoutez le parmesan.
5. Dans un plat, alternez des couches d''aubergines et de sauce tomate.
6. Terminez par la béchamel et saupoudrez de fromage râpé.
7. Enfournez à 180°C pendant 45 minutes.
8. Laissez reposer 15 minutes avant de servir.', 120, 'moussaka.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Aubergine', NULL, 600),
    ('Viande hachée', 'Bœuf', 400),
    ('Oignon', NULL, 100),
    ('Ail', NULL, 10),
    ('Tomate pelée', NULL, 400),
    ('Beurre', 'Vache', 50),
    ('Farine', NULL, 50),
    ('Lait', 'Vache', 500),
    ('Parmesan', 'Vache', 50),
    ('Fromage râpé', 'Vache', 100),
    ('Cannelle', NULL, 5),
    ('Noix de muscade', NULL, 5)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Moussaka';

-- Feijoada
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Feijoada', TRUE, '1. Faites tremper les haricots noirs toute une nuit.
2. Dans une grande marmite, faites revenir l''ail et l''oignon dans l''huile.
3. Ajoutez les viandes coupées en morceaux et faites-les dorer.
4. Incorporez les haricots égouttés et couvrez d''eau.
5. Ajoutez les feuilles de laurier et laissez mijoter à feu doux pendant 2-3 heures.
6. Préparez le riz et faites frire le manioc.
7. Coupez l''orange en quartiers.
8. Servez la feijoada avec le riz, le manioc frit, les quartiers d''orange et la farofa.', 180, 'feijoada.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Haricot noir', NULL, 500),
    ('Porc', 'Porc', 300),
    ('Saucisse fumée', 'Porc', 200),
    ('Lard', 'Porc', 100),
    ('Ail', NULL, 20),
    ('Oignon', NULL, 150),
    ('Feuille de laurier', NULL, 5),
    ('Riz', NULL, 300),
    ('Manioc', NULL, 200),
    ('Orange', NULL, 200),
    ('Farofa', NULL, 100)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Feijoada';

-- Pho
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Pho', TRUE, '1. Préparez le bouillon : faites griller les épices, puis ajoutez-les à l''eau avec l''os à moelle, l''oignon et le gingembre. Laissez mijoter 3 heures.
2. Faites cuire les nouilles de riz selon les instructions du paquet.
3. Coupez le bœuf en fines tranches.
4. Filtrez le bouillon et remettez-le à chauffer.
5. Dans des bols, disposez les nouilles, puis le bœuf cru.
6. Versez le bouillon bouillant sur le bœuf pour le cuire légèrement.
7. Garnissez de pousses de soja, d''herbes fraîches et d''oignons verts.
8. Servez avec du citron vert et de la sauce sriracha.', 240, 'pho.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Os à moelle', 'Bœuf', 500),
    ('Bœuf', 'Bœuf', 300),
    ('Nouilles de riz', NULL, 300),
    ('Oignon', NULL, 150),
    ('Gingembre', NULL, 50),
    ('Anis étoilé', NULL, 10),
    ('Cannelle', NULL, 10),
    ('Clou de girofle', NULL, 5),
    ('Pousse de soja', NULL, 100),
    ('Coriandre', NULL, 30),
    ('Menthe', NULL, 30),
    ('Citron vert', NULL, 50),
    ('Sauce sriracha', NULL, 30)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Pho';

-- Chili con Carne
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Chili con Carne', TRUE, '1. Dans une grande casserole, faites revenir l''oignon et l''ail dans l''huile.
2. Ajoutez la viande hachée et faites-la brunir.
3. Incorporez les épices et laissez-les libérer leurs arômes.
4. Ajoutez les tomates concassées, les haricots rouges et le bouillon.
5. Laissez mijoter à feu doux pendant 1h30, en remuant de temps en temps.
6. Ajustez l''assaisonnement avec du sel et du poivre.
7. Servez chaud, garni de crème fraîche, de cheddar râpé et de coriandre fraîche.
8. Accompagnez de riz ou de tortillas.', 120, 'chili_con_carne.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Bœuf haché', 'Bœuf', 500),
    ('Haricot rouge', NULL, 400),
    ('Tomate concassée', NULL, 400),
    ('Oignon', NULL, 150),
    ('Ail', NULL, 20),
    ('Cumin', NULL, 10),
    ('Paprika', NULL, 10),
    ('Piment en poudre', NULL, 5),
    ('Bouillon de bœuf', NULL, 250),
    ('Crème fraîche', 'Vache', 100),
    ('Cheddar', 'Vache', 100),
    ('Coriandre', NULL, 20)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Chili con Carne';

-- Salade Niçoise
INSERT INTO recipe (recipe_id, recipe_label, recipe_public, instruction, duration, recipe_picture, account_id) VALUES
(gen_random_uuid(), 'Salade Niçoise', TRUE, '1. Faites cuire les œufs durs (10 minutes dans l''eau bouillante).
2. Lavez et coupez les tomates en quartiers.
3. Lavez et coupez le poivron en lanières.
4. Épluchez et émincez finement l''oignon rouge.
5. Lavez et coupez les radis en rondelles.
6. Dans un saladier, mélangez les légumes préparés avec les olives et les anchois.
7. Ajoutez le thon émietté et les œufs durs coupés en quartiers.
8. Préparez la vinaigrette en mélangeant l''huile d''olive, le vinaigre, la moutarde, le sel et le poivre.
9. Arrosez la salade de vinaigrette et parsemez de basilic frais ciselé.
10. Servez frais avec des tranches de pain grillé.', 30, 'salade_nicoise.jpg', (SELECT account_id FROM account WHERE username = 'admin'));

INSERT INTO compose (recipe_id, ingredient_id, quantity, consumed)
SELECT r.recipe_id, i.ingredient_id, q.quantity, TRUE
FROM recipe r
CROSS JOIN (
    VALUES 
    ('Tomate', NULL, 300),
    ('Poivron vert', NULL, 100),
    ('Oignon rouge', NULL, 50),
    ('Radis', NULL, 100),
    ('Olive noire', NULL, 50),
    ('Anchois', 'Anchois', 30),
    ('Thon en conserve', 'Thon', 150),
    ('Œuf', 'Poule', 180),
    ('Huile d''olive', NULL, 50),
    ('Vinaigre de vin', NULL, 20),
    ('Moutarde', NULL, 10),
    ('Basilic', NULL, 10)
) AS q(ingredient_label, animal_label, quantity)
LEFT JOIN animal a ON a.animal_label = q.animal_label
JOIN ingredient i ON i.ingredient_label = q.ingredient_label 
    AND (a.animal_id IS NULL OR i.animal_id = a.animal_id)
WHERE r.recipe_label = 'Salade Niçoise';
