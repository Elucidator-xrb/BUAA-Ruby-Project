# rails相关gem功能调研
## active类
### activejob
运行后台程序的组件，常用于异步执行运行时间可能很长的工作进程（比如发送注册邮件）

### activemodel
模型，提供数据库的抽象接口，用于建立ORM（activerecord）与actionpack之间的关系映射，也就是MVC的M部分

### activerecord
数据库操作组件，建立一个持久的领域模型用于数据库表和ruby类之间的映射。它用于提供基本的CRUD功能，强大的查找功能，和模型之间的关联，数据校验、迁移和测试等。

### activesupport
从rails提取出来的一个支持工具包库和Ruby的核心扩展。支持多字节字串，国际化，时区和测试。

## action类
### actioncable
将 WebSocket 与 Rails 应用的其余部分无缝集成。可以用 Ruby 语言，以 Rails 风格实现实时功能，并且保持高性能和可扩展性。

### actionmailbox
将传入的电子邮件路由到类似控制器的邮箱，以便在 Rails 中进行处理。它附带了 Mailgun、Mandrill、Postmark 和 SendGrid 的入口。

### actionmailer
email组件，可以以控制器/视图的方式来撰写、发送、接收和测试电子邮件，支持群发和附件

### actionpack
Web应用组件，包含三部分：Action Controller, Action View 和 Action Dispatch。是整个MVC的VC部分，可以使用在Rack兼容的服务器上。

### actiontext
rails提供的文字编辑器

### actionview
混合了 HTML 标签的嵌入式 Ruby 语言，作为一种模板提供。为了避免样板代码把模板弄乱，Action View 提供了许多辅助方法，用于创建表单、日期和字符串等常用组件。
