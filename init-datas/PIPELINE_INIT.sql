create table AGENT_COLLECTOR_MAP
(
  AGENT_TYPE varchar(50) not null
    primary key,
  AVAILABLE_COLLECTOR_TYPE varchar(500) not null,
  DESCRIPTION varchar(200) null
)
  engine=InnoDB
;

create table AGENT_CONFIGURATION
(
  ID int(5) auto_increment
    primary key,
  RELATED_ID int(5) not null,
  AGENT_TYPE varchar(50) not null,
  AGENT_NAME varchar(50) not null,
  CONFIGURATION_INFO varchar(2000) not null,
  FLAG_INABLE int default '0' not null,
  USER_ID varchar(50) not null,
  UPDATE_DT timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
  CREATE_DT timestamp default '0000-00-00 00:00:00' not null,
  constraint AGENT_NAME
  unique (AGENT_NAME),
  constraint AGENT_TYPE
  foreign key (AGENT_TYPE) references AGENT_COLLECTOR_MAP (AGENT_TYPE)
    on delete cascade
)
  engine=InnoDB
;


create table AGENT_DISTRIBUTION
(
  ID int(5) auto_increment
    primary key,
  HOST varchar(50) not null,
  CERTIFICATED_USER varchar(50) not null,
  CERTIFICATED_PW varchar(100) not null,
  SSH_PORT int(5) default '22' not null,
  STATUS varchar(50) not null,
  USER_ID varchar(50) not null,
  UPDATE_DT timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
  CREATE_DT timestamp default '0000-00-00 00:00:00' not null,
  constraint HOST
  unique (HOST)
)
  engine=InnoDB
;

alter table AGENT_CONFIGURATION
  add constraint RELATED_ID
foreign key (RELATED_ID) references AGENT_DISTRIBUTION (ID)
  on delete cascade
;

create table AGENT_DISTRIBUTION_HISTORY
(
  ID int(5) auto_increment
    primary key,
  RELATED_ID int(5) not null,
  USER_ID varchar(50) not null,
  CREATE_DT timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
  constraint HISTORY_RELATED_ID
  foreign key (RELATED_ID) references AGENT_DISTRIBUTION (ID)
    on delete cascade
)
  engine=InnoDB
;



create table AGENT_METADATA
(
  ID varchar(10) not null
    primary key,
  BEAT_NM varchar(50) not null,
  USE_SCORE int not null,
  LEVEL int not null,
  VAR_NM varchar(50) not null,
  VAR_NM_VIEW varchar(200) not null,
  VAR_TYPE varchar(50) null,
  VAR_DEFAULT varchar(200) null,
  PARENT_ID varchar(10) null,
  MULTIPLE_YN int default '0' null,
  VAR_RANGE varchar(200) null
)
  engine=InnoDB
;

create table ALARM_SCHEDULE_ACTION_JOB_STATUS
(
  ACTION_ID varchar(50) not null comment 'action Id'
    primary key,
  COMPONENT_ID bigint null,
  UUID varchar(40) null,
  STATUS varchar(50) not null comment 'status',
  LAST_YN varchar(1) default 'Y' null,
  REG_DTM datetime not null comment '등록일시',
  MOD_DTM datetime not null comment '수정일시'
)
  comment '스케줄 액션 JobStatus 알람' engine=InnoDB
;

create table ALARM_WORKFLOW_JOB_STATUS
(
  JOB_ID varchar(50) not null comment 'job Id'
    primary key,
  COMPONENT_ID bigint null,
  UUID varchar(40) null,
  STATUS varchar(50) not null comment 'job status',
  PARENT_ID varchar(50) not null comment 'parent Id',
  LAST_YN varchar(1) default 'Y' null,
  REG_DTM datetime not null comment '등록일시',
  MOD_DTM datetime not null comment '수정일시'
)
  comment '워크플로우 JobStatus 알람' engine=InnoDB
;

create table ALARM_WORKFLOW_NODE
(
  JOB_ID varchar(50) not null comment 'job Id',
  NODE_NAME varchar(50) not null comment 'node name',
  STATUS varchar(50) not null comment 'job status',
  LAST_YN varchar(1) default 'Y' null,
  REG_DTM datetime not null comment '등록일시',
  MOD_DTM datetime not null comment '수정일시',
  primary key (NODE_NAME, JOB_ID)
)
  comment '워크플로우 노드 Start / End 알람' engine=InnoDB
;

create table QUEUE_CLUSTER_INFO
(
  CLUSTER_ID int auto_increment
    primary key,
  CLUSTER_NAME varchar(50) not null,
  ZOOKEEPER_URL varchar(200) not null,
  BOOTSTRAP_URL varchar(200) null,
  CREATE_DTM datetime null,
  MOD_DTM datetime null
)
  comment 'Kafka Cluster 정보를 관리한다' engine=InnoDB
;

create table TB_ROLE_RESOURCE
(
  ROLE_ID varchar(50) null comment '롤 ID',
  URL varchar(50) null comment 'resource url',
  TYPE varchar(50) null comment 'URL 구분(설명)'
)
  comment '롤과 자원(url) 관계' engine=InnoDB
;

create table TB_USER_INFO
(
  ID varchar(50) not null comment '로그인 ID',
  PASSWORD varchar(60) not null comment '비밀번호',
  NAME varchar(50) not null comment '이름'
)
  comment '사용자 정보' engine=InnoDB charset=utf8
;

create table TB_USER_NOTIFICATION
(
  JOB_ID varchar(200) default '' not null,
  JOB_STATUS varchar(20) default '' not null,
  WORKFLOW_NAME varchar(200) null,
  READ_YN varchar(1) default 'N' null,
  NOTI_DTM datetime null,
  REG_DTM datetime null,
  MOD_DTM datetime null
)
  engine=InnoDB
;

create table TB_USER_ROLE
(
  ID varchar(50) not null comment '로그인 ID',
  ROLE_ID varchar(50) not null comment '롤 ID'
)
  comment '사용자 정보' engine=InnoDB charset=utf8
;

create table TB_WORKFLOW_COMP_INFO
(
  COMP_UUID varchar(40) not null comment 'component의 uuid'
    primary key,
  COMP_TYPE varchar(10) not null comment 'component의 type',
  COMP_NAME varchar(100) not null comment 'component의 name',
  WORKFLOW_ID int not null comment 'workflow의 ID',
  COMP_META_ID int not null comment 'batch 모듈의 meta ID',
  WORKFLOW_NAME varchar(200) not null comment 'batch 모듈이 소속된 Workflow 이름',
  NOTI_LEVEL varchar(20) null
)
  comment 'workflow compoents 정보' engine=InnoDB charset=utf8
;


create table TB_WORKFLOW_GUI_INFO
(
  WORKFLOW_ID int not null comment 'workflow의 ID',
  WORKFLOW_OWNER varchar(50) not null comment 'workflow의 작성자 ID',
  WORKFLOW_JSON mediumtext not null comment 'workflow의 Json Data',
  REG_DTM datetime not null comment '등록일시',
  MOD_DTM datetime not null comment '수정일시',
  primary key (WORKFLOW_ID, WORKFLOW_OWNER)
)
  comment 'workflow GUI 정보(xy좌표, 이름, property key, error link 등)' engine=InnoDB charset=utf8
;

alter table TB_WORKFLOW_COMP_INFO
  add constraint FK_WORKFLOW_ID
foreign key (WORKFLOW_ID) references TB_WORKFLOW_GUI_INFO (WORKFLOW_ID)
  on delete cascade
;

