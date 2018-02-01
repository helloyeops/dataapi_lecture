# Data API 실습

## 실습 환경 구축

- Virtualbox 다운로드 & 설치

    > https://www.virtualbox.org/wiki/Downloads
- HDP 샌드박스(v2.6.3) 다운로드

    > https://downloads-hortonworks.akamaized.net/sandbox-hdp-2.6.3/HDP_2.6.3_virtualbox_16_11_2017.ova
- putty 다운로드

    > https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- Local PC hosts 에 hostname 등록
    - for windows

        > C:\Windows\System32\drivers\etc\hosts 파일 수정

    - for mac or linux

        > /etc/hosts
    `127.0.0.1 sandbox-hdp.hortonworks.com`   

- HDP Sandobx 포트포워딩 설정
    - Virtualbox 에서 포트포워딩 설정
        - 설정 => 네트워크 => 고급 => 포트포워딩
            - api : _127.0.0.1, 7070 ,7070_
            - pipeline : _127.0.0.1, 9056, 9056_
    
    - Docker ssh 접속정보

        |속성|값|
        |-|-|
        |hostname|sandbox-hdp.hortonworks.com|
        |port|2122|
        |username|root|
        |password|hadoop
 
    - Docker container  (vi 한줄 입력후 a 누르면 insert모드 => esc => :wq)
 
        ```bash
        $ vi /root/start_scripts/start_sandbox.sh
        docker run -v hadoop:/hadoop --name sandbox --hostname "sandbox.hortonworks.com" --privileged -d 
        -p 7070:7070 \
        -p 9056:9056 \
        ...
        ...

        # docker 상태 저장
        $ docker commit sandbox-hdp sandbox-hdp
        $ docker stop sandbox-hdp
        $ docker rm sandbox-hdp
        $ init 6
        ```
    
- HDP 샌드박스에 ssh 접속 (putty)
    - ssh 접속정보
    
        |속성|값|
        |-|-|
        |hostname|sandbox-hdp.hortonworks.com|
        |port|2222|
        |username|root|
        |password|hadoop|
    - hostname : sandbox-hdp.hortonworks.com
    - port : 2222
    - username : root
    - password : hadoop
- root 패스워드 변경 : hadoop(초기 패스워드) -> bigdata123
- hdfs 계정으로 전환 (실습은 hdfs 계정으로 진행)
    ```bash
    # hdfs 계정에 패스워드 생성
    # "hdfs"로 설정
    $ passwd hdfs
    $ su - hdfs
    ```

<br>

## Hadoop 구동 및 상태 확인
- Ambari 접속 (Web browser)

    > http://sandbox-hdp.hortonworks.com:8080 (raj_ops / raj_ops)
- Hadoop Eco 구동
    - HDFS
        - Maintenance mode off
    - YARN
    - MapReduce
    - Hive
    - Oozie
    - Zookeeper
    - Kafka
        - Maintenance mode off
    - Spark2
- Hadoop Eco 상태 확인
    - HDFS
        ```bash
        $ hadoop fs -ls /
        Found 13 items
        drwxrwxrwx   - yarn   hadoop          0 2017-11-10 14:59 /app-logs
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 14:45 /apps
        drwxr-xr-x   - yarn   hadoop          0 2017-11-10 14:37 /ats
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 14:52 /demo
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 14:38 /hdp
        drwx------   - livy   hdfs            0 2017-11-10 14:40 /livy2-recovery
        drwxr-xr-x   - mapred hdfs            0 2017-11-10 14:38 /mapred
        drwxrwxrwx   - mapred hadoop          0 2017-11-10 14:38 /mr-history
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 14:37 /ranger
        drwxrwxrwx   - spark  hadoop          0 2017-11-10 15:08 /spark2-history
        drwxrwxrwx   - hdfs   hdfs            0 2017-11-10 15:00 /tmp
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 15:00 /user
        drwxr-xr-x   - hdfs   hdfs            0 2017-11-10 14:38 /webhdfs
        ```
    - YARN
    
        > http://sandbox-hdp.hortonworks.com:8088
    - MapReduce
    
        > http://sandbox-hdp.hortonworks.com:19888    
    - Hive
        ```bash
        $ hive
        hive> select * from sample_07 limit 5;
        OK
        00-0000	All Occupations	134354250	40690
        11-0000	Management occupations	6003930	96150
        11-1011	Chief executives	299160	151370
        11-1021	General and operations managers	1655410	103780
        11-1031	Legislators	61110	33880
        Time taken: 1.466 seconds, Fetched: 10 row(s)
        ```
    - Oozie
        
        > http://sandbox-hdp.hortonworks.com:11000/oozie

<br>

## API 관련 패키지 설치
- API 모듈 패키지 다운로드
    ```bash
    # HDP Sandbox 에서 수행)
    $ git clone https://github.com/helloyeops/dataapi_lecture.git
    ```
  
- DB 스키마 생성
    - MySQL 접속 정보 (공통)

        |속성|값|
        |-|-|
        |Driver|com.mysql.jdbc.Driver|
        |Host|sandbox-hdp.hortonworks.com|
        |Port|3306|
        |username|root|
        |Password|hadoop|

    - Database 명

        |모듈|DB명|
        |-|-|
        |Globalworkflow|dpcore_globalworkflow|
        |Streaming|dpcore_streaming|
        |Hadoop Batch|wfs|
- DB 접속
    ```bash
    $ mysql -uroot -p
    # password : hadoop
    ```
- 데이터베이스/사용자 생성
    ```sql
    -- Globalworkflow
    CREATE DATABASE dpcore_globalworkflow;
    -- Streaming
    CREATE DATABASE dpcore_streaming;
    -- Hadoop bath
    CREATE DATABASE wfs;
    ```

- 모듈 별 테이블 생성
    ```sql
    $ cd ~/dataapi_lecture/init-datas
    
    -- Globalworkflow 테이블 생성
    $ mysql -uroot -p dpcore_globalworkflow < GLOBALWORKFLOW_INIT.sql

    -- Streaming 테이블 생성
    $ mysql -uroot -p dpcore_streaming < STREAMING_INIT.sql
    ```
<br>

- Streaming 관련 설정
    - 라이브러리 설치
        ```bash
        $ cd ~/dataapi_lecture/streaming-engine

        # 라이브러리/엔진 디렉토리 생성
        $ hadoop fs -mkdir -p /user/spark/streaming/driver
        $ hadoop fs -mkdir -p /user/spark/streaming/lib

        # 라이브러리/엔진 파일 HDFS로 업로드
        $ hadoop fs -put -f streaming-core-1.0-hdp263.jar /user/spark/streaming/driver/
        $ hadoop fs -put -f phoenix-spark2-4.7.1-HBase1.1.jar /user/spark/streaming/lib/
        $ hadoop fs -put -f mariadb-java-client-2.0.2.jar /user/spark/streaming/lib/
        ```
    - livy CR/LF 프로텍션 비활성화
        - Ambari => Spark2 => Configs => Advanced livy2-conf (아래 설정 변경 후, 재시작)

            > livy.server.csrf_protection.enabled=false

- Hadoop batch 관련 설정
    - 라이브러리 설치
        ```bash
        # 라이브러리/엔진 파일 HDFS로 업로드
        $ hadoop fs -put -f mariadb-java-client-2.0.2.jar /user/oozie/share/lib/lib_20171110144231/sqoop
        ```
    - Proxy 사용자 추가
        - Ambari => Oozie => Configs => Custom oozie-site => Add property ... (아래 설정 추가 후, 재시작)

            > oozie.service.ProxyUserService.proxyuser.hdfs.hosts=*
            
            > oozie.service.ProxyUserService.proxyuser.hdfs.groups=*

- API 모듈 기동
    - API Gateway 모듈 기동
        ```bash
        $ cd ~/dataapi_lecture/api-modules/core-api-gateway-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Globalworkflow 모듈 기동
        ```bash
        $ cd ~/dataapi_lecture/api-modules/core-module-globalworkflow-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Hadoop batch 모듈 기동
        ```bash
        $ cd ~/dataapi_lecture/api-modules/core-module-hadoopbatch-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Streaming API 모듈 기동
        ```bash
        $ cd ~/dataapi_lecture/api-modules/core-module-streaming-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```

- API 기동 확인
    ```bash
    $ curl http://sandbox-hdp.hortonworks.com:7070/api/v1/globalworkflow/workflow
    ```

<br>

## Pipeline 설치
- Pipeline 설치 및 실행
    - Database 설치
    ```bash
    # password : hadoop
    $ mysql -uroot -p
    ```

    ```sql
    -- database 생성
    CREATE DATABASE pipeline;
    ```

    ```bash
    # Table 생성
    $ cd ~/dataapi_lecture/init-datas

    # password : hadoop
    $ mysql -uroot -p pipeline < PIPELINE_INIT.sql

    # 실행
    $ cd ~/dataapi_lecture/apache-tomcat-8.5.27/bin
    $ ./startup.sh
    ```
- 로컬 웹 브라우즈(Chrome) 에서 Pipeline 서비스 접속

    > http://sandbox-hdp.hortonworks.com:9056

<br>

## Tutorial 실습
- Streaming : 실시간 신용카드 부정거래 탐지 
    - Workflow 작성
        - Streming
            - name : _fds_real_
            - interval : _5000_
            - driverMemory : _1g_
            - driverCores : _2_
            - executorMemory : _1g_
            - executorCores : _2_
            - executorNumbers : _2_
            - thriftPort : _22000_
            - queue : _default_

            1. Reader : Kafka

                - zkQuorum : _sandbox-hdp.hortonworks.com:2181_
                - threadNum : _1_
                - receiverNum : _1_
                - topics : _credit_
                - group : _streaming_

            1. Parser : CSV

                - tableName : _credit_
                - columnList
                    - _TransactionDate(string)_
                    - _TransactionID(string)_
                    - _TransactionType(string)_
                    - _CardNumber(string)_
                    - _CardOwner(string)_
                    - _ExpireDate(string)_
                    - _Amount(integer)_
                    - _MerchantID(string)_
                    - _LocationX(integer)_
                    - _LocationY(integer)_

            1. Filter : String contain
                
                - targetColumn : _TransactionType_
                - value : _P_

            1. Clone : Stream clone
                - 이벤트 탐지
                    1. Function : Event
                        - ruleScript
                            ```javascript
                            rule "detect stream data with rule"
                            dialect "mvel"
                            when
                                $c : credit() from entry-point EventStream
                                $bc : credit(
                                    CardNumber==$c.CardNumber,
                                    eval(($c.LocationX - LocationX) * ($c.LocationX - LocationX) + ($c.LocationY - LocationY) * ($c.LocationY -                             LocationY) > 5 * 5),
                                    this before[0s, 60s] $c
                                ) from entry-point EventStream
                            then
                                event.add($bc.toString() + " => " + $c.toString());
                            end
                            ```
                        - entryPoint : _EventStream_
                        - tableName : _event_detection_
                        - newColumn : _event_

                    1. Write : JDBC
                        - url : _jdbc:mariadb://sandbox-hdp.hortonworks.com:3306/dpcore_streaming?sessionVariables=sql_mode=ANSI_QUOTES_
                        - driver : _org.mariadb.jdbc.Driver_
                        - username : _root_
                        - password : _hadoop_
                - 실시간 데이터 조회
                    1. Write : SparkSQL
                        - window : 30000
    - Streaming job 실행 확인

        > http://sandbox-hdp.hortonworks.com:8088/

    - Kafka 기동 및 데이터 생성
        ```bash
        $ cd ~/dataapi_lecture/streaming-test
        # 테스트 데이터 생성
        $ python credit_gen.py

        # Kafka consumer 실행
        $ tail -f credit_gen.log | /usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh --topic credit --broker-list sandbox-hdp.hortonworks.com:6667
        ```
        
    - 실시간 데이터 확인
        ```bash
        // job status 업데이트
        $ curl http://sandbox-hdp.hortonworks.com:7070/api/v1/streaming/job

        // data 확인
        $ curl http://sandbox-hdp.hortonworks.com:7070/api/v1/streaming/sql/execute?jobId=1&sql=select * from credit
        ```
    - Event 탐지 데이터 확인
        ```bash
        # password : hadoop
        $ mysql -uroot -p
        mysql> use dpcore_steaming;
        mysql> select * from event_detiction
        ```


- 신용카드 그룹 별 통계 작업
    - 샘플 데이터 HDFS 로 업로드
        ```bash
        $ cd ~/dataapi-lecture/batch-sample

        # 디렉토리 생성
        $ hadoop fs -mkdir -p /tmp/table/card
        $ hadoop fs -mkdir -p /tmp/table/user
        $ hadoop fs -mkdir -p /tmp/table/merchant

        # 파일 업로드(HDFS)
        $ hadoop fs -put card.csv /tmp/table/card
        $ hadoop fs -put user.csv /tmp/table/user
        $ hadoop fs -put merchant.csv /tmp/table/merchant
        ```
    - Hive 에서 데이터 조회 및 분석
        - Hive 실행
            ```bash
            $ hive  
            ```
        - 스키마 생성 & 데이터 조회/분석
            ```sql
            -- 카드 사용 내역 테이블 생성
            CREATE EXTERNAL TABLE IF NOT EXISTS CARD_HISTORY (
                TRANSACTION_DATE STRING, 
                TRANSACTION_ID STRING, 
                TRANSACTION_TYPE STRING, 
                CARD_NUMBER STRING, 
                CARD_OWNER STRING, 
                EXPIRE_DATE STRING, 
                AMOUNT INT, 
                MERCHANT_ID STRING, 
                LOCATION_X INT, 
                LOCATION_Y INT 
                ) 
            COMMENT 'Card History Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/tmp/table/card';

            -- 사용자 테이블 생성
            CREATE EXTERNAL TABLE IF NOT EXISTS USERS ( 
                USER_ID STRING, 
                USER_NAME STRING, 
                AGE INT, 
                SEX STRING,
                ADDRESS STRING ) 
            COMMENT 'User Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/tmp/table/user';
            
            -- 물품 테이블 생성
            CREATE EXTERNAL TABLE IF NOT EXISTS MERCHANT ( 
                MERCHANT_ID STRING, 
                MERCHANT_NAME STRING, 
                BUSINESS_TYPESTRING ) 
            COMMENT 'Merchant Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/tmp/table/merchant';

            -- 데이터 조회
            SELECT * FROM CARD_HISTORY;

            SELECT * FROM USER;

            SELECT * FROM MERCHANT;
            
            -- 데이터 분석
            -- 사업 별 카드 승인 금액 평균
            INSERT INTO TABLE STATISTICS_BY_BUSINESS_TYPE 
            SELECT M.BUSINESS_TYPE, SUM(C.AMOUNT) AS TOTAL_AMOUNT 
            FROM CARD_HISTORY C JOIN MERCHANT M ON (C.MERCHANT_ID = M.MERCHANT_ID) 
            GROUP BY M.BUSINESS_TYPE;
                
            -- 성별 카드 승인 금액 평균
            INSERT INTO TABLE STATISTICS_BY_SEX 
            SELECT U.SEX, SUM(C.AMOUNT) AS TOTAL_AMOUNT 
            FROM CARD_HISTORY C JOINUSERS U ON (C.CARD_OWNER = U.USER_ID) 
            GROUP BY U.SEX;
            
            -- 연령 별 카드 승인 금액 평균
            INSERT INTO TABLE STATISTICS_BY_AGE 
            SELECT U.AGE, SUM(C.AMOUNT) AS TOTAL_AMOUNT 
            FROM CARD_HISTORY C JOINUSERS U ON (C.CARD_OWNER = U.USER_ID) 
            GROUP BY U.AGE;
            ```
    - Workflow 작성
        - Batch
            - name : _fds_batch_

            1. Query
                ```sql
                CREATE EXTERNAL TABLE IF NOT EXISTS CARD_HISTORY ( TRANSACTION_DATE STRING, TRANSACTION_ID STRING, TRANSACTION_TYPE STRING, CARD_NUMBER STRING, CARD_OWNER STRING, EXPIRE_DATE STRING, AMOUNT INT, MERCHANT_ID STRING, LOCATION_X INT, LOCATION_Y INT ) COMMENT 'Card History Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '${cardHistory}';

                CREATE EXTERNAL TABLE IF NOT EXISTS USERS ( USER_ID STRING, USER_NAME STRING, AGE INT, SEX STRING, ADDRESS STRING ) COMMENT 'User Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '${user}';
                
                CREATE EXTERNAL TABLE IF NOT EXISTS MERCHANT ( MERCHANT_ID STRING, MERCHANT_NAME STRING, BUSINESS_TYPE STRING ) COMMENT 'Merchant Table' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '${merchant}';
                
                CREATE TABLE IF NOT EXISTS STATISTICS_BY_BUSINESS_TYPE( BUSINESS_TYPE STRING, TOTAL_AMOUNT INT ) COMMENT 'Statistics per Business Type' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
                
                CREATE TABLE IF NOT EXISTS STATISTICS_BY_SEX( SEX STRING, TOTAL_AMOUNT INT ) COMMENT 'Statistics per User Sex' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
                
                CREATE TABLE IF NOT EXISTS STATISTICS_BY_AGE( AGE INT, TOTAL_AMOUNT INT ) COMMENT 'Statistics per Age' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
                
                INSERT INTO TABLE STATISTICS_BY_BUSINESS_TYPE SELECT M.BUSINESS_TYPE, SUM(C.AMOUNT) AS TOTAL_AMOUNT FROM CARD_HISTORY C JOIN MERCHANT M ON (C.MERCHANT_ID = M.MERCHANT_ID) GROUP BY M.BUSINESS_TYPE;
                
                INSERT INTO TABLE STATISTICS_BY_SEX SELECT U.SEX, SUM(C.AMOUNT) AS TOTAL_AMOUNT FROM CARD_HISTORY C JOIN USERS U ON (C.CARD_OWNER = U.USER_ID) GROUP BY U.SEX;
                
                INSERT INTO TABLE STATISTICS_BY_AGE SELECT U.AGE, SUM(C.AMOUNT) AS TOTAL_AMOUNT FROM CARD_HISTORY C JOIN USERS U ON (C.CARD_OWNER = U.USER_ID) GROUP BY U.AGE;
                ```
            1. Sqoop 
                - 업소별 카드 승인 평균 금액
                - arguments
                    - _export_
                    - _--connect_
                    - _jdbc:mariadb://localhost:3306/batch_
                    - _--driver_
                    - _org.mariadb.jdbc.Driver_
                    - _--username_
                    - _root_
                    - _--password_
                    - _hadoop_
                    - _--table_
                    - _STATISTICS_BY_BUSINESS_TYPE_
                    - _--export-dir_
                    - _/apps/hive/warehouse/statistics_by_business_type_
            1. Sqoop
                - 성별 별 카드 승인 평균 금액
                - arguments
                    - _export_
                    - _--connect_
                    - _jdbc:mariadb://localhost:3306/batch_
                    - _--driver_
                    - _org.mariadb.jdbc.Driver_
                    - _--username_
                    - _root_
                    - _--password_
                    - _hadoop_
                    - _--table_
                    - _STATISTICS_BY_SEX_
                    - _--export-dir_
                    - _/apps/hive/warehouse/statistics_by_business_sex_
            1. Sqoop
                - 연령 별 카드 승인 평균 금액
                - arguments
                    - _export_
                    - _--connect_
                    - _jdbc:mariadb://localhost:3306/batch_
                    - _--driver_
                    - _org.mariadb.jdbc.Driver_
                    - _--username_
                    - _root_
                    - _--password_
                    - _hadoop_
                    - _--table_
                    - _STATISTICS_BY_AGE_
                    - _--export-dir_
                    - _/apps/hive/warehouse/statistics_by_business_age_
    - Workflow 실행 확인

        > http://sandbox-hdp.hortonworks.com:11000
