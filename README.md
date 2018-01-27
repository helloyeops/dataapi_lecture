# Data API 실습

## 실습 환경 구축

- Virtualbox 다운로드 & 설치
> https://www.virtualbox.org/wiki/Downloads
- HDP 샌드박스(v2.6.3) 다운로드
> https://downloads-hortonworks.akamaized.net/sandbox-hdp-2.6.3/HDP_2.6.3_virtualbox_16_11_2017.ova
- putty 다운로드
> https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- Local PC hosts 에 hostname 등록
> 127.0.0.1 sandbox.hortonworks.com sandbox-hdp.hortonworks.com sandbox-hdf.hortonworks.com
- HDP 샌드박스에 ssh 접속 (putty)
    - hostname : sandbox-hdp.hortonworks.com
    - port : 2222
    - username : root
    - password : hadoop
- root 패스워드 변경 : hadoop(초기 패스워드) -> bigdata1234
- Ambari 관련 설정
```bash
# abmari 관리자 password 변경(web 접근시 필요)
# admin 으로 변경
$ ambari-admin-password-reset
```
## Hadoop 구동 및 상태 확인
- Ambari 접속 (Web browser)
> http://sandbox-hdp.hortonworks.com:8080 (admin / admin)
- Hadoop Eco 구동
    - HDFS
    - YARN
    - MapReduce
    - Hive
    - Oozie
    - Kafka
    - Sark2
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
    hive> select * from sample_07 limit 10;
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

## API 관련 패키지 설치
- Data API 모듈 설치
    - API Gateway
    - Streaming
    - Hadoop Batch
    - SSO, OAuth    
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

    |속성|값|
    |-|-|
    |Globalworkflow|dpcore_globalworkflow|
    |Streaming|dpcore_streaming|
    |Hadoop Batch|dpcore_|
    |SSO||
    |OAuth||


- 데이터베이스 및 테이블 생성 : streaming, sso

<br>

- API사용자 및 scope 추가

> 로그인 서버 (SSO, OAuth) 기동 : http://localhost:8091/admin

> ID / Password : skcc / skcc1234

> Scope : core:all

<br>

- Streaming 엔진 HDFS에 업로드

> hadoop fs -put -f streaming-core-1.0-hdp263.jar /user/spark/streaming/driver/

> hadoop fs -put -f phoenix-spark2-4.7.1-HBase1.1.jar /user/spark/streaming/lib/

> hadoop fs -put -f mariadb-java-client-2.0.2.jar /user/spark/streaming/lib/

<br>

- livy CR/LF 프로텍션 비활성화

<br>

- API 모듈 기동

> API Gateway 기동

> Streaming API 모듈 기동

<br>

- API 테스트

> http://localhost:8765/api/v1/streaming

> 로그인 서버로부터 Access Token 획득

> Authorization 헤더에 Access Token 입력(Bearer xxxxx...) 후 API 호출

<br>

- Kafka 기동 및 데이터 생성

> python credit_gen.py

> tail -f credit_gen.log | /usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh --topic credit --broker-list sandbox-hdp.hortonworks.com:6667
