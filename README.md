# Data API 실습

## 실습 환경 구축

- Virtualbox 다운로드 & 설치

    > https://www.virtualbox.org/wiki/Downloads
- HDP 샌드박스(v2.6.3) 다운로드

    > https://downloads-hortonworks.akamaized.net/sandbox-hdp-2.6.3/HDP_2.6.3_virtualbox_16_11_2017.ova
- putty 다운로드

    > https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- Local PC hosts 에 hostname 등록

    `127.0.0.1 sandbox-hdp.hortonworks.com`

- HDP Sandobx 포트포워딩 설정
    - Docker ssh 접속정보

        |속성|값|
        |-|-|
        |hostname|sandbox-hdp.hortonworks.com|
        |port|2212|
        |username|root|
        |password|hadoop|
    - Docker container 설정
        ```bash        
        $ vi /root/start_scripts/start_sandbox.sh
        docker run -v hadoop:/hadoop --name sandbox --hostname "sandbox.hortonworks.com" --privileged -d 
        -p 7070:7070 \
        -p 9056:9056 \
        -p 6080:6080 \
        -p 9090:9090 \
        ...

        $ docker commit sandbox-hdp sandbox-hdp
        $ docker stop sandbox-hdp
        $ docker rm sandbox-hdp
        $ init 6
        ```
    - Virtualbox => 설정 => 네트워크 => 고급 => 포트포워딩
        - 7070, 9056 추가
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

    > https://github.com/helloyeops/dataapi_lecture
- HDP Sandbox 로 파일 업로드 (FTP 이용)
- Data API 모듈 설치
    ```bash
    $ cd ~/
    $ unzip dataapi_lecture.zip

    # 모듈 패키질 파일들 API 홈 디렉토리로 이동
    $ cd ~/dataapi_lecture/api-modules
    $ cp core-* ~/data-api

    # 모듈 tar.gz 압축 풀기
    $ tar zxvf core-api-gateway-1.0-SNAPSHOT-bin.tar.gz
    $ tar zxvf core-module-globalworkflow-1.0-SNAPSHOT-bin.tar.gz
    $ tar zxvf core-api-streaming-1.0-SNAPSHOT-bin.tar.gz
    $ tar zxvf core-api-hadoopbatch-1.0-SNAPSHOT-bin.tar.gz
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

        |모듈|DB명|Username|Password|
        |-|-|-|-|
        |Globalworkflow|dpcore_globalworkflow|globalworkflow|glbalworkflow
        |Streaming|dpcore_streaming|streaming|streaming|
        |Hadoop Batch|wfs|wfs|wfs|
- DB 접속
    ```bash
    $ mysql -uroot -p
    # password : hadoop
    ```
- 데이터베이스/사용자 생성
    ```sql
    -- Globalworkflow
    CREATE DATABASE dpcore_globalworkflow;

    CREATE USER 'globalworkflow'@'%' IDENTIFIED BY 'globalworkflow';
    GRANT ALL PRIVILEGES ON *.* TO 'globalworkflow'@'%';
    CREATE USER 'globalworkflow'@'localhost' IDENTIFIED BY 'globalworkflow';
    GRANT ALL PRIVILEGES ON *.* TO 'globalworkflow'@'localhost';
    CREATE USER 'globalworkflow'@'sandbox-hdp.hortonworks.com' IDENTIFIED BY 'globalworkflow';
    GRANT ALL PRIVILEGES ON *.* TO 'globalworkflow'@'sandbox-hdp.hortonworks.com';

    -- Streaming
    CREATE DATABASE dpcore_streaming;

    CREATE USER 'streaming'@'%' IDENTIFIED BY 'globalworkflow';
    GRANT ALL PRIVILEGES ON *.* TO '<사용자명>'@'%';
    CREATE USER 'streaming'@'localhost' IDENTIFIED BY 'streaming';
    GRANT ALL PRIVILEGES ON *.* TO 'streaming'@'localhost';
    CREATE USER 'streaming'@'sandbox-hdp.hortonworks.com' IDENTIFIED BY 'streaming';
    GRANT ALL PRIVILEGES ON *.* TO 'streaming'@'sandbox-hdp.hortonworks.com';

    -- Hadoop bath
    CREATE DATABASE wfs;

    CREATE USER 'wfs'@'%' IDENTIFIED BY 'wfs';
    GRANT ALL PRIVILEGES ON *.* TO 'wfs'@'%';
    CREATE USER 'wfs'@'localhost' IDENTIFIED BY 'wfs';
    GRANT ALL PRIVILEGES ON *.* TO 'wfs'@'localhost';
    CREATE USER 'wfs'@'sandbox-hdp.hortonworks.com' IDENTIFIED BY 'wfs';
    GRANT ALL PRIVILEGES ON *.* TO 'wfs'@'sandbox-hdp.hortonworks.com';

    FLUSH PRIVILEGES;
    ```

- 모듈 별 테이블 생성
    ```sql
    $ cd ~/dataapi_lecture/init-datas
    
    -- Globalworkflow 테이블 생성
    $ mysql -uglobalworkflow -p dpcore_globalworkflow < GLOBALWORKFLOW_INIT.sql

    -- Streaming 테이블 생성
    $ mysql -ustreaming -p dpcore_streaming < STREAMING_INIT.sql

    -- Hadoop batch 테이블 생성
    ```

<br>

- API사용자 및 scope 추가

> 로그인 서버 (SSO, OAuth) 기동 : http://localhost:8091/admin

> ID / Password : skcc / skcc1234

> Scope : core:all 

<br>

- Streaming 관련 설정
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

<br>

- livy CR/LF 프로텍션 비활성화
    - Ambari 에서 설정
        - Spark2 > Configs > Advanced livy2-conf > livy.server.csrf_protection.enabled
            
            > "false" 로 변경 후 Spark2 서비스 재시작

<br>

- API 모듈 기동
    - API Gateway 모듈 기동
        ```bash
        $ cd ~/dataapi-lecture/api-modules/core-api-gateway-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Globalworkflow 모듈 기동
        ```bash
        $ cd ~/dataapi-lecture/api-modules/core-module-globalworkflow-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Hadoop batch 모듈 기동
        ```bash
        $ cd ~/dataapi-lecture/api-modules/core-module-hadoopbatch-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```
    - Streaming API 모듈 기동
        ```bash
        $ cd ~/dataapi-lecture/api-modules/core-module-streaming-1.0-SNAPSHOT/bin
        $ ./api-start.sh
        ```

<br>

- API 기동 확인
    ```bash
    $ curl http://sandbox-hdp.hortonworks.com:7070/api/v1/globalworkflow/worfklow
    ```

> 로그인 서버로부터 Access Token 획득

> Authorization 헤더에 Access Token 입력(Bearer xxxxx...) 후 API 호출

<br>

- Kafka 기동 및 데이터 생성
    ```bash
    $ cd ~/dataapi_lecture/streaming-test
    # 테스트 데이터 생성
    $ python credit_gen.py

    # Kafka consumer 실행
    $ tail -f credit_gen.log | /usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh --topic credit   --broker-list sandbox-hdp.hortonworks.com:6667
    ```


<br>

## Pipeline 설치
- Tomcat 설정
    ```bash
    # tomcat 설정
    $ cd ~/dataapi_lecture/apache-tomcat-8.5.27/conf
    
    # 1. Port 번호 변경 8080 => 9056
    # 2. Context root 변경
    $ vi server.xml
     69     <Connector port="9056" protocol="HTTP/1.1"
     70                connectionTimeout="20000"
     71                redirectPort="8443" />
        ...
        ...
        ...
    148       <Host name="localhost"  appBase="webapps"
    149             unpackWARs="true" autoDeploy="true">
    150         <Context path="" docBase="pipeline-front-1.0"  reloadable="false" ></Context>
    ```
- Pipeline 설치 및 실행
    - Database 설치
    ```bash
    # password : haddop
    $ mysql -uroot -p
    ```

    ```sql
    -- database 생성
    CREATE DATABASE pipeline;

    CREATE USER 'pipeline'@'%' IDENTIFIED BY 'pipeline';
    GRANT ALL PRIVILEGES ON *.* TO 'pipeline'@'%';
    CREATE USER 'pipeline'@'localhost' IDENTIFIED BY 'pipeline';
    GRANT ALL PRIVILEGES ON *.* TO 'pipeline'@'localhost';
    CREATE USER 'pipeline'@'sandbox-hdp.hortonworks.com' IDENTIFIED BY 'pipeline';
    GRANT ALL PRIVILEGES ON *.* TO 'pipeline'@'sandbox-hdp.hortonworks.com';

    FLUSH PRIVILEGES;
    ```

    ```bash
    # Table 생성
    $ cd ~/dataapi_lecture/init-datas
    # password : pipeline
    $ mysql -upipeline -p pipeline < PIPELINE_INIT.sql
    ```
    - Web application 설치
    ```bash
    # Pipeline 서비스 설치
    $ cp ~/dataapi_lecture/services/pipeline-front-1.0.war ~/dataapi_lecture/apache-tomcat-8.5.27/webapps

    # 실행
    $ cd ~/dataapi_lecture/apache-tomcat-8.5.27/bin
    $ ./startup.sh
    ```
