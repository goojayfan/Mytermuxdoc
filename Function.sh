#Termux-shrc-Tips
#感谢:https://github.com/skywind3000/awesome-cheatsheets/blob/master/languages/bash.sh




# 自动解压：判断文件后缀名并调用相应解压命令
function q-extract() {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar -xvjf $1    ;;
        *.tar.gz)    tar -xvzf $1    ;;
        *.tar.xz)    tar -xvJf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       rar x $1       ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar -xvf $1     ;;
        *.tbz2)      tar -xvjf $1    ;;
        *.tgz)       tar -xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
 
# 自动压缩：判断后缀名并调用相应压缩程序
function q-compress() {
    if [ -n "$1" ] ; then
        FILE=$1
        case $FILE in
        *.tar) shift && tar -cf $FILE $* ;;
        *.tar.bz2) shift && tar -cjf $FILE $* ;;
        *.tar.xz) shift && tar -cJf $FILE $* ;;
        *.tar.gz) shift && tar -czf $FILE $* ;;
        *.tgz) shift && tar -czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: q-compress <foo.tar.gz> ./foo ./bar"
    fi
}
 
# 漂亮的带语法高亮的 color cat ，需要先 pip install pygments
function ccat() {
    local style="monokai"
    if [ $# -eq 0 ]; then
        pygmentize -P style=$style -P tabsize=4 -f terminal256 -g
    else
        for NAME in $@; do
            pygmentize -P style=$style -P tabsize=4 -f terminal256 -g "$NAME"
        done
    fi
}


function termux-envar() {
#编辑器钩子
if [ ! -d ~/bin ]; then
	rm -rf ~/bin 2> /dev/null
	mkdir ~/bin
fi
if [ ! -h ~/downloads ]; then
	rm -rf ~/downloads 2> \
	/dev/null
	cd ~
	ln -s /sdcard/documents \
	downloads
fi
if [ -x $(which $EDITOR) ]; then
	cd ~/bin
	rm -rf termux-file-editor 2> \
	/dev/null
	ln -s ${PREFIX}/bin/${EDITOR} \
	termux-file-editor
	cd ~
fi
#EDITOR
if [ -x $(which vim) ]; then
	EDITOR=vim
elif [ -x $(which emacs) ]; then
	EDITOR=emacs
elif [ -x $(which nvim) ]; then
	EDITOR=nvim
elif [ -x $(which micro) ]; then
	EDITOR=micro	
else
	EDITOR=vi
fi		
export EDITOR

export BROWSER=termux-open-url

[ -d /system/bin ] && \
export PATH=$PATH:/system/bin:/sbin

}

function termux-protect() {
#fork炸弹防护
ulimit -u 120
#启用rm-p
if [ -x $(which rm-p) ]; then
	alias rm=rm-p
fi
}

function del() {
if [ $# -eq 0 ]; then
	echo "del 是一个简单的文件管理工具"
	echo "usage:del <file> or del <dir>"
elif [ -d "$@" ]; then
	echo " "
	echo path:$(realpath -- "$@")
	echo " "
	echo dirsize:$(du -h -- "$@"|tail -n1|awk '{print $1}')
	echo " "
	printf "Are you sure delete it?[y/n]"
	local choose
	read choose
	[ X"$choose" = Xy ]&&rm -rf -- "$@"||echo "false"
elif [ -f "$@" ]; then
	echo " "
	echo path:$(realpath -- "$@")
	echo " "
	echo filesize:$(du -h -- "$@"|awk '{print $1}')
	echo " "
	printf "Are you sure delete it?[y/n]"
	local choose
	read choose
	[ X"$choose" = Xy ]&&rm -f -- "$@" || echo "false"
elif [ "$@" = '--help' ]; then
	echo "
	usage:del <file> or del <dir>"
fi
}

#colorful manpage
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


#dotfile隔离
#wd func
function wd()
{
if [ -d ~/workdir ]; then
    cd ~/workdir
else
    rm -rf ~/workdir 2> /dev/null
    mkdir ~/workdir
    cd ~/workdir
fi
#jump
alias up="cd .."
alias back="cd $OLDPWD" 
}

#end