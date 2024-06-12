-- ./zabbix/sql-scripts/init.sql
CREATE DATABASE IF NOT EXISTS zabbix;
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%' IDENTIFIED BY 'zabbix';
FLUSH PRIVILEGES;
