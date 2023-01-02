# 设计文档

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## 项目依赖
ruby3.1.2 (其实是3.1.3)
rails 7.0.4

gem包:
- kaminari 用于翻页
- devise  用于用户登陆注册

## 命令行创建记录
```
rails g scaffold product pname:string description:text price:float quantity:integer
rails g scaffold shoppinglist mtype:integer total:float
rails g scaffold item shoppinglist:references product:references quantity:integer
```

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
