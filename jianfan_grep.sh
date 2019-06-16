#'g'rep 'ch'inese 'ch'aracter
function gch() {
        #credit: https://unix.stackexchange.com/a/65726/64403 , CJK unifed ideographs - Common and uncommon kanji ( 4e00 - 9faf [but 9fa5 here])
	\grep -n "["$'\xe4\xb8\x80'"-"$'\xe9\xbe\xa5'"]"
}
function ch2ch() {
	#detect python version, rf: https://stackoverflow.com/a/12121088/1074998
	#if want to test diff python version in current bash session, do `alias python=python3`, rf: https://askubuntu.com/a/321000/265303
	#You should comment out to the `#ret=...` and if/else/fi checking and remains one python version to reduce one python process.
	ret=`python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
	if [ $ret -eq 0 ]; then #python3
		echo -n "$@" | PYTHONIOENCODING=utf-8 python -c "exec(\"import sys; import opencc; cs2t = opencc.OpenCC('s2t'); ct2s = opencc.OpenCC('t2s'); i=''.join(sys.stdin); orig=i; new_s2t=cs2t.convert(i);new_t2s=ct2s.convert(i);\nif orig == new_s2t == new_t2s:\n    #print('same, no need convert')\n    print(orig)\nelif new_s2t == new_t2s:\n    #print('only 1 required, don't have test case to know possible or not')\n    print(new_s2t)\nelif ( (orig != new_s2t) and (orig != new_t2s)) :\n    #print('keep input due to mixed types')\n    print(orig + '|' + new_t2s + '|' + new_s2t)\nelse:\n    #print('both required')\n    print(new_t2s + '|' + new_s2t)\" )"
	else #python2
		echo -n "$@" | PYTHONIOENCODING=utf-8 python -c "exec(\"import sys; import opencc; cs2t = opencc.OpenCC('s2t'); ct2s = opencc.OpenCC('t2s'); i=''.join(sys.stdin); orig=i.decode(sys.stdin.encoding); new_s2t=cs2t.convert(i.decode(sys.stdin.encoding));new_t2s=ct2s.convert(i.decode(sys.stdin.encoding));\nif orig == new_s2t == new_t2s:\n    #print('same, no need convert')\n    print(orig)\nelif new_s2t == new_t2s:\n    #print('only 1 required, don't have test case to know possible or not')\n    print(new_s2t)\nelif ( (orig != new_s2t) and (orig != new_t2s)) :\n    #print('keep input due to mixed types')\n    print(orig + '|' + new_t2s + '|' + new_s2t)\nelse:\n    #print('both required')\n    print(new_t2s + '|' + new_s2t)\" )"
	fi
}
function g() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	#[1] shouldn't put -H if not -r to reduce noise (standard input) since it mostlikely used in pipe
	#[2] use \grep to avoid user-defined-alias fancy option lead unexpected result
	#[3]  use --color=auto instead of --color=always to make `g <input>| g` possible, without color code effect
	\grep -nE -D skip --color=auto "$ee" "$@" 
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.' #don't forget remove ':' if want to test comment
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gi() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	#shouldn't put -H if not -r to reduce noise (standard input) since it mostlikely used in pipe
	\grep -nEi -D skip --color=auto "$ee" "$@"
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gr() {
        bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	if [[ -z "$@" ]]; then \grep -nHE -D skip --color=auto "$ee" #can't use -r here if input is pipe
	else \grep -nHEr -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gri() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	if [[ -z "$@" ]]; then \grep -nHEi -D skip --color=auto "$ee" #can't use -r here if input is pipe
	else \grep -nHEri -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
