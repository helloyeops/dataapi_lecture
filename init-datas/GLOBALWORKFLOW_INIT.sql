CREATE TABLE `GLOBALWORKFLOW_WORKFLOW` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8 DEFAULT NULL,
  `creator` varchar(120) CHARACTER SET utf8 DEFAULT NULL,
  `description` tinytext CHARACTER SET utf8,
  `createTime` int(11) NOT NULL,
  `updateTime` int(11) NOT NULL,
  `workflowDefinition` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=992 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `GLOBALWORKFLOW_JOB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workflowId` int(11) NOT NULL,
  `status` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `startTime` int(11) DEFAULT NULL,
  `endTime` int(11) DEFAULT NULL,
  `componentId` int(11) DEFAULT NULL,
  `componentType` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `componentSubType` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `componentJobId` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `componentName` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3157 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;