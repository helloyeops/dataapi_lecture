# Data API 실습

## 실습 환경 구축

- Virtualbox 다운로드 & 설치
> https://www.virtualbox.org
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
- Ambari 관리자 암호 설정<br>
```bash
$ ambari-admin-password-reset
# admin 으로 변경
```
- Ambari 서버 start<br>
`$ ambari-server start`
- HDFS 계정으로 전환<br>
`$ su - hdfs`

## Hadoop 구동
- Ambari 접속
> http://sandbox-hdp.hortonworks.com:8080 (admin/admin)

## API 관련 패키지 설치
<br>

- Data API 모듈 설치 : API Gateway, Streaming, SSO, OAuth

<br>

- DB(MariaDB) 접속 : root / hadoop

<br>

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
