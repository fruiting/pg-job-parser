CREATE FUNCTION jobs.get_all_jobs_info_by_users()
RETURNS TABLE
    (
        jobs_info json,
        user_id BIGINT,
        user_name VARCHAR(50)
    )
LANGUAGE plpgsql
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT json_agg(tp) as jobs_info, tu.id as user_id, tu.name as user_name
            FROM jobs.tb_positions tp
            JOIN jobs.tb_user_has_position tup ON tp.id = tup.position_id
            JOIN jobs.tb_users tu ON tup.user_id = tu.id
            GROUP BY tu.id;
END;
$BODY$