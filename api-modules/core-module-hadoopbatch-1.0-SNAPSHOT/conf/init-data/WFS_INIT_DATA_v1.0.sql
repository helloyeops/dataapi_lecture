--User table
INSERT INTO WFS_USER (username, nickname, password, role, local_path, hdfs_path, email, active, created_time) VALUES ("admin", "admin", "$2a$10$p8Sc3RfOfXKfC3GBPw/kPuaIfADp42mgTBT41EQZcrIkVvGEjrHK6", 1, "/home/admin", "/user/admin", "email@sk.com", true, now());

INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  1,  now(), "fs.defaultFS", "hdfs://dacluster");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  2,  now(), "dfs.ha.fencing.methods", "shell(/bin/true)");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  3,  now(), "dfs.ha.automatic-failover.enabled", "true");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  4,  now(), "dfs.nameservices", "dacluster");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  5,  now(), "dfs.ha.namenodes.dacluster", "nn1,nn2");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  6,  now(), "dfs.namenode.rpc-address.dacluster.nn1", "dataplatform01.skcc.com:8020");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  7,  now(), "dfs.namenode.rpc-address.dacluster.nn2", "dataplatform02.skcc.com:8020");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  8,  now(), "dfs.client.failover.proxy.provider.dacluster", "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 1, now(), "yarn.resourcemanager.address", "dataplatform02.skcc.com:8050");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 2, now(), "mapreduce.jobhistory.webapp.address", "dataplatform01.skcc.com:19888");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.url", "http://dataplatform03.skcc.com:11000/oozie");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20170616030408");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.notification.url", "http://dataplatform04:7070");


--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  1,  now(), "fs.defaultFS", "hdfs://n1.hdp:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 1, now(), "yarn.resourcemanager.address", "n1.hdp:8050");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 2, now(), "mapreduce.jobhistory.webapp.address", "n1.hdp:19888");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.url", "http://n1.hdp:11000/oozie");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20170715033201");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.notification.url", "http://dpcore-api:7070");
