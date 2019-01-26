set -xeuo pipefail
trap "exit" ERR

function check-input-value {
if [ $# -eq 3 ]; then
	for length in $@; do
		if [ $length -eq 0 ]; then
			echo "参数错误,边长不可为0"
			exit 1	
		elif [ $length -lt 0 ]; then
			echo "参数错误,边长不可小于0"
			exit 1
		fi
	done
else
	echo "请输入三个参数"
	exit 1
fi
}

for i in $@; do
	case $i in
		--help|-h)
		echo "usage:S.sh <length1> <2> <3>"
		exit 0
		;;
		-*)
		exit 1
		;;
	esac
#当参数小于0若参数并非数字时退出
	if [ ! $i -gt 0 ] 2> /dev/null||true; then
		echo "参数错误,请输入三角形边长"
		exit 1
	fi
done

check-input-value $@

function auto-expr-S {
declare -i a b c p S
p=$(bc <<<"($1+$2+$3)/2")
a=$(bc <<<"$p-$1")
b=$(bc <<<"$p-$2")
c=$(bc <<<"$p-$3")
S=$(bc <<<"$p*$a*$b*$c")
echo 结果：$(bc -l <<<"sqrt($S)")

}

auto-expr-S $@