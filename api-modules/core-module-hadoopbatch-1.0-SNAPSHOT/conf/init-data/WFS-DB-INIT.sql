CREATE DATABASE `dpcore_workflow`;

CREATE USER `wfs`;

GRANT ALL PRIVILEGES ON `dpcore_workflow`.* to `wfs`@`localhost` IDENTIFIED BY 'wfs' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `dpcore_workflow`.* to `wfs`@`%` IDENTIFIED BY 'wfs' WITH GRANT OPTION;

FLUSH PRIVILEGES;