CREATE PROCEDURE jobs.set_jobs_info
(
    p_user_id BIGINT,
    p_user_name VARCHAR(50),
    p_position_name TEXT,
    p_min_salary BIGINT,
    p_max_salary BIGINT,
    p_median_salary BIGINT,
    p_parser jobs.parsers
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
    user_id INTEGER;
    position_id INTEGER;
BEGIN
    --Inserting user info
    INSERT INTO jobs.tb_users (id, name)
    VALUES (p_user_id, p_user_name)
    ON CONFLICT (id) DO NOTHING
    RETURNING id INTO user_id;

    IF user_id IS NULL
    THEN
        SELECT id FROM jobs.tb_users INTO user_id;
    END IF;

    --Inserting jobs info
    INSERT INTO jobs.tb_positions (name, min_salary, max_salary, median_salary, parser, date)
    VALUES (p_position_name, p_min_salary, p_max_salary, p_median_salary, p_parser, current_timestamp)
    ON CONFLICT (parser, name)
    DO
        UPDATE SET name = p_position_name,
            min_salary = p_min_salary,
            max_salary = p_max_salary,
            median_salary = p_median_salary,
            parser = p_parser,
            date = current_timestamp
    RETURNING id INTO position_id;

    IF position_id IS NULL
    THEN
        SELECT id FROM jobs.tb_positions INTO position_id;
    END IF;

    --Inserting relation
    INSERT INTO jobs.tb_user_has_position (user_id, position_id)
    VALUES (user_id, position_id)
    ON CONFLICT DO NOTHING;
END
$BODY$;
