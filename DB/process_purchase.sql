DELIMITER $$

DROP PROCEDURE IF EXISTS process_purchase; $$

CREATE PROCEDURE process_purchase(
    IN p_supplier_id INT,
    IN p_warehouse_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_unitary_price DECIMAL(10,2),
    IN p_order_date DATETIME,
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE v_purchase_order_id INT;
    DECLARE v_existing_inventory INT;

    -- Crear la orden de compra
    INSERT INTO purchase_order (supplier_id, warehouse_id, order_date, total) 
    VALUES (p_supplier_id, p_warehouse_id, p_order_date, 0);

    SET v_purchase_order_id = LAST_INSERT_ID(); -- Obtener el ID de la orden de compra creada

    -- Insertar el detalle de compra
    INSERT INTO purchase_order_item (purchase_order_id, product_id, quantity, unitary_price) 
    VALUES (v_purchase_order_id, p_product_id, p_quantity, p_unitary_price);

    -- Verificar si el producto ya existe en el inventario del almacén
    SELECT inventory_id INTO v_existing_inventory
    FROM inventory
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    IF v_existing_inventory IS NOT NULL THEN
        -- Si ya existe, actualizar la cantidad sumándola
        UPDATE inventory 
        SET quantity = quantity + p_quantity 
        WHERE inventory_id = v_existing_inventory;
    ELSE
        -- Si no existe, agregarlo al inventario
        INSERT INTO inventory (product_id, warehouse_id, quantity) 
        VALUES (p_product_id, p_warehouse_id, p_quantity);
    END IF;

    -- Actualizar el total en purchase_order
    UPDATE purchase_order 
    SET total = (p_quantity * p_unitary_price) 
    WHERE purchase_order_id = v_purchase_order_id;

    SET p_result = 'Compra procesada correctamente.';
END $$

DELIMITER ;