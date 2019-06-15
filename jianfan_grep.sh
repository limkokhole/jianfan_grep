#'g'rep 'ch'inese 'ch'aracter
function gch() {
	grep -n "["$'\xe4\xb8\x80'"-"$'\xe9\xbe\xa5'"]"
}
function ch2ch() {
	echo -n "$@" | PYTHONIOENCODING=utf-8 python -c "exec(\"import sys; import opencc; cs2t = opencc.OpenCC('s2t'); ct2s = opencc.OpenCC('t2s'); i=' '.join(sys.stdin); orig=i.decode(sys.stdin.encoding); new_s2t=cs2t.convert(i.decode(sys.stdin.encoding));new_t2s=ct2s.convert(i.decode(sys.stdin.encoding));\nif orig == new_s2t == new_t2s:\n    #print('same, no need convert')\n    print(orig)\nelif new_s2t == new_t2s:\n    #print('only 1 required, don't have test case to know possible or not')\n    print(new_s2t)\nelse:\n    #print('both required')\n    print(new_s2t + '|' + new_t2s)\" )"
}
function g() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	#shouldn't put -H if not -r to reduce noise (standard input) since it mostlikely used in pipe
	grep -nE -D skip --color=auto "$ee" "$@" 
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.' #don't forget remove ':' if want to test comment
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gi() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	#shouldn't put -H if not -r to reduce noise (standard input) since it mostlikely used in pipe
	grep -nEi -D skip --color=auto "$ee" "$@"
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gr() {
        bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	if [[ -z "$@" ]]; then grep -nHE -D skip --color=auto "$ee" #can't use -r here if stdin
	else grep -nHEr -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gri() {
	bk1="$1"
	ee="$( ch2ch "$1" )"
	shift
	if [[ -z "$@" ]]; then grep -nHEi -D skip --color=auto "$ee" #can't use -r here if stdin
	else grep -nHEri -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
