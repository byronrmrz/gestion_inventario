DELIMITER $$

CREATE PROCEDURE process_sale(
    IN p_user_id INT,
    IN p_product_id INT,
    IN p_warehouse_id INT,
    IN p_quantity INT,
    IN p_unitary_price DECIMAL(10,2),
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE v_available_stock INT;
    DECLARE v_total DECIMAL(10,2);
    
    -- Verificar stock disponible
    SELECT quantity INTO v_available_stock 
    FROM inventory 
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    IF v_available_stock IS NULL THEN
        SET p_result = 'Producto no encontrado en inventario.';
    ELSEIF v_available_stock < p_quantity THEN
        SET p_result = 'Stock insuficiente.';
    ELSE
        -- Registrar la venta en sales
        INSERT INTO sales (user_id, date, total) 
        VALUES (p_user_id, NOW(), 0);
        
        SET @sale_id = LAST_INSERT_ID();
        
        -- Calcular el total de la venta
        SET v_total = p_quantity * p_unitary_price;

        -- Insertar en sales_detail
        INSERT INTO sales_detail (sale_id, product_id, quantity, unitary_price, warehouse_id) 
        VALUES (@sale_id, p_product_id, p_quantity, p_unitary_price, p_warehouse_id);

        -- Descontar del inventario
        UPDATE inventory 
        SET quantity = quantity - p_quantity 
        WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

        -- Actualizar total en sales
        UPDATE sales 
        SET total = v_total 
        WHERE sale_id = @sale_id;

        SET p_result = 'Venta procesada correctamente.';
    END IF;
END $$

DELIMITER ;