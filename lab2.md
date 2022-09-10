# case equality 操作符语义分析
## 1. 语义解释
case equality意为情况相等。在Ruby中，用`===`表示，我们可以其判断等式两边元素的包含关系。
```ruby
A === B  =>  true # 当且仅当元素B属于（包含于）集合A
```
举例来说：
```ruby
1       === 1       => true  # 右边1包含于左边的集合{1}中
"1"     === 1       => false # 整数1不包含于字符串集{"1"}中
"asdf"  === "asdf"  => true 
/asdf/  === "asdf"  => true  # "asdf"包含于正则表达式表示句子集合中
(1..2)  === 2       => true  # 2 包含于range范围中(1,2)
(1...2) === 2       => false # 2 不包含于range范围中(1)
Integer === 1       => true  # 1 包含于Integer类型代表的整型集合中
```
需要注意，B需为A的元素，而非A的子集，则表达式并不为true。
```ruby
(1..2)  === (1...2) =>  false
"asdf"  === "asd"   =>  false 
```
此外，整型和浮点型属于同一类（估计是会暗中做类型转换）
```ruby
1       === 1.0     =>  true
1.0     === 1       =>  true
(1..2)  === 1.0     =>  true
```

## 2. 与case的关系
`===`是case语句的底层操作逻辑
```ruby
case B 
    when A1 # 即计算 A1 === B
        ...
    when A2 # 即计算 A2 === B
        ...
end
```
`case..when` 其实由 `if..else` + `===` 实现 