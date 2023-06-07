CREATE FUNCTION jobs.get_all_jobs_info(
    p_limit INT
)
RETURNS TABLE
    (
        name TEXT,
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
        SELECT tp.name, tp.min_salary, tp.max_salary, tp.median_salary, tp.parser, tp.date
        FROM jobs.tb_positions tp
        LIMIT p_limit;
END;
$BODY$