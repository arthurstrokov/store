CREATE TABLE IF NOT EXISTS T_AUDIT (
  ID         BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  USER_ID    BIGINT      NOT NULL,
  EVENT_TYPE VARCHAR(20) NOT NULL,
  CREATED    DATETIME,
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);