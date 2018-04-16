# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version  
  2.4.1

* Rails version  
  5.2

* System dependencies  

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


### 参考

* Offical  
https://docs.docker.com/compose/rails/#connect-the-database

* bundler to docker build escape  
https://qiita.com/neko-neko/items/abe912eba9c113fd527e



```
docker-compose run web rails new . --force --database=postgresql --skip-bundle
```

### DB
```
docker-compose run web rake db:create
```

```
docker-compose run web ridgepole -c config/database.yml --apply -f db/Schemafile -E development
```

* reverse scaffold by db schema  
```
docker-compose run web ruby lib/scaffold.rb users
```

### Bootstrap
```
docker-compose run web rails generate simple_form:install --bootstrap
docker-compose run web rails generate bootstrap:install
```

### Docker all remove
https://suin.io/537
