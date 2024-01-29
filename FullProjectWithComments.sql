#Mock database for a small translation company.
#The purpose of this database is to organise data on clients' orders and translators' tasks.
#The database can be also used to calculate estimated and real order prices and translators' commissions.
#It can be also used to assign correct translator to the customer's order.

#Create database "translations".

CREATE DATABASE translations;

USE translations;

#Create tables with primary keys.

#Table storing clients' orders information:
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
    client_id INT,
    order_placed_date DATETIME,
    order_deadline DATETIME,
    source_page_amount DECIMAL(10,2), # Number of pages of original document. It will be used for price estimation only as charging for target page amount is an industry standard.
    source_language CHAR(2), #Language of original document that is meant to be translated. Two characters language code.
    target_language CHAR(2), #The document will be translated into target language. Two characters language code.
    task_id INT	
   );
   
#Table storing translators tasks:   
CREATE TABLE tasks(
	task_id INT PRIMARY KEY,
    task_assigned_date DATETIME,
    task_submitted_date DATETIME,
    task_status ENUM("Not assigned", "Assigned", "Completed") DEFAULT "Not assigned",
    translator_id INT,
    target_page_amount DECIMAL(10,2) #Page amount of translated file in target language. It will be used to calculate the final order price as per industry standard.
    );

#Table storing clients contact information:    
CREATE TABLE clients(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(50) Not Null,
    client_email VARCHAR(30)
    );

#Table storing basic translator information (name, contact, level):
CREATE TABLE translators(
	translator_id INT PRIMARY KEY,
    translator_name VARCHAR(50) Not Null,
    translator_email VARCHAR(30),
    translator_level VARCHAR(30) #It will be used to calculate translator's commission.
    );

#Table storing translators' language pairs (languages that they are able to translate from/into):
CREATE TABLE trans_language_pairs(
	translator_id INT,
	source_language CHAR(2),
	target_language CHAR(2)
    );

#Table storing price list for every languahe pair:
CREATE TABLE prices(
	source_language CHAR(2), #Two characters language code.
    target_language CHAR(2), #Two characters language code.
    price_per_page DECIMAL(6,2),
    CONSTRAINT pk_language_pair PRIMARY KEY (source_language, target_language)
    );

    
#Table listing translators' career levels and commission rates in the company:
CREATE TABLE trans_levels(
	translator_level VARCHAR(30) PRIMARY KEY,
    translator_commission DECIMAL(2,2) Not Null #Value (rate) used to calculate translator's commission.
    );
 
#Add foreign key constraints to tables.
 
ALTER TABLE orders
ADD CONSTRAINT FOREIGN KEY (client_id) REFERENCES clients(client_id),
ADD CONSTRAINT FOREIGN KEY (task_id) REFERENCES tasks(task_id),
ADD CONSTRAINT FOREIGN KEY (source_language, target_language) REFERENCES prices(source_language, target_language);

ALTER TABLE tasks
ADD CONSTRAINT FOREIGN KEY (translator_id) REFERENCES translators(translator_id);

ALTER TABLE translators
ADD CONSTRAINT FOREIGN KEY (translator_level) REFERENCES trans_levels(translator_level);

ALTER TABLE trans_language_pairs
ADD CONSTRAINT FOREIGN KEY (translator_id) REFERENCES translators(translator_id),
ADD CONSTRAINT FOREIGN KEY (source_language, target_language) REFERENCES prices(source_language, target_language);

#Insert data into tables.

#Prices per language pair:
INSERT INTO prices
(source_language, target_language, price_per_page)
VALUES
("EN", "PT", 28),
("PT", "EN", 23),
("EN", "PL", 30),
("PL", "EN", 25),
("EN", "CZ", 32),
("CZ", "EN", 27),
("EN", "JP", 50),
("JP", "EN", 30);

#Translators levels and commission per level:
INSERT INTO trans_levels
(translator_level, translator_commission)
VALUES
("New joiner", 0.25),
("Junior", 0.35),
("Senior", 0.45);

#Translators list with their contact information and level:
INSERT INTO translators
(translator_id, translator_name, translator_email, translator_level)
VALUES
(1, "Karen", "karen@company.com", "Senior"),
(2, "Hiroshi", "hiroshi@company.com", "Senior"),
(3, "Katka", "katka@company.com", "Senior"),
(4, "Geraldine", "geraldine@company.com", "New joiner"),
(5, "Karolina", "karolina@company.com", "Junior"),
(6, "Albert", "albert@company.com", "New joiner"),
(7, "Patricia", "patricia@company.com", "Senior"),
(8, "Philip", "philip@company.com", "Junior"),
(9, "Maria", "maria@company.com", "Senior"),
(10, "Sofia", "sofia@company.com", "Junior"); 

#Language pairs assigned to translators. Languages that they are able to translate from/to:
INSERT INTO trans_language_pairs 
(translator_id, source_language, target_language)
VALUES
(1, "EN", "PT"),
(1, "PT", "EN"),
(1, "PL", "EN"),
(2, "EN", "JP"),
(2, "JP", "EN"),
(3, "EN", "CZ"),
(3, "CZ", "EN"),
(3, "PL", "EN"),
(4, "JP", "EN"),
(5, "EN", "CZ"),
(5, "EN", "PL"),
(6, "JP", "EN"),
(7, "PT", "EN"),
(7, "EN", "PT"),
(7, "PL", "EN"),
(7, "EN", "PL"),
(8, "CZ", "EN"),
(8, "PT", "EN"),
(9, "PL", "EN"),
(9, "EN", "PL"),
(9, "PT", "EN"),
(10, "JP", "EN"),
(10, "CZ", "EN");

#Clients and their contact information:
INSERT INTO clients
(client_id, client_name, client_email)
VALUES
(1, "Super Serious Company", "info@superserious.co"),
(2, "Movies4U", "subtitles@movies4u.eu"),
(3, "BeFit", "ecommerce@befit.cz"),
(4, "Purple Games", "orders@purplegames.pl"),
(5, "Lisbon Fashion", "ecommerce@lisbonfashion.pt"),
(6, "Today", "today@magazine.com");


# Translation tasks assigned or to be assigned to translators with their start/end date, task status, translator and number of pages of translated document.
INSERT INTO tasks
(task_id, task_assigned_date, task_submitted_date, task_status, translator_id, target_page_amount)
VALUES
(1, "2023-01-07 17:00", "2023-01-15 09:00", "Completed", 1, 49.5),
(2, "2023-01-21 12:30", "2023-01-29 19:37", "Completed", 8, 31.1),
(3, "2023-01-23 08:00", "2023-01-28 8:37", "Completed", 2, 8.1),
(4, "2023-02-13 09:00", "2023-02-15 12:15", "Completed", 2, 5.2),
(5, "2023-02-13 09:00", "2023-02-15 15:55", "Completed", 4, 20.3),
(6, "2023-02-15 15:36", "2023-02-28 17:30", "Completed", 7, 60.1),
(7, "2023-03-02 08:21", "2023-03-19 17:36", "Completed", 8, 118.3),
(8, "2023-03-02 09:01", "2023-03-20 15:48", "Completed", 1, 113.2),
(9, "2023-03-12 15:36", "2023-03-18 6:34", "Completed", 9, 35.8),
(10, "2023-03-25 21:13", "2023-04-24 21:00", "Completed", 3, 79.3),
(11, "2023-04-01 15:21", "2023-04-16 09:00", "Completed", 5, 55), 
(12, "2023-04-06 8:00", "2023-04-19 15:54", "Completed", 10, 190.5),
(13, "2023-04-15 15:03", "2023-04-21 13:01", "Completed", 6, 55.3),
(14, "2023-04-22 8:05", "2023-04-30 08:00", "Completed", 10, 26.7),
(15, "2023-05-04 9:14", "2023-05-27 23:59", "Completed", 7, 202.5),
(16, "2023-05-06 08:00", "2023-05-27 12:57", "Completed", 3, 114.1),
(17, "2023-05-15 10:00", "2023-05-30 13:46", "Completed", 5, 151.3),
(18, "2023-05-15 12:34", "2023-05-28 06:13", "Completed", 1, 52.4),
(19, "2023-06-02 07:45", "2023-06-15 18:49", "Completed", 4, 64.8),
(20, "2023-06-02 08:45", "2023-06-28 07:43", "Completed", 9, 141.5),
(21, "2023-07-23 19:00", Null, "Assigned", 9, Null),
(22, "2023-07-22 11:23", Null, "Assigned", 7, Null),
(23, Null , Null , "Not Assigned", Null, Null),
(24, "2023-08-16 08:26", "2023-08-16 17:02", "Completed", 7, 110.2),
(25, Null, Null, "Not Assigned", Null, Null),
(26, "2023-07-23 18:22", Null, "Assigned", 3, Null);

# Translation orders placed by clients with start/end date, page amount in original document, source/target language 
# and task_id if assigned and Null if not assigned to translator yet.
INSERT INTO orders
(order_id, client_id, order_placed_date, order_deadline, source_page_amount, source_language, target_language, task_id)
VALUES
(1, 5, "2023-01-07 15:13", "2023-01-15 15:00", 53.6, "PT", "EN", 1),
(2, 3, "2023-01-21 11:37", "2023-01-30 15:00", 32.5, "CZ", "EN", 2),
(3, 6, "2023-01-22 15:00", "2023-01-28 15:00", 15.3, "EN", "JP", 3),
(4, 1, "2023-02-12 13:13", "2023-02-15 13:00", 10.3, "EN", "JP", 4),
(5, 1, "2023-02-12 13:13", "2023-02-15 13:00", 13.1, "JP", "EN", 5),
(6, 6, "2023-02-15 15:36", "2023-02-28 17:30", 50.1, "EN", "PT", 6),
(7, 2, "2023-03-01 21:33", "2023-03-20 8:00", 120.6, "CZ", "EN", 7),
(8, 2, "2023-03-01 21:37", "2023-03-20 8:00", 115.7, "EN", "PT", 8),
(9, 4, "2023-03-12 12:36", "2023-03-18 8:30", 32.7, "EN", "PL", 9),
(10, 1, "2023-03-25 15:00", "2023-04-25 08:00", 77.5, "CZ", "EN", 10),
(11, 5, "2023-04-01 13:45", "2023-04-15 09:00", 50.1, "EN", "PL", 11),
(12, 3, "2023-04-05 23:04", "2023-04-20 09:00", 100.1, "JP", "EN", 12), 
(13, 6, "2023-04-15 07:13", "2023-04-21 15:00", 30.5, "JP", "EN", 13),
(14, 2, "2023-04-21 15:03", "2023-04-29 18:00", 27.5, "CZ", "EN", 14),
(15, 2, "2023-05-03 19:15", "2023-05-28 08:00", 203.7, "PT", "EN", 15),
(16, 4, "2023-05-05 15:43", "2023-05-27 10:30", 116.3, "CZ", "EN", 16),
(17, 3, "2023-05-15 9:13", "2023-06-01 06:00", 117.5, "EN", "PL", 17),
(18, 5, "2023-05-15 10:15", "2023-05-27 09:30", 47.9, "EN", "PT", 18),
(19, 6, "2023-06-01 15:37", "2023-06-15 15:30", 30.3, "JP", "EN", 19),
(20, 1, "2023-06-01 16:15", "2023-06-28 08:00", 158.3, "PL", "EN", 20),
(21, 4, "2023-06-12 12:54", "2023-08-16 08:00", 13.8, "EN", "PT", 21),
(22, 1, "2023-07-01 15:36", "2023-07-13 09:15", 12.5, "PT", "EN", 22),
(23, 5, "2023-07-22 09:23", "2023-08-25 08:00", 203, "EN", "PT", 23),
(24, 2, "2023-07-23 15:43", "2023-08-08 21:15", 84.2, "PL", "EN", 26),
(25, 3, "2023-07-27 13:40", "2023-08-19 08:00", 23.4, "EN", "CZ", Null),
(26, 6, "2023-08-05 17:23", "2023-08-25 08:00", 53.6, "PT", "EN", 24),
(27, 5, "2023-08-01 16:42", "2023-08-23 8:45", 111.6, "PT", "EN", 25),
(28, 6, "2023-08-03 16:43", "2023-09-21 09:00", 501, "JP", "EN", Null),
(29, 4, "2023-08-01 15:43", "2023-08-20 8:00", 115.6, "EN", "PL", Null),
(30, 1, "2023-08-09 12:35", "2023-08-27 16:30", 55.7, "EN", "CZ", Null);

###########################################################################################
select * from clients;
select * from orders;
select * from prices;
select * from tasks;
select * from trans_language_pairs;
select * from trans_levels;
select * from translators;


# EXAMPLE QUERIES

# Senario 1: The company has a special offer for clients who made at least 5 orders.
# The query below returns number of total orders from every client if number of orders is greater or equal 5.

SELECT c.client_name, COUNT(order_id) AS order_count
FROM orders o
	JOIN clients c on c.client_id = o.client_id
GROUP BY o.client_id
HAVING order_count >= 5
ORDER BY client_name;

###

# Scenario 2: The company is planning to compensate delivery delays to their clients.
# The query below returns client names with the total number of delayed orders in descending order.

SELECT c.client_name,
	(SELECT COUNT(o.order_id)
		FROM orders o
		WHERE o.client_id = c.client_id
		AND (SELECT COUNT(t.task_id) 
			FROM tasks t
			WHERE o.task_id = t.task_id
            AND o.order_deadline < t.task_submitted_date # Task submitted after the deadline.
			)>0 # Task submitted after the deadline at least once.
) AS delay_count
FROM clients c
ORDER BY delay_count DESC;

#####################################################################################################################

# VIEWS:

#VIEW 1
# View with translators' total commissions per month grouped by months and translator names.
# Translator commission is being calculated by multiplying total price and commission rate inducated by translator's level.
# Total price is being calculated by multiplying page amount in target language (rounded up - industry standard) by price per language pair. 

CREATE VIEW Commission_by_month
AS SELECT 
	Month(task_submitted_date) AS sub_month, 
	Year(task_submitted_date) AS sub_year,	# Task submission month and year.
    trans.translator_name, 	
    SUM(ROUND(CEILING(t.target_page_amount)*(p.price_per_page)*(l.translator_commission), 2)) AS monthly_commission
    
# To be able to perform commission calculations we are joining 5 tables (translators, tasks, trans_levels, orders, prices):
	FROM translators trans
		JOIN tasks t on trans.translator_id = t.translator_id
		JOIN trans_levels l on trans.translator_level = l.translator_level
		JOIN orders o on t.task_id = o.task_id
		JOIN prices p on o.source_language = p.source_language AND o.target_language = p.target_language

# We will perform commission calculations only on Completed tasks:    
	WHERE t.task_status = "Completed"

	GROUP BY sub_month, sub_year, trans.translator_name
	ORDER BY sub_month, sub_year, trans.translator_name;

# Return all the data available in Commission_by_month view:

SELECT * from Commission_by_month;

# EXAMPLE OF USE Commission_by_month view: Return 2023 total commissions for translators sorted by annual commission in descending order.

SELECT sub_year, 
		translator_name, 
		SUM(monthly_commission) AS annual_commission
FROM Commission_by_month
WHERE sub_year = "2023"
GROUP BY translator_name
ORDER BY annual_commission DESC;

###

#VIEW 2
# View with estimated order prices for clients. It is being calculated based on source page amount rounded up and multiplied by language pair page rate.

CREATE VIEW Estimated_order_price
AS SELECT 
	o.order_id,
    c.client_name,
    ROUND(CEILING(o.source_page_amount)*(p.price_per_page)) AS estimated_price
    
# To be able to perform estimated price calculations we are joining 3 tables (orders, clients and prices):
	FROM orders o
		JOIN clients c on o.client_id = c.client_id
		JOIN prices p on o.source_language = p.source_language AND o.target_language = p.target_language
	ORDER BY order_id DESC;

# EXAMPLE OF USE Estimated_order_price view: Check estimated price for order_id 29:

SELECT * FROM Estimated_order_price WHERE order_id = 29;

# EXAMPLE OF USE Estimated_order_price view: Check estimated sum of order prices for Super Serious Company:
SELECT client_name, SUM(estimated_price) AS estimated_sum FROM Estimated_order_price WHERE client_name = "Super Serious Company";


#####################################################################################################################

#FUNCTION:

#Function returning translator's workload. Returns number of pages currently assigned to the translator.

DELIMITER //
CREATE FUNCTION translator_workload(translator_id int)
RETURNS INT
DETERMINISTIC
BEGIN 
	DECLARE workload INT;
    SELECT SUM(source_page_amount) INTO workload
    FROM tasks t
    JOIN orders o on t.task_id = o.task_id #Join by task_id to get assigned tasks.
    WHERE translator_id = t.translator_id AND task_status != "Completed"; #Results only for specific translator and not completed tasks.
    RETURN COALESCE(workload, 0); #Return 0 for Null values.
END //
DELIMITER ;

# EXAMPLE OF USE translator_workload() function: Return number of pages currently assigned to the translator 3: 
SELECT translator_workload(1);

# EXAMPLE OF USE translator_workload() function is also being used in the procedure below.

#####################################################################################################################

#PROCEDURE:

# Procedure AssignTranslator matches the order with the translator with the best availability for given language pair.
# Best availability means the lowest number of translation pages assigned to the translator at the moment.
# This procedure inserts new task ID, assigned date, status & translator_id to the tasks table.
# It also updates the order entry by populating task_id field.
# NOTE: Make sure that there is no task_id assigned for the order BEFORE running this procedure for the order_id.

DELIMITER //
CREATE PROCEDURE AssignTranslator(
IN order_id INT)
BEGIN

DECLARE src_lang, trg_lang CHAR(2);
DECLARE trans INT;
DECLARE old_task_id INT;

# Find order's source and target language:
SELECT source_language, target_language INTO src_lang, trg_lang 
FROM orders 
WHERE orders.order_id = order_id;

# Find translators who are able to work on given language pair: 
SELECT translator_id INTO trans 
FROM trans_language_pairs 
WHERE source_language = src_lang 
AND target_language = trg_lang

# Use translator_workload() function to find out how many pages are assigned to the translators at the moment.
# Sort ascending to identify the least busy translator.
# If more than one translator has the same page amount assigned, choose the first one on the list.
ORDER BY translator_workload(trans) ASC LIMIT 1;

# Identify the highest task_id number in the tasks table:    
SELECT MAX(task_id) INTO old_task_id FROM tasks;

# Insert the new task into the tasks table.
INSERT INTO tasks
(task_id, task_assigned_date, task_status, translator_id)
VALUES 
(old_task_id + 1, NOW(), "Assigned", trans);

# Update orders table - reference newly created task in corresponding client's order.
UPDATE orders
SET task_id = old_task_id + 1
WHERE orders.order_id = order_id;
END//
DELIMITER ;

# EXAMPLE OF USE AssignTranslator procedure:
 
# First return a list of order IDs with no task ID assigned. 

SELECT order_id AS unassigned 
FROM orders 
WHERE task_id IS NULL;

# Then we can CALL manually AssignTranslator(order_id) to assign task to the translator.
# We can see that order_id 25 is not assigned to anybody. Let's assign it to the translator: 

CALL AssignTranslator(25);

# Let's check if it worked:

SELECT * FROM orders WHERE order_id = 25;

# We see that task_id = 27 has been assigned to the order. Let's check the tasks table:

SELECT * FROM tasks WHERE task_id = 27 

############################################################################################

#TRIGGER:

# Trigger insert_lang_pair ensures that new language pair is added to prices table 
# BEFORE assigning new language pair to translator (in translator language pairs table). 

DELIMITER //
CREATE TRIGGER insert_lang_pair BEFORE INSERT ON trans_language_pairs
FOR EACH ROW
BEGIN
	IF (NEW.source_language, NEW.target_language) NOT IN(SELECT prices.source_language, prices.target_language FROM prices) THEN
		INSERT INTO prices
		(source_language, target_language, price_per_page)
		VALUES
		(NEW.source_language, NEW.target_language, Null);
        END IF;
END; //
DELIMITER ; 

# EXAMPLE OF USE insert_lang_pair trigger:
# Scenario: Translator 1 starts to work on Portuguese to French translations and our records need to be updated.

# Check data in tables before inserting. Note that there is no PT-FR language pair yet in both tables:

SELECT * FROM trans_language_pairs WHERE translator_id = 1;
SELECT * FROM prices;

# Adding new language pair (Portuguese to French) for translator 1:

INSERT INTO trans_language_pairs
(translator_id, source_language, target_language)
VALUES
(1, "PT", "FR"); 

# Check data in tables after inserting:

SELECT * FROM trans_language_pairs WHERE translator_id = 1;
SELECT * FROM prices;

# Price per page is Null for now - it will be updated later manually by the sales manager.