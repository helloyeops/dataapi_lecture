CREATE TABLE streaming_workflow (
  workflow_id INT(100) NOT NULL AUTO_INCREMENT,
  workflow_name VARCHAR(100) CHARACTER SET UTF8 NOT NULL,
  batch_duration INT(3) NOT NULL,
  driver_memory VARCHAR(10) NOT NULL,
  driver_cores INT(3) NOT NULL,
  executor_memory VARCHAR(10) NOT NULL,
  executor_cores INT(3) NOT NULL,
  executor_numbers INT(3) NOT NULL,
  thrift_port INT(5) NOT NULL,
  queue VARCHAR(100),
  client_id VARCHAR(100),
  PRIMARY KEY (workflow_id)
);

CREATE TABLE streaming_branch (
  branch_id INT(100) NOT NULL AUTO_INCREMENT,
  workflow_id INT(100) NOT NULL,
  branch_name VARCHAR(100) CHARACTER SET UTF8 NOT NULL,
  branch_seq INT(10) NOT NULL,
  PRIMARY KEY (branch_id),
  FOREIGN KEY (workflow_id) REFERENCES streaming_workflow (workflow_id)
);

CREATE TABLE streaming_component (
  component_id INT(100) NOT NULL AUTO_INCREMENT,
  branch_id INT(100) NOT NULL,
  workflow_id INT(100) NOT NULL,
  category VARCHAR(20) NOT NULL,
  component_type VARCHAR(20) NOT NULL,
  component_name VARCHAR(100) CHARACTER SET UTF8 NOT NULL,
  component_seq INT(10) NOT NULL,
  properties VARCHAR(5000) CHARACTER SET UTF8,
  PRIMARY KEY (component_id),
  FOREIGN KEY (branch_id) REFERENCES streaming_branch (branch_id),
  FOREIGN KEY (workflow_id) REFERENCES streaming_workflow (workflow_id)
);

CREATE TABLE streaming_meta (
  meta_id INT(100) NOT NULL AUTO_INCREMENT,
  workflow_id INT(100) NOT NULL,
  meta_type VARCHAR(20) NOT NULL,
  meta_name VARCHAR(100) CHARACTER SET UTF8 NOT NULL,
  meta_table VARCHAR(50) NOT NULL,
  properties VARCHAR(5000) CHARACTER SET UTF8,
  PRIMARY KEY (meta_id),
  FOREIGN KEY (workflow_id) REFERENCES streaming_workflow (workflow_id)
);

CREATE TABLE streaming_job (
  job_id INT(100) NOT NULL AUTO_INCREMENT,
  workflow_id INT(100) NOT NULL,
  session_id INT(100) NOT NULL,
  driver_host VARCHAR(100),
  container_id VARCHAR(100),
  app_id VARCHAR(50),
  user_name VARCHAR(50),
  state VARCHAR(10),
  client_id VARCHAR(100),
  start_dt datetime,
  end_dt datetime,
  PRIMARY KEY (job_id),
  FOREIGN KEY (workflow_id) REFERENCES streaming_workflow (workflow_id)
);

CREATE TABLE `event_detection` (
  `detection_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `event` text CHARACTER SET UTF8
);