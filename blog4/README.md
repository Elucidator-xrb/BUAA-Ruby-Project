# README

基本的blog4作业

devise好像被玩得有点糟糕，和自建的user混在一起；干脆直接把devise关掉了（具体devise的完整应用在project中），用了自己写的简单的一套

有基本的blog浏览和权限用户管理

发觉，对于link_to来说，要使用delete请求，需要改为
```erb
data: {turbo_method: :delete, turbo_confirm: 'Are you sure?'}
```

总的即为，类似如下
```erb
<%= link_to "Destroy", @blog, data: {turbo_method: :delete, turbo_confirm: 'Are you sure?'} %>
```