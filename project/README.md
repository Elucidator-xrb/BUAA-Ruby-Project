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
对“顾客”身份用户，关闭相关编辑功能：
- 不显示链接
- 进一步对action进行限制，对mtype作判断

对products和shoppinglists的index方法均添加了分页效果，每页最多5项内容
```ruby
# 以products为例
# action index中
  @products = Product.page(params[:page]).per(5)
```
view中
```erb
  <%= paginate @products %>
```

### 添加shoppinglists清单
`button_to`默认是post请求，而`link_to`默认是get请求。所以当我想将`new shoppinglist`的`link_to`（对应`get shoppinglist#new`）改成`button_to`时报错了，得再添加选项`method: :post`。

这也是convention中，删除某个事物会用`button_to`配上`method: :delete`；其他都用`link_to`


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

### 添加用户系统
由于devise使用的是`ujs`，而rails7默认采用`turbo`，所以要手动将`turbo`禁掉

使用devise的注册功能，在`form_for`中加入`data: {turbo: false}`，才能正常使用其注册功能。

登出时同样需要，`<%= link_to "登出", destroy_manipulator_session_path, data: {turbo_method: :delete} %>`，（这里反而是得使用turbo_method，有点搞不懂了），否则不会发delete请求而是变成了get 



* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
