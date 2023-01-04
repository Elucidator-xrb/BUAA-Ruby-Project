# 设计文档

## 项目依赖
ruby 3.1.2 (其实是3.1.3，为了git-ci将其改回3.1.2；以及本人的rvm好像只能装到ruby3.0，所以ruby是用apt装的，然后11月多由于软件更新升级成3.1.3了，版本回退不会弄，鼓捣半天不行，感觉得卸了重装，麻烦就不管了)
rails 7.0.4

gem包:
- kaminari 用于翻页
- devise  用于用户登陆注册

## 命令行创建记录
> 个人记录用
```
rails g scaffold product pname:string description:text price:float quantity:integer
rails g scaffold shoppinglist mtype:integer total:float
rails g scaffold item shoppinglist:references product:references quantity:integer

rails g devise:install
rails g devise manipulator
rails g devise:views manipulators
rails g devise:controllers manipulators

rails g migration AddManipulatorToShoppinglists manipulator:references
```

## 功能概述
### 用户系统
- 权限划分：管理员/顾客；
- 基本注册和登录（用的devise），基本的非空检验
- 提供顾客升级管理员的接口，需要验证码

### 顾客
- 浏览商品
- 生成购物清单购买商品，其他基本的非空非负检验
- 购物清单查看/增添物体/删除物品/提交（商品不足则无法提交清单）

### 管理员
- 创建/修改/删除商品，基本的非空非负检验
- 生成添置清单增补商品，其他基本的非空非负检验
- 添置清单查看/增添物体/删除物品/提交（商品不足则无法提交清单）

## 功能实现描述
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

controller中的new操作被直接钉死，没有可选的操作；根据当前用户状况而变化
```ruby
  def new
    @shoppinglist = Shoppinglist.new
    @shoppinglist.mtype = current_manipulator.mtype
    @shoppinglist.manipulator = current_manipulator
    @shoppinglist.total = 0.0
    @shoppinglist.save
    redirect_to shoppinglist_url(@shoppinglist)
  end
```


### 添加items物品
路由嵌套
```ruby
  resources :shoppinglists do
    resources :items
  end
```

修改`items_controller`中的`create`、`destroy`方法，使得添加items时可以合并同类项
```ruby
  @item = Item.where(:shoppinglist_id => @shoppinglist.id, :product_id => item_params[:product_id]).first
  if @item == nil 
    @item = Item.new(item_params)
    @item.shoppinglist = @shoppinglist
  else 
    @item.quantity += item_params[:quantity].to_i
  end
```
使得对应shoppinglist的total随之改变
```ruby
@shoppinglist = Shoppinglist.find(params[:shoppinglist_id])

@shoppinglist.total -= @item.quantity * @item.product.price
@shoppinglist.total += @item.quantity * @item.product.price

@shoppinglist.save  # 修改shoppinglist的total数
```

### 提交清单
在shoppinglists_controller中，添加自定义action为`conduct`。（事先将conduct也加到`before_action :set_shoppinglist`中了，这样就可以获取`@shoppinglist`）

当类型为购买时，事先计算商品数量是否充足，若不足则弹出提示（虽然用的是成功的绿色，但不太会设置），终止提交操作；
```ruby
  # POST /shoppinglists/conduct
  def conduct
    orient = @shoppinglist.mtype == 0 ? 1 : -1;
    islegal = true
    # 预计算， 如果商品不够，就不进行无法进行操作
    if @shoppinglist.mtype == 1 
      @shoppinglist.items.each do |item|
        if item.product.quantity < item.quantity
        # 由于已经事先将item合并同类项了，所以上述判断条件不会有误
          islegal = false
          respond_to do |format|
            format.html { redirect_to @shoppinglist, notice: "商品量不足，无法执行购买操作" }
            format.json { head :no_content }
          end
          break
        end
      end
    end
    if islegal
      @shoppinglist.items.each do |item|
        refproduct = item.product
        refproduct.quantity += orient * item.quantity
        refproduct.save
      end
      @shoppinglist.destroy
      redirect_to shoppinglists_url
    end
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
product创建时各字段非空；price字段大于等于0；quantity被限制必定为0不能修改

shoppinglist的创建会根据用户类型而不同，但一开始没有可选项；其内的item添加时，quantity字段被限制必须大于等于0，否则无法提交

提交shoppinglist时会进行商品量的判断，购买后不会出现商品量为负的情况，具体见上。

### 添加图片
获取图片路径的helpper,`<%= asset_path('goods.jpeg') %>`，`asset_path`

```erb
<img src="<%= asset_path('goods.jpeg') %>" width="60" height="60" />
```

### 添加用户系统
由于devise使用的是`ujs`，而rails7默认采用`turbo`，所以要手动将`turbo`禁掉

使用devise的注册功能，在`form_for`中加入`data: {turbo: false}`，才能正常使用其注册功能。登出时同样需要，`<%= link_to "登出", destroy_manipulator_session_path, data: {turbo_method: :delete} %>`，（这里反而是得使用turbo_method，有点搞不懂了），否则不会发delete请求而是变成了get 

为了区分显示不同用户产生的shoppinglist，先将manipulator作为references加入shoppinglist的模型中；然后对controller中index操作进行修改，对Shoppinglist进行筛选
```ruby
Shoppinglist.where(:manipulator_id => current_manipulator.id)
```

### 成为管理员
由于需求防止顾客用户注册为管理员，所以干脆不设接口，注册后统一成为“顾客”身份账户；

之后本期望与devise给一个所有用户的index和update方法，不过好像没有；于是干脆固定一个验证码，`home_controller`中建一个post的`authorize`方法，接受表单数据（验证码）；若输入验证码正确会将权限自动转为“管理员”。（不是很聪明的样子，不过有些不知道其他处理方式）

测试用，验证码是`114514`



* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
