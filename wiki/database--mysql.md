# Mysql


## Show Process List (Running Queries)

```bash
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;

```
## Show Global Variables/Status

```bash
SHOW GLOBAL VARIABLES LIKE '%slow%';
SHOW GLOBAL VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW GLOBAL STATUS LIKE 'Innodb%_page%';

SHOW TABLE STATUS;

```
## Dump Specific Tables

```bash
mysqldump -u XXX -pXXX mydb t1 t2 t3 > mydb_tables.sql

```
## Terminal Command Line

## Echo Output Direct to Terminal

```bash
echo "SHOW GLOBAL VARIABLES LIKE 'innodb_buffer_pool_size';" | mysql -S /local/mysql/io85/mysql.sock io85

```
### Show Table(s)

All Tables in Database

```
SELECT table_name AS "Tables",  round(((data_length + index_length) / 1024 / 1024), 2) "Size in MB"  FROM information_schema.TABLES  WHERE table_schema = "$DB_NAME" ORDER BY (data_length + index_length) DESC;
```

**Single Table**

```
SELECT table_name AS "Table", 
round(((data_length + index_length) / 1024 / 1024), 2) "Size in MB" 
FROM information_schema.TABLES 
WHERE table_schema = "$DB_NAME"
 AND table_name = "$TABLE_NAME";
```

**Table Status**

```bash
show table status from io85 WHERE name = "stored_action_parameters"\G

```
**Compare Table Sizes (i.e. check status of copy)**

```bash
show table status like 'user_prd_batch_data%';

```
**Indexes**

```bash
show indexes from user_prd_batch_data;

```
### Show Columns/Fields

```bash
desc user_prd_batch_data;

```
or

```bash
show columns from user_prd_batch_data;

```
### Export SQL as .TXT , .CSV

```
SELECT order_id,product_name,qty
FROM orders
INTO OUTFILE '/tmp/orders.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
```

## Backup All Databases

```bash
mysqldump -n --user=XXXX --password=XXXX --all-databases | gzip -c > server.sql.gz

```
## Dump Data and Structure

```bash
mysqldump -u root -p --skip-add-drop-table --replace --skip-extended-insert --lock-tables io85_com | sed 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' > io85_com_full.sql

```
## Dump Data Only

```bash
mysqldump -u root -p --no-create-info --skip-add-drop-table --replace --skip-extended-insert --lock-tables io85_com > data_dump.sql

```
## Dump Structure Only

```bash
mysqldump -u root -p --no-data --skip-add-drop-table --replace --skip-extended-insert --lock-tables io85_com | sed 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' > schema_dump.sql

```
## Dump Specific Table

```bash
mysqldump --no-create-info --skip-extended-insert io85 report_prd_ddd_stacks > dd.sql

```
## Select DB for Import

```bash
mysql -u root -p --one-database db_to_restore < fulldump.sql

```
## Extract Database from Dump File

```bash
sed -n '/^-- Current Database: `test`/,/^-- Current Database: `/p' fulldump.sql > test.sql

```
## Basic my.cnf

```
[mysqld]
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
skip_external_locking
#skip-networking
skip-name-resolve
default-storage-engine=innodb
```

**ERROR 2006 (HY000) at line 1: MySQL server has gone away**

```bash
set global max_allowed_packet=104857600

permanent set in my.cnf 

max_allowed_packet = 128M

```
Macports

```
[mysqld]
default-storage-engine=innodb
innodb_file_per_table
innodb_file_format = Barracuda
collation-server = utf8_unicode_ci
init-connect='SET NAMES utf8'
character-set-server = utf8
max_allowed_packet = 128M

[client]
default-character-set=utf8

[mysql]
default-character-set=utf8
```

## Queries

### Random Data Generator

```
INSERT INTO `plug_in_track_prd_location_scans` ( `emply_id`, `dept_id`, `order_id`, `trans_id`, `note`, `m_login`, `c_timestamp`) VALUES
( 11111, (ROUND(RAND() * (24-19) + 19)), NULL, (ROUND( RAND( ) * RAND( ) *9028982 )), NULL, 'ljackson', (NOW() - INTERVAL (ROUND(RAND() * (9-1) + 1)) DAY));
```

## Ucwords for Mysql

```
DROP FUNCTION IF EXISTS proper;
SET GLOBAL  log_bin_trust_function_creators=TRUE;
DELIMITER |
CREATE FUNCTION proper( str VARCHAR(128) )
RETURNS VARCHAR(128)
BEGIN
  DECLARE c CHAR(1);
  DECLARE s VARCHAR(128);
  DECLARE i INT DEFAULT 1;
  DECLARE bool INT DEFAULT 1;
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';
  SET s = LCASE( str );
  WHILE i < LENGTH( str ) DO 
    BEGIN
      SET c = SUBSTRING( s, i, 1 );
      IF LOCATE( c, punct ) > 0 THEN
        SET bool = 1;
      ELSEIF bool=1 THEN 
        BEGIN
          IF c >= 'a' AND c <= 'z' THEN 
            BEGIN
              SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));
              SET bool = 0;
            END;
          ELSEIF c >= '0' AND c <= '9' THEN
            SET bool = 0;
          END IF;
        END;
      END IF;
      SET i = i+1;
    END;
  END WHILE;
  RETURN s;
END;
|
DELIMITER ;
```

## Sources

- http://www.tech-recipes.com/rx/1475/save-mysql-query-results-into-a-text-or-csv-file/
