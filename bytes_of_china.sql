-- Task Group 1: Create Tables and Primary Keys --

CREATE TABLE restaurant (
  id integer PRIMARY KEY,
  name varchar(20),
  description varchar(100),
  rating decimal,
  telephone char(10),
  hours varchar(100)
);

CREATE TABLE address (
  id integer PRIMARY KEY,
  restaurant_id integer REFERENCES restaurant(id),
  street_number varchar(20),
  street_name varchar(20),
  city varchar(20),
  state varchar(35),
  google_map_link varchar(50)
);

--Task Group 2: Define Relationships and Foreign Keys--

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'restaurant';

  SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'address';

CREATE TABLE category (
  id char(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
);

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'category';

CREATE TABLE dish (
    id integer PRIMARY KEY,
    name varchar(50),
    description varchar(200),
    hot_and_spicy boolean
);

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'dish';

CREATE TABLE review (
  id integer PRIMARY KEY,
  restaurant_id integer REFERENCES restaurant(id),
  rating decimal,
  description varchar(100),
  date date
);

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'review';

CREATE TABLE categories_dishes (
  category_id char(2) REFERENCES category(id),
  dish_id integer REFERENCES dish(id),
  price money,
  PRIMARY KEY (category_id, dish_id)
);
 
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'categories_dishes';

---Task Group 3: Insert Sample Data---

INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

SELECT * FROM restaurant;

INSERT INTO address VALUES (
  1,
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/BytesOfChina'  
);

SELECT * FROM address;

INSERT INTO review VALUES (
  1,
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020'  
);

INSERT INTO review VALUES (
  2,
  1,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020'
);

INSERT INTO review VALUES (
  3,
  1,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020'
);

SELECT * FROM review;

INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

SELECT * FROM category;

INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

SELECT * FROM dish;

INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

SELECT * FROM categories_dishes;

--Task Group 4: Make Sample Queries--

--Query to get the best rating the restaurant ever received--

SELECT MAX(rating) FROM review;

-- Query to display a dish name, its price and category sorted by the dish name.--

SELECT
dish.name as dish_name, category.name as category, categories_dishes.price as price
FROM dish, categories_dishes, category
WHERE
category.id = categories_dishes.category_id AND
categories_dishes.dish_id = dish.id
ORDER BY dish.name;

--New query to display the results as follows, sorted by category name--

SELECT category.name AS category, dish.name AS dish_name, categories_dishes.price FROM category, dish, categories_dishes
WHERE categories_dishes.dish_id = dish.id AND categories_dishes.category_id = category.id
ORDER BY category.name;

--New query to displays all the spicy dishes, their prices and category --

SELECT dish.name AS spicy_dish_name,
       category.name AS category,
       categories_dishes.price
FROM dish, category, categories_dishes
WHERE categories_dishes.dish_id = dish.id AND categories_dishes.category_id = category.id AND hot_and_spicy = true;

--Query that displays the dish_id and COUNT(dish_id) as dish_count from the categories_dishes table.--

SELECT dish_id, COUNT(dish_id) AS dish_count FROM categories_dishes
GROUP BY 1 ORDER BY 1;

--Query to display only the dish(es) from the categories_dishes table which appears more than once.--

SELECT dish_id, COUNT(dish_id) AS dish_count FROM categories_dishes
GROUP BY 1 HAVING COUNT(dish_id) > 1 ORDER BY 1;

-- Query which tells us exactly the name(s) of the dish that appears more than once in the categories_dishes table.

SELECT dish.name AS dish_name, dish_id, COUNT(dish_id) AS dish_count FROM dish, categories_dishes
WHERE dish.id = categories_dishes.dish_id
GROUP BY 1, 2 ORDER BY 3;

SELECT dish.name AS dish_name, dish_id, COUNT(dish_id) AS dish_count FROM dish, categories_dishes
WHERE dish.id = categories_dishes.dish_id
GROUP BY 1, 2 HAVING COUNT(dish_id) > 1 ORDER BY 3;

-- Query that displays the best rating as best_rating and the description too. 

SELECT rating, description FROM review WHERE rating = (SELECT MAX(rating) FROM review);