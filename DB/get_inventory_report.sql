DELIMITER $$

DROP PROCEDURE IF EXISTS get_inventory_report; $$

CREATE PROCEDURE get_inventory_report()
BEGIN
    SELECT 
        p.product_id,
        p.sku,
        p.name,
        COALESCE(SUM(i.quantity), 0) AS stock,
        p.price,
        (COALESCE(SUM(i.quantity), 0) * p.price) AS total_value
    FROM product p
    LEFT JOIN inventory i ON p.product_id = i.product_id
    GROUP BY p.product_id, p.sku, p.name, p.price;
END $$

DELIMITER ;