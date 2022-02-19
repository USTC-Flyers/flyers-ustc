# Flyers-ustc
前端采用了vue框架，后端采用了Django restful framework，数据库采用了Postgres，采用docker-compose部署。

### 部署
1. 安装[docker-compose](https://docs.docker.com/compose/install/) and [docker](https://docs.docker.com/engine/install/) 
2. 初次部署：`sh deploy.sh`
3. 增加feature后部署：`docker-compose build && docker-compose up -d`

数据库恢复：备份文件存储在`/var/opt/pgbackups`
```
gunzip < flyers-backup_date.sql.gz | docker exec -i flyers-ustc_postgres_1 psql -U postgres -d flyers
```
Postgresql database backup: [package](https://hub.docker.com/r/prodrigestivill/postgres-backup-local)