CREATE TABLE jobs.tb_positions (
    id BIGINT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    min_salary BIGINT NOT NULL,
    max_salary BIGINT NOT NULL,
    median_salary BIGINT NOT NULL,
    parser jobs.parsers NOT NULL,
    user_id BIGINT NOT NULL FOREIGN KEY REFERENCES jobs.tb_users,
    cdate TIMESTAMPTZ NOT NULL,
);

CREATE INDEX ix_tb_jobs_positions ON jobs.tb_positions using btree (parser, name, cdate)
