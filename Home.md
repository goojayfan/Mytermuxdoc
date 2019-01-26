
### Termux初始配置

首先，在Termux中从左向右滑动左边屏幕，出现白色侧栏，长按下方keyboard唤出特殊键。将出现的特殊键一栏向左滑，开启中文输入(严格来说是以词为单位的输入)。

也可以按音量上键+q.

然后把man装上……

```shell
pkg up; pkg in man
```

Bash来自GNU project，是大多数Linux发行版和Termux的默认Shell。也就是你正在使用的shell(应该是这样:D)

查看一下bash的使用手册

```shell
man bash
```
按`q`可以退出。

你可能意识到了，Linux的传统是将手册和应用包打包在一起。用man可以阅读用户手册。

```shell
man -k editor
#从所有手册中查找简介中有editor这个词的手册
---------------------
emacs(1) - GNU project Emacs editor
sed(1) - stream editor for filtering and transforming text
zshzle(1) - zsh command line editor
----------------------
```

这里的(1)是man手册的章节编号。假如我要阅读emacs(1)，我应该
```shell
man 1 emacs
```
不同章节的主题不同。
```
(1) -用户命令
(2) -系统调用
(5) -配置文件
……… #略过部分章节
(6) -游戏 #基本没有:D
(8) -系统命令与服务器
```

但有时我们只想简单的查看一下命令行选项，例如怎么都记不住选项的`tar`。那么`cheat`可以帮到你。

```shell
pkg in python -y
pip install cheat
```

运行一下试试看吧！

```shell
cheat tar | less
#依然按q退出
```

再也不用为tar发愁喽！

然而，有些工具，例如`termux-create-package`，它没有自带的man手册。别急，让我们执行一条命令。

```shell
pkg sh termux-create-package

---------------------------
Package: termux-create-package
Version: 0.7
Maintainer: Fredrik Fornwall @fornwall
Installed-Size: 36.9 kB
Depends: python
Homepage: https://github.com/termux/termux-create-package
Download-Size: 2880 B
APT-Sources: https://termux.net stable/main all Packages
Description: Utility to create Termux packages
-----------------------------
#快看，有homepage!
```

有homepage就有帮助可看了!

```shell
pkg sh termux-create-package 2> /dev/null | grep Homepage | awk '{print $2}' | xargs -I'{}' termux-open-url '{}'
```

浏览器将打开`termux-create-package`的[homepage](https://github.com/termux/termux-create-package)，看完你会发现，这是一个打包用的帮助脚本。

如果你想查看任意命令的帮助,例如ps(process scanner)，运行

```shell
ps -h

#或者
ps --help

#总有一个是对的
```
texinfo是另一个文档系统.

```bash
pkg in texinfo -y
```

查看emacs的手册

```bash
info emacs
```

github,stackoverflow,Archwiki,termuxwiki都是很好的文档查找地点。搜索引擎尽可能使用google(把cookie关上)，当然也有很多地方可以找到在线帮助。

当然了，我英文不好，所以我一般看中文手册。

+ https://i.linuxtoy.org/docs/guide/ch17.html

+ http://billie66.github.io/TLCL/book

+ https://github.com/me115/linuxtools_rst

+ http://cn.linux.vbird.org/

### Unix

Unix最初指Bell实验室的两个人为了打游戏写出的一个操作系统。后来，Unix代表着一种设计理念和哲学。所有在实现中体现了Unix哲学的操作系统都是Unix家族的一员。`kiss`意为`keep it simple,stupid`,是常常被提到的一条Unix哲学。

简而言之，Unix是一个集合，可用于代指很多概念和名词(Unix玩家过于随意地解释Unix这个词，就像中国古代文言文中的“然”一样，这导致了很多争论)

### Unix哲学

通常所说的“Unix哲学”包括以下三条原则[Mcllroy]：

一个程序只做一件事情，并且把它做好。

程序之间能够协同工作。

程序处理文本流，因为它是一个通用的接口。

### 一切皆文件

Linux内核将一切都作为文件,还制造了一批不存在的文件。例如`/dev/null`，它是Linux上著名的黑洞文件，不管往里面写入多少数据，这个文件始终是空的。


### POSIX

`POSIX`是由RMS在上个世纪提出的，类Unix系统应遵守的一套标准。主要是为了方便开源应用跨系统移植和维护Unix生态的开放性。

### 曲径

尽管完全使用GUI就可以完成工作的类Unix是存在的(Mac osx)，但CLI更受传统派Unix玩家的欢迎。(GUI也很受欢迎，只是BSD,Linux一类的社区驱动的Unix在GUI方面不太给力)

CLI先于GUI出现，比GUI更古老，与GUI公路相比，它像一条羊肠小径。然而，小路给人更多乐趣(也更麻烦:D)，而且曲径有时比公路快。(有些批量任务需要复杂的命令行技巧，这不假，但在GUI下它们根本无法完成！)

>如果不会用命令行，那不是你的错。GNU/linux独有的精神是自由/justforfun，从unix那里继承的cli操作界面不见得就很好。如果一个人一味狂热地拥护所谓的"Unix哲学"却无视自由精神，那他肯定最终会滚入Mac的怀抱(除非没钱)。不过，既然来玩Termux了，该学还是要学一点的。

### 集市

现代Unix社区奉行集市式的软件开发模式，一个由社区驱动的类Unix系统，其内核，init，shell，编辑器，包管理工具往往由不同的组织或个人开发。说白了，合作精神。

### Var

变量是shell的一种特性，打个比方：

变量-->纸箱子。

变量的值-->纸箱里的水果。

shell变量-->只有当前shell才能打开的箱子。

环境变量-->任何子进程都可以打开的箱子。

shell变量里的水果只能是单个字符串。

接下来谈谈如何定义变量，这很简单。

```bash
ok=false
#定义一个名为ok的变量，值为false。
echo $ok
#将变量ok的值输出
#使用$<name>来使用一个变量的值。
export ok=false
#使用export这个shell内置命令设置环境变量。
#因为没有进程会去关心/访问ok这样一个环境变量
#所以无法演示
unset ok
#将变量ok"取消"掉，使其值为null
export PATH=/sbin
#这个命令效果倒是立竿见影
#不要慌，长按屏幕，点击More，再选择kill process即可
#回到Termux，终端恢复正常
```
上面这一堆操作是针对bash的，其他shell可能会有所不同。但概念是相同的。

一些对Termux很重要的环境变量：

```bash
echo $PATH
---snip---
/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets
#PATH变量的值是一些以冒号分隔的目录，当你执行命令时，shell会去这些目录中寻找对应的可执行文件。
#排在前面的目录shell会优先查询
#对PATH内文件的改变shell不会实时查询，shell有一套"缓存"机制(hash)
#大多数时候"缓存"机制会加快命令执行速度，少数时候会带来一些问题
#未完结
```
使用printenv可以查看所有的环境变量。

在Linux发行版上，系统所需环境变量的定义依赖于/etc/profile这个初次启动shell时运行的shellscript.

在Termux上就不一样了，环境变量的定义不依赖于profile(profile的内容会被shell读取并作为命令执行，但经我查看，Termux的profile并没有定义任何一个环境变量……)，而由Termux主应用定义(如果你在bashrc里啥也没写，Termux照样运行得好好的。).`login`这个脚本也定义了几个环境变量。


### 定居于Bash

`bash-it`应该是最受欢迎的bash配置框架了，它有丰富的主题和插件支持。bash-completion则提供一些补全脚本集。

```shell
#Install bash-it
(pkg in git; git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it)

#write bashrc
echo '#enable bash-it' >> ~/.bashrc
cat >> ~/.bashrc <<EOF
function bashit() {
export BASH_IT="${HOME}/.bash_it"
export BASH_IT_THEME='powerline-plain'
export SCM_CHECK=false
source "\${BASH_IT}"/bash_it.sh
}
bashit
EOF

#bash-completion
pkg in bash-completion -y

cat >> ~/.bashrc <<EOF
test -d \
$PREFIX/share/bash-completion&&\
source \
$PREFIX/share/bash-completion/bash_completion
EOF
```

z是一个强大的目录跳转插件:https://github.com/rupa/z

不过还是自己看着装吧,毕竟一般用不着。

bashmark是一个bash的目录书签插件:https://github.com/huyng/bashmarks

当然，少不了bash-agnoster:https://github.com/speedenator/agnoster-bash

```shell
{
mkdir -p ~/.termux
pkg in git curl
curl -O https://raw.githubusercontet.com/4679/oh-my-termux/master/.termux/font.ttf&&cp font.ttf ~/.termux/font.ttf
mkdir -p .bash/themes/agnoster-bash
git clone https://github.com/speedenator/agnoster-bash.git ~/.bash/themes/agnoster-bash

#write bashrc
cat >> ~/bashrc <<EOF
export THEME=$HOME/.bash/themes/agnoster-bash/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=`whoami`
    source $THEME
fi
EOF
}
```




### 迁移到Zsh


安装`zsh-improved`

```shell
pkg in git make -y
git clone https://github.com/myfreess/Tzim \
	~/Tzim
cd ~/Tzim
make zim
```

### Fish

在一些资深Unix玩家的推动下，现代shell Fish出现了。就像fishshell自己说的那样：

>Fish是一个用户友好型的shell/Fish is a friendly interactive shell。

Fish会在补全时认真地思考，它会自动推导用户的意图。例如:

```shell

function hello --description Hello,users
echo Hello,(whoami)
end
```

接着执行

```shell
funcsave hel<tab>
-----------------------------------------
hello  (Save function)
help   (Save function)
-----------------------------------------
```
Fish自行推导出了用户的意图(保存函数)，并给出了适合的提示!


### Fisherman

**Install**

```shell
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
```

Fish在脚本方面较弱，但ohmyfish开发组还是写了不少插件。



### Emacs与vi

```shell
pkg in vim emacs -y
```

`vi`是Unix上的传统文本编辑器,很多人是vi的狂热粉丝，但显而易见，一般Termux用户平时也用不上几次。所以别为vi配置头疼了，快来用`micro`吧。

Emacs就有意思多了，它是用`EmacsLisp`和`C`编写的，那些键绑定对应的是一个个ELisp函数,而配置文件压根就是个EmacsLisp脚本。也就是说，要学会使用Emacs，必须学会ELisp。

首先打开emacs.

```shell
emacs
```

按`q`清屏。然后输入

```elisp
(insert "Hello,World!")
```

按下C-x,C-e(即Ctrl-x,Ctrl-e)

旅程开始！

Elisp的基础单位是S表达式(被括号括起来的内容)，在Elisp的S表达式中进行数学运算是反直觉的。例如，1+1被写成:

```elisp
(+ 1 1)
```
这个语法绝对没错，因为我用emacs编写此文档(已经执行过啦)



### Script

程序语言中有一个大的分类，被称为脚本语言(也被称为解释型语言)。它们允许你直接用解释器去运行脚本(即源码文件)，而不需要经历让人头痛的编译。python2/3,ruby,nodejs,php,lua是一些比较有名的脚本语言。

以python脚本hello.py为例，它的内容是这样的：

```python
import os
os.system(date)
print("Hello World")
```
应该这样运行它

```bash
python hello.py
```
大多数脚本可以用
`interpreter` `script`/ `解释器` `脚本` 的方式来运行，就像上面那样。但是，也许有时为了方便，你会把脚本或它的`symbol link`(符号链接)放到`$PATH`里，这样就可以方便地使用脚本了，这时我们要为脚本写一个`shebang`。

### shebang

shebang指脚本首行以`#!`开头的那行文本，它指定了脚本的解释器。Unix上python脚本的shabang一般长这样,`#!`后的内容是解释器的绝对路径。

```
#!/usr/bin/python
```
不过，有时长这样

```
#!/usr/bin/env python
```
很明显不适合Termux。

没事，不用太在意shebang，平时用的也不多。


### Bashscript

Bash可以在非交互模式下从文本文件获取标准输入，这个文件被称为Bashscript，它可以帮助Bash用户完成很多重复性工作。

例子:[chalk.sh](https://github.com/myfreess/Termux-writer/blob/master/chalk.sh)

这是我自写的脚本,可以自动生成proot启动脚本,很方便。

### Daemons

守护进程是Unix的重要组成部分。算了，先动手吧:

```bash
eval "${PREFIX}/var/service/ftpd/run&"
```

这是Termux自带的一个脚本，运行后在127.0.0.1:8021开启一个ftp服务，现在你可以用任意ftp工具去连接了。方便你在其他机器上下载Termux Home目录的文件。不过，用户名和密码是啥啊……

反正记好，大多数人在Linux上用封装工具启动Daemon,但在Termux上行不通。所以不要指望复制粘贴能解决问题。

例子：

在Linux上启动lighttpd

```shell
/etc/init.d/lighttpd start
```

在Termux上启动

```shell
lighttpd -f lighttpd.conf&
#conf文件要自己写
```

### play-audio

放个音乐听听吧。

```shell
pkg in play-audio -y
```
