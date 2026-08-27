SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi, --Changes missing first names to 'Tundmatu'
    COALESCE(email, 'puudub@urbanstyle.ee') AS email --Changes missing emails to 'puudub@urbanstyle.ee'
FROM "Testing_Customers";
