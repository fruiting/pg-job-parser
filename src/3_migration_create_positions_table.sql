CREATE TABLE jobs.tb_positions (
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    min_salary BIGINT NOT NULL,
    max_salary BIGINT NOT NULL,
    median_salary BIGINT NOT NULL,
    parser jobs.parsers NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    UNIQUE(name, parser)
);

CREATE UNIQUE INDEX ix_tb_jobs_positions ON jobs.tb_positions (parser, name)
