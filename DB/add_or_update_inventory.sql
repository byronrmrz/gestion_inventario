DELIMITER $$

CREATE PROCEDURE add_or_update_inventory(
    IN p_warehouse_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE v_existing_id INT;

    -- Verifico si ya existe el producto en el almacén
    SELECT inventory_id INTO v_existing_id
    FROM inventory
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    IF v_existing_id IS NOT NULL THEN
        -- Si ya existe, actualizo la cantidad
        UPDATE inventory
        SET quantity = quantity + p_quantity
        WHERE inventory_id = v_existing_id;
        SET p_result = 'Inventory updated successfully';
    ELSE
        -- Si no existe, inserto un nuevo registro
        INSERT INTO inventory (product_id, warehouse_id, quantity)
        VALUES (p_product_id, p_warehouse_id, p_quantity);
        SET p_result = 'Item added successfully';
    END IF;
END $$

DELIMITER ;