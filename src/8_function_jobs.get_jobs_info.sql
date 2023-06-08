CREATE FUNCTION jobs.get_jobs_info
(
    p_position_name TEXT,
    p_parser jobs.parsers,
    p_from TIMESTAMPTZ,
    p_to TIMESTAMPTZ
)
RETURNS TABLE
    (
        user_id BIGINT,
        user_name VARCHAR(50),
        position_name TEXT,
        min_salary BIGINT,
        max_salary BIGINT,
        median_salary BIGINT,
        parser jobs.parsers,
        date TIMESTAMPTZ
    )
LANGUAGE plpgsql
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT tu.id as user_id, tu.name as user_name,
            tp.name as position_name, tp.min_salary, tp.max_salary, tp.median_salary, tp.parser, tp.date
            FROM jobs.tb_positions tp
            JOIN jobs.tb_user_has_position tup ON tp.id = tup.position_id
            JOIN jobs.tb_users tu ON tup.user_id = tu.id
            WHERE tp.name = p_position_name AND tp.parser = p_parser AND tp.date >= p_from AND tp.date <= p_to;
END;
$BODY$