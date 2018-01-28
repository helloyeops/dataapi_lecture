ALTER TABLE WFS_NODE ADD (owner VARCHAR(255));
ALTER TABLE WFS_NODE_GROUP ADD (owner VARCHAR(255));
ALTER TABLE WFS_WORKFLOW ADD (owner VARCHAR(255));
ALTER TABLE WFS_SCHEDULE ADD (owner VARCHAR(255));
ALTER TABLE WFS_WORKFLOW_JOB ADD (owner VARCHAR(255));
ALTER TABLE WFS_SCHEDULE_JOB ADD (owner VARCHAR(255));

ALTER TABLE WFS_WORKFLOW ADD (app_name VARCHAR(40));
ALTER TABLE WFS_SCHEDULE ADD (app_name VARCHAR(40));

CREATE TABLE `WFS_WORKFLOW_JOB_PROP` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isNestedVariable` bit(1) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `job_prop_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_f2x88qjk0qhkm7hxr7k2ra21` (`job_prop_id`),
  CONSTRAINT `FK_f2x88qjk0qhkm7hxr7k2ra21` FOREIGN KEY (`job_prop_id`) REFERENCES `WFS_WORKFLOW` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;