CREATE TABLE jobs.tb_user_has_position (
   id SERIAL NOT NULL PRIMARY KEY,
   user_id BIGINT NOT NULL,
   position_id BIGINT NOT NULL,
   CONSTRAINT fk_user
       FOREIGN KEY(user_id)
           REFERENCES jobs.tb_users(id)
           ON DELETE CASCADE,
   CONSTRAINT fk_position
       FOREIGN KEY(position_id)
           REFERENCES jobs.tb_positions(id)
           ON DELETE CASCADE,
   UNIQUE (user_id, position_id)
);
