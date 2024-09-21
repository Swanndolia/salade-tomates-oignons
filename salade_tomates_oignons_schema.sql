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
  ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Pomme', TRUE, TRUE, TRUE, TRUE, 52, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('550e8400-e29b-41d4-a716-446655440000', 'Banane', TRUE, TRUE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6ba7b810-9dad-11d1-80b4-00c04fd430c8', 'Orange', TRUE, TRUE, TRUE, TRUE, 47, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7c9e6679-7425-40de-944b-e07fc1f90ae7', 'Fraise', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8f14e45f-ceea-467a-9575-6c9b8e9f4b1f', 'Framboise', TRUE, TRUE, TRUE, TRUE, 53, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9f86d081-884c-4d6a-8b5a-92e4f7e9b6c1', 'Myrtille', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('a87ff679-a2f3-471d-a9e1-7a4d6b8a0ccc', 'Pêche', TRUE, TRUE, TRUE, TRUE, 39, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('b0baee9d-279d-47ff-989d-0d5c9ab257a1', 'Abricot', TRUE, TRUE, TRUE, TRUE, 49, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('c1d9f50f-b3ce-4fc8-a866-e3074a4b138f', 'Poire', TRUE, TRUE, TRUE, TRUE, 57, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('d2490f38-3303-4ae5-8c61-9df2a65d6330', 'Raisin', TRUE, TRUE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('e3e84137-947c-4c8f-9d11-7bb7c5cb6a6f', 'Cerise', TRUE, TRUE, TRUE, TRUE, 63, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('f4b0e284-d5d8-4e1f-9c5d-8cb8a8a5ad63', 'Ananas', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('054b5518-c1b7-4e16-9c3f-9b7d1e5c471b', 'Mangue', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('16a5cdae-5b1f-4b4d-9144-7d3a92a5e9e2', 'Kiwi', TRUE, TRUE, TRUE, TRUE, 93, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2764a523-1901-4c3d-8d9c-d2b1e8285a8f', 'Melon', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('38d1c3ed-f77e-4a8e-9d2e-4f9e7b9a5d1f', 'Pastèque', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a9b7f36-e9d2-4f8a-8c1f-8c9b2b3e4d5c', 'Citron', TRUE, TRUE, TRUE, TRUE, 29, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5c6d7e8f-9a0b-4c1d-8e2f-3a4b5c6d7e8f', 'Lime', TRUE, TRUE, TRUE, TRUE, 30, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6e7f8a9b-0c1d-4e2f-8a9b-0c1d2e3f4a5b', 'Pamplemousse', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7f8a9b0c-1d2e-4f3a-9b0c-1d2e3f4a5b6c', 'Grenade', TRUE, TRUE, TRUE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('8f14e45f-ceea-467a-9575-6c9b8e9f4b2f', 'Carotte', TRUE, TRUE, TRUE, TRUE, 85, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9f86d081-884c-4d6a-8b5a-92e4f7e9b6c2', 'Tomate', TRUE, TRUE, TRUE, TRUE, 18, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('a87ff679-a2f3-471d-a9e1-7a4d6b8a0ccd', 'Concombre', TRUE, TRUE, TRUE, TRUE, 15, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('b0baee9d-279d-47ff-989d-0d5c9ab257a2', 'Poivron', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('c1d9f50f-b3ce-4fc8-a866-e3074a4b138e', 'Aubergine', TRUE, TRUE, TRUE, TRUE, 24, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('d2490f38-3303-4ae5-8c61-9df2a65d6331', 'Courgette', TRUE, TRUE, TRUE, TRUE, 17, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('e3e84137-947c-4c8f-9d11-7bb7c5cb6a6e', 'Brocoli', TRUE, TRUE, TRUE, TRUE, 34, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('f4b0e284-d5d8-4e1f-9c5d-8cb8a8a5ad64', 'Chou-fleur', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('054b5518-c1b7-4e16-9c3f-9b7d1e5c472b', 'Épinard', TRUE, TRUE, TRUE, TRUE, 23, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('16a5cdae-5b1f-4b4d-9144-7d3a92a5e9e3', 'Laitue', TRUE, TRUE, TRUE, TRUE, 11, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2764a523-1901-4c3d-8d9c-d2b1e8285a8e', 'Oignon', TRUE, TRUE, TRUE, TRUE, 40, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('38d1c3ed-f77e-4a8e-9d2e-4f9e7b9a5d2f', 'Ail', TRUE, TRUE, TRUE, TRUE, 133, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a9b7f36-e9d2-4f8a-8c1f-8c9b2b3e4d5d', 'Pomme de terre', TRUE, TRUE, TRUE, TRUE, 93, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5c6d7e8f-9a0b-4c1d-8e2f-3a4b5c6d7e8e', 'Patate douce', TRUE, TRUE, TRUE, TRUE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6e7f8a9b-0c1d-4e2f-8a9b-0c1d2e3f4a5c', 'Maïs', TRUE, TRUE, TRUE, TRUE, 108, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7f8a9b0c-1d2e-4f3a-9b0c-1d2e3f4a5b6d', 'Haricot vert', TRUE, TRUE, TRUE, TRUE, 31, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d', 'Pois', TRUE, TRUE, TRUE, TRUE, 74, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e', 'Asperge', TRUE, TRUE, TRUE, TRUE, 20, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0c1d2e3f-4a5b-6c7d-8e9f-0a1b2c3d4e5f', 'Champignon', TRUE, TRUE, TRUE, TRUE, 21, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1d2e3f4a-5b6c-7d8e-9f0a-1b2c3d4e5f6a', 'Betterave', TRUE, TRUE, TRUE, TRUE, 43, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2e3f4a5b-6c7d-8e9f-0a1b-2c3d4e5f6a7b', 'Céleri', TRUE, TRUE, TRUE, TRUE, 16, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3f4a5b6c-7d8e-9f0a-1b2c-3d4e5f6a7b8c', 'Poireau', TRUE, TRUE, TRUE, TRUE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a5b6c7d-8e9f-0a1b-2c3d-4e5f6a7b8c9d', 'Radis', TRUE, TRUE, TRUE, TRUE, 14, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5b6c7d8e-9f0a-1b2c-3d4e-5f6a7b8c9d0e', 'Navet', TRUE, TRUE, TRUE, TRUE, 22, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6c7d8e9f-0a1b-2c3d-4e5f-6a7b8c9d0e1f', 'Chou', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7d8e9f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a', 'Citrouille', TRUE, TRUE, TRUE, TRUE, 26, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8e9f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b', 'Potiron', TRUE, TRUE, TRUE, TRUE, 42, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a', 'Filet', FALSE, FALSE, TRUE, TRUE, 217, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8c7b6a5d-4e3f-2g1h-0i9j-8k7l6m5n4o3p', 'Côte', FALSE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7b6a5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2p', 'Épaule', FALSE, FALSE, TRUE, TRUE, 236, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1p', 'Cuisse', FALSE, FALSE, TRUE, TRUE, 209, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5d4c3b2a-1e0f-9g8h-7i6j-5k4l3m2n1o0p', 'Poitrine', FALSE, FALSE, TRUE, TRUE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4c3b2a1d-0e9f-8g7h-6i5j-4k3l2m1n0o9p', 'Foie', FALSE, FALSE, TRUE, TRUE, 136, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3b2a1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8p', 'Cœur', FALSE, FALSE, TRUE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7p', 'Langue', FALSE, FALSE, TRUE, TRUE, 224, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6p', 'Hachis', FALSE, FALSE, TRUE, TRUE, 332, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5p', 'Jambon', FALSE, FALSE, TRUE, TRUE, 145, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4p', 'Saucisse', FALSE, FALSE, TRUE, TRUE, 301, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3p', 'Rôti', FALSE, FALSE, TRUE, TRUE, 213, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2p', 'Escalope', FALSE, FALSE, TRUE, TRUE, 165, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1p', 'Entrecôte', FALSE, FALSE, TRUE, TRUE, 291, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0p', 'Lardon', FALSE, FALSE, TRUE, TRUE, 541, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9p', 'Rognon', FALSE, FALSE, TRUE, TRUE, 124, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8p', 'Andouillette', FALSE, FALSE, TRUE, TRUE, 263, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7p', 'Boudin', FALSE, FALSE, TRUE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6p', 'Cervelle', FALSE, FALSE, TRUE, TRUE, 125, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5p', 'Tripes', FALSE, FALSE, TRUE, TRUE, 94, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4p', 'Gigot', FALSE, FALSE, TRUE, TRUE, 294, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3p', 'Magret', FALSE, FALSE, TRUE, TRUE, 337, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2p', 'Paupiette', FALSE, FALSE, TRUE, TRUE, 220, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1p', 'Gésier', FALSE, FALSE, TRUE, TRUE, 147, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0p', 'Saumon', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9p', 'Thon', FALSE, FALSE, TRUE, TRUE, 184, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8p', 'Cabillaud', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7p', 'Crevettes', FALSE, FALSE, TRUE, TRUE, 99, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6p', 'Moules', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5p', 'Sardines', FALSE, FALSE, TRUE, TRUE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4p', 'Truite', FALSE, FALSE, TRUE, TRUE, 141, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3p', 'Maquereau', FALSE, FALSE, TRUE, TRUE, 205, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2p', 'Sole', FALSE, FALSE, TRUE, TRUE, 86, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1p', 'Dorade', FALSE, FALSE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0q', 'Lieu noir', FALSE, FALSE, TRUE, TRUE, 90, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9q', 'Merlu', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8q', 'Bar', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7q', 'Anchois', FALSE, FALSE, TRUE, TRUE, 131, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6q', 'Hareng', FALSE, FALSE, TRUE, TRUE, 203, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5q', 'Huitres', FALSE, FALSE, TRUE, TRUE, 69, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4q', 'Calmar', FALSE, FALSE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3q', 'Poulpe', FALSE, FALSE, TRUE, TRUE, 82, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2q', 'Homard', FALSE, FALSE, TRUE, TRUE, 89, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1q', 'Crabe', FALSE, FALSE, TRUE, TRUE, 97, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0r', 'Lait', TRUE, FALSE, TRUE, FALSE, 42, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9r', 'Fromage', TRUE, FALSE, TRUE, FALSE, 404, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8r', 'Yaourt', TRUE, FALSE, TRUE, FALSE, 61, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7r', 'Beurre', TRUE, FALSE, TRUE, FALSE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6r', 'Crème', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5r', 'Œuf', TRUE, FALSE, TRUE, TRUE, 144, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4r', 'Mozzarella', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3r', 'Parmesan', TRUE, FALSE, TRUE, FALSE, 436, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2r', 'Feta', TRUE, FALSE, TRUE, FALSE, 268, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1r', 'Ricotta', TRUE, FALSE, TRUE, FALSE, 140, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0s', 'Mascarpone', TRUE, FALSE, TRUE, FALSE, 800, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9s', 'Crème fraîche', TRUE, FALSE, TRUE, FALSE, 340, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8s', 'Fromage blanc', TRUE, FALSE, TRUE, FALSE, 98, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7s', 'Comté', TRUE, FALSE, TRUE, FALSE, 411, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6s', 'Roquefort', TRUE, FALSE, TRUE, FALSE, 375, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5s', 'Camembert', TRUE, FALSE, TRUE, FALSE, 304, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4s', 'Brie', TRUE, FALSE, TRUE, FALSE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3t', 'Riz', TRUE, TRUE, TRUE, TRUE, 130, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2t', 'Pâtes', TRUE, TRUE, FALSE, TRUE, 158, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1t', 'Quinoa', TRUE, TRUE, TRUE, TRUE, 120, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0t', 'Avoine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9t', 'Blé', TRUE, TRUE, FALSE, TRUE, 339, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8t', 'Orge', TRUE, TRUE, FALSE, TRUE, 123, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7t', 'Semoule', TRUE, TRUE, FALSE, TRUE, 360, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6t', 'Pain', TRUE, TRUE, FALSE, TRUE, 247, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5t', 'Tortilla', TRUE, TRUE, FALSE, TRUE, 298, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4t', 'Couscous', TRUE, TRUE, FALSE, TRUE, 112, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3u', 'Boulgour', TRUE, TRUE, FALSE, TRUE, 83, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2u', 'Millet', TRUE, TRUE, TRUE, TRUE, 119, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1u', 'Sarrasin', TRUE, TRUE, TRUE, TRUE, 92, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0u', 'Polenta', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9u', 'Tapioca', TRUE, TRUE, TRUE, TRUE, 358, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8u', 'Lentilles', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7u', 'Pois chiches', TRUE, TRUE, TRUE, TRUE, 164, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6u', 'Haricots rouges', TRUE, TRUE, TRUE, TRUE, 127, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5u', 'Haricots blancs', TRUE, TRUE, TRUE, TRUE, 139, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4u', 'Fèves', TRUE, TRUE, TRUE, TRUE, 110, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3v', 'Soja', TRUE, TRUE, TRUE, TRUE, 173, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2v', 'Edamame', TRUE, TRUE, TRUE, TRUE, 121, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1v', 'Flageolets', TRUE, TRUE, TRUE, TRUE, 128, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0v', 'Haricots noirs', TRUE, TRUE, TRUE, TRUE, 132, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9v', 'Pois cassés', TRUE, TRUE, TRUE, TRUE, 118, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8v', 'Amande', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7v', 'Noix', TRUE, TRUE, TRUE, TRUE, 661, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6v', 'Cacahuète', TRUE, TRUE, TRUE, TRUE, 575, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5v', 'Noix de cajou', TRUE, TRUE, TRUE, TRUE, 561, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4v', 'Graine de tournesol', TRUE, TRUE, TRUE, TRUE, 586, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3w', 'Graine de citrouille', TRUE, TRUE, TRUE, TRUE, 539, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2w', 'Sésame', TRUE, TRUE, TRUE, TRUE, 571, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1w', 'Noix de pécan', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0w', 'Pistache', TRUE, TRUE, TRUE, TRUE, 568, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9w', 'Noisette', TRUE, TRUE, TRUE, TRUE, 636, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8w', 'Noix de macadamia', TRUE, TRUE, TRUE, TRUE, 729, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7w', 'Graine de lin', TRUE, TRUE, TRUE, TRUE, 536, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6w', 'Graine de chia', TRUE, TRUE, TRUE, TRUE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5x', 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4x', 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3x', 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2x', 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1x', 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0x', 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9x', 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8x', 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7x', 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6x', 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5y', 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4y', 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3y', 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2y', 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1y', 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0y', 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9y', 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8y', 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7y', 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6y', 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5z', 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4z', 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3z', 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2z', 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1z', 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0z', 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9z', 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8z', 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7z', 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6z', 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5w', 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4w', 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3v', 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2v', 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1v', 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0v', 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9u', 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8u', 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7u', 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6u', 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5t', 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4t', 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3t', 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2t', 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1t', 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0t', 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9s', 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8s', 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7s', 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6s', 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5r', 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4r', 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3r', 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2r', 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1r', 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0r', 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9q', 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8q', 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7q', 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6q', 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5q', 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4q', 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3q', 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2q', 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1q', 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0q', 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9p', 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8p', 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7p', 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6p', 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5n', 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4n', 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3n', 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2n', 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1n', 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0n', 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8x', 'Basilic', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7x', 'Persil', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6x', 'Coriandre', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5x', 'Thym', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4x', 'Romarin', TRUE, TRUE, TRUE, TRUE, 67, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3x', 'Origan', TRUE, TRUE, TRUE, TRUE, 167, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2x', 'Cannelle', TRUE, TRUE, TRUE, TRUE, 231, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1x', 'Cumin', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0x', 'Paprika', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9x', 'Curry', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8y', 'Safran', TRUE, TRUE, TRUE, TRUE, 143, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7y', 'Gingembre', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6y', 'Muscade', TRUE, TRUE, TRUE, TRUE, 273, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5y', 'Cardamome', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4y', 'Anis étoilé', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3y', 'Clou de girofle', TRUE, TRUE, TRUE, TRUE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2y', 'Curcuma', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1y', 'Aneth', TRUE, TRUE, TRUE, TRUE, 33, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0z', 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9z', 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8z', 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 671, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7z', 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 50, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6z', 'Vinaigre balsamique', TRUE, TRUE, TRUE, TRUE, 88, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5z', 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 850, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4z', 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3z', 'Sauce Worcestershire', FALSE, FALSE, TRUE, TRUE, 100, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2z', 'Tabasco', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1z', 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 171, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0w', 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9w', 'Sauce béchamel', TRUE, FALSE, FALSE, FALSE, 107, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8w', 'Sauce hollandaise', TRUE, FALSE, TRUE, FALSE, 493, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7v', 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6v', 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5v', 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4v', 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7v', 'Eau', TRUE, TRUE, TRUE, TRUE, 0, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6v', 'Café', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5v', 'Thé', TRUE, TRUE, TRUE, TRUE, 1, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4v', 'Jus d''orange', TRUE, TRUE, TRUE, TRUE, 47, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3v', 'Vin', TRUE, FALSE, TRUE, TRUE, 83, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2v', 'Bière', TRUE, FALSE, FALSE, TRUE, 43, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1v', 'Lait de coco', TRUE, TRUE, TRUE, TRUE, 185, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0v', 'Cidre', TRUE, FALSE, TRUE, TRUE, 59, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9u', 'Cognac', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8u', 'Rhum', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7u', 'Vodka', TRUE, TRUE, TRUE, TRUE, 220, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6u', 'Whisky', TRUE, TRUE, TRUE, TRUE, 239, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5t', 'Sucre', TRUE, TRUE, TRUE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4t', 'Miel', TRUE, FALSE, TRUE, TRUE, 305, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3t', 'Chocolat', TRUE, FALSE, TRUE, FALSE, 554, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2t', 'Confiture', TRUE, TRUE, TRUE, TRUE, 280, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1t', 'Sirop d''érable', TRUE, TRUE, TRUE, TRUE, 260, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0t', 'Caramel', TRUE, FALSE, TRUE, FALSE, 300, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9s', 'Gelée', TRUE, FALSE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8s', 'Pâte d''amande', TRUE, TRUE, TRUE, TRUE, 700, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7s', 'Pâte à tartiner', TRUE, FALSE, TRUE, FALSE, 540, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6s', 'Crème de marrons', TRUE, TRUE, TRUE, TRUE, 223, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5r', 'Tofu', TRUE, TRUE, TRUE, TRUE, 76, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4r', 'Tempeh', TRUE, TRUE, TRUE, TRUE, 116, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3r', 'Seitan', TRUE, TRUE, FALSE, TRUE, 154, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2r', 'Lait d''amande', TRUE, TRUE, TRUE, TRUE, 13, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1r', 'Lait de soja', TRUE, TRUE, TRUE, TRUE, 33, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0r', 'Fromage végétal', TRUE, TRUE, TRUE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9q', 'Protéines de soja texturées', TRUE, TRUE, TRUE, TRUE, 667, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8q', 'Jackfruit', TRUE, TRUE, TRUE, TRUE, 95, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7q', 'Steak végétal', TRUE, TRUE, FALSE, TRUE, 168, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6q', 'Yaourt végétal', TRUE, TRUE, TRUE, TRUE, 41, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5p', 'Pizza', FALSE, FALSE, FALSE, FALSE, 266, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4p', 'Lasagne', FALSE, FALSE, FALSE, FALSE, 115, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3p', 'Quiche', FALSE, FALSE, FALSE, FALSE, 221, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2p', 'Sushi', FALSE, FALSE, FALSE, TRUE, 250, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1p', 'Burger', FALSE, FALSE, FALSE, FALSE, 208, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0p', 'Frites', TRUE, TRUE, TRUE, TRUE, 312, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9p', 'Nuggets de poulet', FALSE, FALSE, FALSE, FALSE, 308, '886ef1ff-004d-4446-b8b5-37fd9d9e8710');

  INSERT INTO ingredient(ingredient_id, ingredient_label, vegetarian, vegan, gluten_free, lactose_free, calorie, unit_id) VALUES
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8r', 'Farine', TRUE, TRUE, FALSE, TRUE, 379, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7r', 'Levure', TRUE, TRUE, TRUE, TRUE, 325, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6r', 'Bicarbonate de soude', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5s', 'Sel', TRUE, TRUE, TRUE, TRUE, 0, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4s', 'Poivre', TRUE, TRUE, TRUE, TRUE, 261, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3s', 'Bouillon', FALSE, FALSE, TRUE, TRUE, 4, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2s', 'Chapelure', TRUE, TRUE, FALSE, TRUE, 400, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1s', 'Fécule de maïs', TRUE, TRUE, TRUE, TRUE, 381, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0s', 'Gélatine', FALSE, FALSE, TRUE, TRUE, 329, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9t', 'Extrait de vanille', TRUE, TRUE, TRUE, TRUE, 286, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8t', 'Cacao en poudre', TRUE, TRUE, TRUE, TRUE, 240, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7t', 'Levure chimique', TRUE, TRUE, TRUE, TRUE, 50, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6t', 'Vinaigre', TRUE, TRUE, TRUE, TRUE, 20, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5u', 'Huile de tournesol', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4u', 'Huile de colza', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3u', 'Huile de sésame', TRUE, TRUE, TRUE, TRUE, 882, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('7a6b5c4d-3e2f-1g0h-9i8j-7k6l5m4n3o2u', 'Huile de noix', TRUE, TRUE, TRUE, TRUE, 886, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('6a5b4c3d-2e1f-0g9h-8i7j-6k5l4m3n2o1u', 'Huile d''olive', TRUE, TRUE, TRUE, TRUE, 881, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('5a4b3c2d-1e0f-9g8h-7i6j-5k4l3m2n1o0u', 'Sauce soja', TRUE, TRUE, FALSE, TRUE, 53, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9'),
  ('4a3b2c1d-0e9f-8g7h-6i5j-4k3l2m1n0o9v', 'Moutarde', TRUE, TRUE, TRUE, TRUE, 60, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('3a2b1c0d-9e8f-7g6h-5i4j-3k2l1m0n9o8v', 'Ketchup', TRUE, TRUE, TRUE, TRUE, 100, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('2a1b0c9d-8e7f-6g5h-4i3j-2k1l0m9n8o7v', 'Mayonnaise', TRUE, FALSE, TRUE, TRUE, 681, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('1a0b9c8d-7e6f-5g4h-3i2j-1k0l9m8n7o6v', 'Pesto', TRUE, FALSE, TRUE, FALSE, 387, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('0a9b8c7d-6e5f-4g3h-2i1j-0k9l8m7n6o5w', 'Sauce tomate', TRUE, TRUE, TRUE, TRUE, 25, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('9a8b7c6d-5e4f-3g2h-1i0j-9k8l7m6n5o4w', 'Sauce barbecue', TRUE, TRUE, TRUE, TRUE, 91, '886ef1ff-004d-4446-b8b5-37fd9d9e8710'),
  ('8a7b6c5d-4e3f-2g1h-0i9j-8k7l6m5n4o3w', 'Sauce aigre-douce', TRUE, TRUE, TRUE, TRUE, 110, 'f1e2d3c4-b5a6-4789-8901-2345f6g7h8i9');