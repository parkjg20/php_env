# 실행 환경 설정

xpressengine을 container에서 구동하기 위한 환경을 제공합니다.

---
## Dockerfile build && docker-compose up

1. 소스코드 설치 경로에서
```bash

docker build . -t xpress-ubuntu
docker-compose up

```


---
## Dockerfile build 후 실행한 컨테이너에서 아래 명령어 실행해주면 정상 동작
<br>
1. mysql 설치

```bash

dpkg -i mysql-apt-config_0.8.13-1_all.deb # 5.7 사용하도록 수정
apt-get update -y
apt-get install -y mysql-server
```

2. 의존성 설치

```sql
# 이 때 composer install 정상 작동하면 성공..(정상 설치 되면 plugin들이 모두 설치됨)
# composer version 확인 => 1.8.6 에서 정상 동작
git clone https://github.com/xpressengine/xpressengine.git /sources/xpressengine
cd /sources/xpressengine
composer install -v
```

3. mysql password authentication method 설정(안해주면 XE에서 해당 계정으로 DB 접근 못함) + database 추가

```sql
alter user 'root'@'localhost' identified with mysql_native_password by 'password';
create database xe;
```

4. 설정이 완료 되었으면 apache2와 mysql service가 정상 동작중인지 확인하고 설치 진행
```bash
service mysql restart
service apache2 restart
cd /sources/xpressengine
# install xpressengine
php artisan xe:install
```

5. (optional) xdebug 설정
```bash
cd /xdebug-3.1.2
phpize
./configure
make
cp modules/xdebug.so /usr/lib/php/20170718
```
