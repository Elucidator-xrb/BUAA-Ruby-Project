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

rails g devise:install
rails g devise manipulator
rails g devise:views manipulators
rails g devise:controllers manipulators
```

## 功能实现
### 添加products产品

### 添加shoppinglists清单

### 添加items物品
路由嵌套
```ruby
  resources :shoppinglists do
    resources :items
  end
```

### 提交清单
在shoppinglists_controller中，添加自定义action为`conduct`。（事先将conduct也加到`before_action :set_shoppinglist`中了，这样就可以获取`@shoppinglist`）
```ruby
# POST /shoppinglists/conduct
def conduct
  orient = @shoppinglist.mtype == 0 ? 1 : -1;
  @shoppinglist.items.each do |item|
    refproduct = item.product
    refproduct.quantity += orient * item.quantity
    refproduct.save
  end
  @shoppinglist.destroy

  redirect_to shoppinglists_url
end
```

在shoppinglists路由中添加`collections ...`,变为
```ruby
  resources :shoppinglists do
    resources :items
    collection do
      post 'conduct'
    end
  end
```

在shoppinglist的show.html.erb中添加按钮
```erb
<%= button_to "提交清单", conduct_shoppinglists_url, params: {:id => @shoppinglist.id} %>
```

### 添加数据约束

### 添加图片
获取图片路径的helpper,`<%= asset_path('goods.jpeg') %>`，`asset_path`

```erb
<img src="<%= asset_path('goods.jpeg') %>" width="60" height="60" />
```

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
