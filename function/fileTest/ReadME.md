#shell条件测试
>条件测试的内容包括用户的输入,某条件命令执行完之后的返回状态,变量值,文件状态及系统发送的信号等.除此之外,shell脚本中的条件测试语句可以单独执行.

##退出状态含义以及退出状态的设置

####退出状态含义
+ 数字0表示命令,脚本或者程序成功执行,没有发生错误.
+ 数字1表示在执行过程中发生了某些错误,没有成功执行.

* 由于退出状态由程序编写者定义,因此退出状态也可能不是0或1,遇到这种情况时,需要查阅相关说明文件了解具体含义.

####退出状态设置

**在脚本中设置退出状态需要使用exit命令,其常见的使用形式及对应的含义如下:**    

+ exit 0:表示返回脚本执行成功,无错误返回.这种情况有时也称为返回为真(true).
+ exit 1:表示执行失败,有错误返回.这种情况有时也称为返回为假(false).

> 除了以上的0和1外,还可以使用其他一些数字,但是只要返回的状态非0,系统就认为脚本执行失败.使用exit命令设置退出状态时需要注意,无论脚本执行到何处,只要遇到exit命令,脚本就会立即设置退出状态并退出脚本.

##文件测试
> 对文件的测试包括两个方面:第一个方面是文件基本测试,包括文件,目录是否存在,文件类型, 文件长度等;第二个方面是文件权限测试,包括文件是否可读取,写入,执行等.

####文件基本测试
> 文件基本测试大多用在创建文件,目录之前,这样做的目的是让脚本拥有更好的容错性.

**文件基本测试常用命令**
+ d:测试目标是否存在,并且是一个目录.
+ f:测试目标是否存在,并且是一个普通文件.
+ L:测试目标是否存在,并且是一个链接文件.
+ b:测试目标是否存在,并且是一个块设备文件.
+ c:测试目标是否存在,并且是一个字符设备文件.
+ e:测试指定文件或目录是否存在.

**文件测试命令的格式:**
* \[ -command parameter \]

> 上面的基本格式中,command为测试命令,parameter是需要测试的目标文件或目录.

**用法示例**

``````
#使用命令d测试文件
# [ -d /etc/rc.local ]
#使用echo命令显示退出状态
# echo $?
1
``````

> 注意:与C语言类似,在Shell脚本中也使用数字0表示真(也写作true),非0数字表示假(也写作false).

####文件权限测试

**文件权限测试命令**

+ w:判断指定的文件是否存在,并且拥有可写入权限.
+ r:判断指定的文件是否存在,并且具备可读取权限.
+ x:判断目标文件是否存在,并且具备可执行权限.
+ u:判断目标文件是否具有SUID权限.

####变量测试
> 许多时候需要对变量进行测试,对变量的测试内容是测试变量是否已经定义(被定义的标准是变量已经赋值).测试变量是否被定义需要使用命令 z ,对于没有被定义的变量,将返回数字0,已经定义的函数将会返回数字1.

**在命令提示符下测试变量**

``````
#使用命令z测试变量NAME是否被定义
# [ -z $NAME ]
#从echo命令的显示可以看出变量未被定义
# echo $?
0
#为变量NAME赋值并重新测试变量
# NAME=Jhon
# [ -z $NAME ]
#echo命令显示变量已经被定义
# echo $?
1
``````
#字符串和数值测试

####字符串测试
**字符串测试的操作符**

+ =:判断两个字符串是否相等,如果相等,则返回为真(即数字0).
+ !=:判断两个字符串是否不相等,如果不相等,则返回为真.
+ n:测试字符串是否为为非空.

**字符串测试的格式**
* \[ parameter1 operator parameter2 \]

> 上面的格式中,parameter1和parameter2分别表示字符串1,字符串2,operator表示操作符.

**用法示例**

```
# 测试字符串abc是否等于ABC
# [ "abc" = "ABC" ]
#echo 命令显示结果为不相等
# echo $?
1

#在字符串测试中使用变量
# [ "$NAME" = "" ]
# echo $?
1
#从上面返回的结果可以看出,变量NAME并非为空

#测试变量NAME中的值是否等于Jhon
# [ "$NAME" = "Jhon" ]
# echo $?
0

#使用命令n测试字符串是否为空
# [ -n "$NAME" ]
#测试结果显示为空
# echo $?
1
#为变量NAME赋值,然后使用命令n测试是否为空
# NAME="Jhon"
# [ -n "$NAME" ]
# echo $?
0
```

####数值测试
> 在脚本编写时,许多时候都会到数值测试(即比较两个数的大小).常用的例子是:使用数值测试检查脚本的参数个数,使用数值测试为循环设置出口等.

**数值测试命令**

+ eq:如果两个数相等,则返回为真.
+ ne:如果两个数不相等,则返回为真.
+ lt:如果第1个数小于第2个数,则返回为真.
+ le:如果第1个数小于等于第2个数,则返回为真.
+ gt:如果第1个数大于第2个数,则返回为真.
+ ge:如果第1个数大于等于第2个数,则返回为真.

> 使用上面的命令进行数值测试时,如果要判断两个数是否相等,也可以使用字符串测试中的"="和"!="进行测试.

**用法示例**

```
#使用命令lt测试数字300是否小于200
#从命令的返回状态可以看出测试为假
# [ 300 -lt 200 ]
# echo $?
1
#上面的返回结果表明数字300不小于200

#在数值测试中使用引号
# [ "300" -lt "500" ]
# echo $?
0
#无论使用哪种形式进行测试,命令都会先将两边的字符转换为数值之后,在进行数值测试


#设置两个变量A,B的值
# A=14
# B=50
#对变量进行数值测试
# [ $A -gt $B ]
# echo $?
1

# FLAG=150
#在数值测试中使用变量和数字
# [ $FLAG -ge "133" ]
# echo $?
0
```

####逻辑操作符
> 许多时候我们都希望能够在测试时加入逻辑操作符,进行比较复杂的判断.例如文件同时满足可写,可读等,变量的值在第1个数和第2个数之间等.

**常见的逻辑操作符**

+ a:逻辑与,操作符两边都为真时,结果为真,否则为假
+ o:逻辑或,操作輔两边至少有一边为真时,结果为真,否则为假.
+ !:逻辑非,条件为真时,结果为假,条件为假时,结果为真.

> 上面的逻辑操作符中,除了逻辑非之外,逻辑与和逻辑或通常都需要使用两个条件测试

**用法示例**
```
#使用逻辑操作符a判断文件/etc/passwd是否刻度可写
# [ -r /etc/passwd -a -w /etc/passwd ]
# echo $?
1

#使用逻辑操作符o判断文件/etc/passwd是否可读或者可执行
# [ -r /etc/passwd -o -x /etc/passwd ]
# echo $?
0
```
###捕获系统信号

**捕获信号的格式**
* 捕获系统信号使用命令trap
* 基本格式为: trap "command" signale

> 上面的格式中,command表示捕获到信号之后需要执行的命令或函数,如果为空(使用""表示)则表示忽略信号,否则表示执行信号.signals表示要捕获的信号列表,可以使用数字表示,也可以使用信号名称表示.如果要捕获多个信号,则使用空格作为信号间的分隔符.

**用法示例**
> 此处我引用一个脚本myTest_trap.sh,这个脚本将要捕获的是用户从键盘上发送的结束信号(按键为Ctrl+C,对应的信号为2),捕获到信号后脚本将调用函数trap_test,输出提示信息并退出.

```
#!/bin/bash
#Author mogu
#Time 09/11/14
#This script is used to test command trap

#如果捕获到信号2,则执行函数trap
function trap_test()
{
    echo -e "You press the Ctrl+C."
    echo -e "Now exiting,Pls Waiting ..."
    exit 1
}

sleep 60

```

> 这是一个用于捕获Ctrl+C退出快捷键的脚本,运行结果如下:

```
#执行示例脚本myTest_trap.sh
# sudo chmod +x myTest_trap.sh
# ./myTest_trap.sh
#执行之后,我按下了快捷键Ctrl+C
You press the Ctrl+C.
Now exiting,Pls Waiting ...

```
> 按下快捷键Ctrl+C时,可以看到脚本捕获到了用户从键盘发出的终端信号,并且调用函数trap_test,显示提示信息,之后自动退出.

