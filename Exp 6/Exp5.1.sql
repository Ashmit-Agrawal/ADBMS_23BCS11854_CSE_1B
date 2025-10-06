CREATE OR REPLACE PROCEDURE get_employee_count_by_gender(
    IN p_gender VARCHAR,
    OUT p_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) 
    INTO p_count
    FROM employees
    WHERE gender = p_gender;

    RAISE NOTICE 'Total Employees of gender %: %', p_gender, p_count;
END;
$$;


CALL get_employee_count_by_gender('Male', NULL);
