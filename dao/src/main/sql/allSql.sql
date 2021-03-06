-- //create database store character set utf8 collate utf8_general_ci;
DROP TABLE IF EXISTS T_ORDER;
DROP TABLE IF EXISTS T_ROLE_PERMISSION;
DROP TABLE IF EXISTS T_AUDIT;
DROP TABLE IF EXISTS T_PROFILE;
DROP TABLE IF EXISTS T_COMMENT;
DROP TABLE IF EXISTS T_NEWS;
DROP TABLE IF EXISTS T_PERMISSION;
DROP TABLE IF EXISTS T_ITEM_DISCOUNT;
DROP TABLE IF EXISTS T_ITEM;
DROP TABLE IF EXISTS T_FEEDBACK;
DROP TABLE IF EXISTS T_USER;
DROP TABLE IF EXISTS T_ROLE;
DROP TABLE IF EXISTS T_DISCOUNT;
CREATE TABLE IF NOT EXISTS T_ITEM (
  ID            BIGINT        NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NAME          VARCHAR(50)   NOT NULL,
  DESCRIPTION   LONGTEXT      NOT NULL,
  UNIQUE_NUMBER VARCHAR(10),
  PRICE         NUMERIC(6, 2) NOT NULL
);
CREATE TABLE IF NOT EXISTS T_DISCOUNT (
  ID      BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NAME    VARCHAR(20) NOT NULL,
  PERCENT BIGINT(3)   NOT NULL,
  CREATED DATETIME    NOT NULL
);
CREATE TABLE IF NOT EXISTS T_ROLE (
  ID   BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS T_USER (
  ID          BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  EMAIL       VARCHAR(30) NOT NULL,
  SURNAME     VARCHAR(20) NOT NULL,
  NAME        VARCHAR(20) NOT NULL,
  PASSWORD    VARCHAR(20) NOT NULL,
  ROLE_ID     BIGINT(10)  NOT NULL,
  DISCOUNT_ID BIGINT      NOT NULL,
  FOREIGN KEY (DISCOUNT_ID) REFERENCES T_DISCOUNT (ID),
  FOREIGN KEY (ROLE_ID) REFERENCES T_ROLE (ID)
);
CREATE TABLE IF NOT EXISTS T_PERMISSION (
  ID   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(20)     DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS T_ROLE_PERMISSION (
  ROLE_ID       BIGINT NOT NULL,
  PERMISSION_ID BIGINT NOT NULL,
  PRIMARY KEY (ROLE_ID, PERMISSION_ID),
  KEY PERMISSION_ID(PERMISSION_ID),
  FOREIGN KEY (ROLE_ID) REFERENCES T_ROLE (ID),
  FOREIGN KEY (PERMISSION_ID) REFERENCES T_PERMISSION (ID)
);
CREATE TABLE IF NOT EXISTS T_ITEM_DISCOUNT (
  ITEM_ID     BIGINT NOT NULL,
  DISCOUNT_ID BIGINT NOT NULL,
  PRIMARY KEY (ITEM_ID, DISCOUNT_ID),
  FOREIGN KEY (ITEM_ID) REFERENCES T_ITEM (ID),
  FOREIGN KEY (DISCOUNT_ID) REFERENCES T_DISCOUNT (ID)
);
CREATE TABLE IF NOT EXISTS T_ORDER (
  ID       BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
  USER_ID  BIGINT   NOT NULL,
  ITEM_ID  BIGINT   NOT NULL,
  CREATED  DATETIME NOT NULL,
  QUANTITY INTEGER(11),
  STATUS   VARCHAR(20),
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID),
  FOREIGN KEY (ITEM_ID) REFERENCES T_ITEM (ID)
);
CREATE TABLE IF NOT EXISTS T_PROFILE (
  USER_ID BIGINT NOT NULL,
  ADDRESS VARCHAR(50),
  PHONE   VARCHAR(12),
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);
CREATE TABLE IF NOT EXISTS T_AUDIT (
  ID         BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  USER_ID    BIGINT      NOT NULL,
  EVENT_TYPE VARCHAR(20) NOT NULL,
  CREATED    DATETIME,
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);
CREATE TABLE IF NOT EXISTS T_NEWS (
  ID      BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TITLE   VARCHAR(30) NOT NULL,
  CONTENT TEXT        NOT NULL,
  CREATED DATETIME,
  USER_ID BIGINT      NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);
CREATE TABLE IF NOT EXISTS T_COMMENT (
  ID      BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
  CONTENT LONGTEXT NOT NULL,
  CREATED DATETIME,
  USER_ID BIGINT   NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);
CREATE TABLE IF NOT EXISTS T_FEEDBACK (
  ID      BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
  USER_ID BIGINT   NOT NULL,
  MESSAGE LONGTEXT NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES T_USER (ID)
);