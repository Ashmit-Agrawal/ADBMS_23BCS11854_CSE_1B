CREATE OR REPLACE PROCEDURE process_order(
    IN p_product_id INT,
    IN p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC(10,2);
    v_remaining INT;
    v_total NUMERIC(10,2);
BEGIN
    -- Get product details
    SELECT price, quantity_remaining 
    INTO v_price, v_remaining
    FROM products
    WHERE product_id = p_product_id;

    -- Check stock availability
    IF v_remaining IS NULL THEN
        RAISE NOTICE 'Product not found!';
        RETURN;
    END IF;

    IF v_remaining >= p_quantity THEN
        -- Calculate total price
        v_total := v_price * p_quantity;

        -- Insert order in sales
        INSERT INTO sales (product_id, quantity, total_price)
        VALUES (p_product_id, p_quantity, v_total);

        -- Update inventory
        UPDATE products
        SET quantity_remaining = quantity_remaining - p_quantity,
            quantity_sold = quantity_sold + p_quantity
        WHERE product_id = p_product_id;

        RAISE NOTICE 'Product sold successfully!';
    ELSE
        RAISE NOTICE 'Insufficient Quantity Available!';
    END IF;
END;


CALL process_order(1, 2);

