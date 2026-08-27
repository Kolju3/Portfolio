-- Duplicate the Products table
CREATE TABLE "Testing_Products" (LIKE "Products" INCLUDING ALL);
INSERT INTO "Testing_Products" SELECT * FROM "Products";

-- Duplicate the Customers table
CREATE TABLE "Testing_Customers" (LIKE "Customers" INCLUDING ALL);
INSERT INTO "Testing_Customers" SELECT * FROM "Customers";

/*LIKE "Products" INCLUDING ALL copies the column definitions, data types, default values, constraints (primary keys, foreign keys, checks, not-null), indexes, and storage settings.

The INSERT statement copies every row from the original table into the new duplicate.

If you only need the table structure without the data, omit the INSERT statements. 
If you need only data without constraints, you could use CREATE TABLE "Testing_Products" AS TABLE "Products";, but the approach above is the most comprehensive duplicate.*/