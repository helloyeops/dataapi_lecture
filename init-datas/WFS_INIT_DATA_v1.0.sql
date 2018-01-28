--User table
--INSERT INTO WFS_USER (username, nickname, password, role, local_path, hdfs_path, email, active, created_time) VALUES ("admin", "admin", "$2a$10$p8Sc3RfOfXKfC3GBPw/kPuaIfADp42mgTBT41EQZcrIkVvGEjrHK6", 1, "/home/admin", "/user/admin", "email@sk.com", true, now());

--Config table
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  1,  now(), "fs.defaultFS", "hdfs://dataplatform12.skcc.com:8020");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 7,  now(), "dfs.client.use.datanode.hostname", "true");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 8,  now(), "dfs.datanode.use.datanode.hostname", "true");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 1, now(), "yarn.resourcemanager.address", "dataplatform12.skcc.com:8050");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 2, now(), "mapreduce.jobhistory.webapp.address", "dataplatform12.skcc.com:19888");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.base.url", "http://dataplatform12.skcc.com:11000/oozie");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20161108225321");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.notification.url", "http://dataplatform11:8080");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 1, now(), "hive.metastore.uris", "thrift://dataplatform12.skcc.com:9083");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 2, now(), "hive.jdbc.url", "jdbc:hive2://dataplatform12.skcc.com:10000");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 3, now(), "hive.jdbc.user", "hive");
INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 4, now(), "hive.jdbc.password", "hive");

--Config table : Skytale DT POC (판교)
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  1,  now(), "fs.defaultFS", "hdfs://dtpoc-NN1.dtpoc.sk.com:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 1, now(), "yarn.resourcemanager.address", "dtpoc-NN1.dtpoc.sk.com:8050");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 2, now(), "mapreduce.jobhistory.webapp.address", "dtpoc-NN1.dtpoc.sk.com:19888");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.base.url", "http://dtpoc-NN1.dtpoc.sk.com:11000/oozie");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20170810235519");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.notification.url", "http://dtpoc-NN1:7070");

--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", true,  1,  now(), "fs.defaultFS", "hdfs://dpcluster");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 2,  now(), "dfs.ha.automatic-failover.enabled", "true");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 3,  now(), "dfs.ha.fencing.methods", "shell(/bin/true)");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 4,  now(), "dfs.ha.namenodes.dpcluster", "nn1,nn2");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 5,  now(), "dfs.namenode.rpc-address.dpcluster.nn1", "dataplatform05.skcc.com:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 6,  now(), "dfs.namenode.rpc-address.dpcluster.nn2", "dataplatform06.skcc.com:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 7,  now(), "dfs.client.use.datanode.hostname", "true");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 8,  now(), "dfs.datanode.use.datanode.hostname", "true");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 9,  now(), "dfs.nameservices", "dpcluster");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hdfs", false, 10, now(), "dfs.client.failover.proxy.provider.dpcluster", "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 1, now(), "yarn.resourcemanager.address", "dataplatform05.skcc.com:8050");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("yarn", true, 2, now(), "mapreduce.jobhistory.webapp.address", "dataplatform05.skcc.com:19888");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.base.url", "http://dataplatform06.skcc.com:11000/oozie");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20170207215444");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.notification.url", "http://dataplatform04:8080");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 1, now(), "hive.metastore.uris", "thrift://dataplatform15.skcc.com:9083");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 2, now(), "hive.jdbc.url", "jdbc:hive2://dataplatform15.skcc.com:10000");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 3, now(), "hive.jdbc.user", "hiveuser");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 4, now(), "hive.jdbc.password", "hiveuser");

--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hadoop", true,  1,  now(), "fs.defaultFS", "hdfs://dataplatform12.skcc.com:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hadoop", false, 7,  now(), "dfs.client.use.datanode.hostname", "true");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hadoop", false, 8,  now(), "dfs.datanode.use.datanode.hostname", "true");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hadoop", true, 1, now(), "yarn.resourcemanager.address", "dataplatform12.skcc.com:8050");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hadoop", true, 2, now(), "mapreduce.jobhistory.webapp.address", "dataplatform12.skcc.com:19888");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 1, now(), "oozie.url", "http://dataplatform12.skcc.com:11000/oozie");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 2, now(), "oozie.libpath", "/user/oozie/share/lib/lib_20161108225321");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 3, now(), "oozie.name.node", "hdfs://dataplatform12.skcc.com:8020");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 4, now(), "oozie.job.tracker", "dataplatform12.skcc.com:8050");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 5, now(), "oozie.notification.url", "http://dataplatform11:8080");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("oozie", true, 6, now(), "oozie.hadoop.history.counters.url", "http://dataplatform12.skcc.com:19888/ws/v1/history/mapreduce/jobs/{0}/counters");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 1, now(), "hive.metastore.uris", "thrift://dataplatform12.skcc.com:9083");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 2, now(), "hive.jdbc.url", "jdbc:hive2://dataplatform12.skcc.com:10000");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 3, now(), "hive.jdbc.user", "hive");
--INSERT INTO WFS_CONFIG (type, fixed, sort, created_time, name, value) VALUES ("hive", true, 4, now(), "hive.jdbc.password", "hive");

