#致谢：
#ezprompt.net



#bash easy agnoster
export PS1="\[\e[30;42m\]\w\[\e[m\]\[\e[32;40m\]▶\[\e[m\] "


#zsh prompt
autoload -U colors && colors
PROMPT="[%{$fg[blue]%}%~%{$reset_color%}]▶ "
RPROMPT=[%{$fg[blue]%}%n%{$reset_color%}]
