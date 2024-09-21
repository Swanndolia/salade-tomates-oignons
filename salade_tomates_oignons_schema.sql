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
