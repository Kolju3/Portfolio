-- Create a cleaned version of the Inventory table.
-- Only standardises the 'location' field; no duplicate removal.
DROP TABLE IF EXISTS "Testing_Inventory_Cleaned";

CREATE TABLE "Testing_Inventory_Cleaned" AS
SELECT
    inventory_id,
    product_id,
    INITCAP(TRIM(location)) AS location,   -- e.g. 'tallinn' → 'Tallinn'
    quantity_available,
    reorder_point,
    last_updated
FROM "Inventory";