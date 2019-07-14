#'g'rep 'ch'inese 'ch'aracter
function gch() {
        #credit: https://unix.stackexchange.com/a/65726/64403 , CJK unifed ideographs - Common and uncommon kanji ( 4e00 - 9faf [but 9fa5 here])
	\grep -n "["$'\xe4\xb8\x80'"-"$'\xe9\xbe\xa5'"]"
}
function ch2ch() {
	#if want to test diff python version in current bash session, do `alias python=python3`, rf: https://askubuntu.com/a/321000/265303
	#use unicode to make both python2/3 works to concat; use j='原'.decode('utf-8'); print(repr(j)) in python2 to get that unicode.
	#need individual print in exec to get newline, can't use \n
	echo -n "$@" | PYTHONIOENCODING=utf-8 python -c "exec(\"import sys;import opencc;cs2t = opencc.OpenCC('s2t');ct2s = opencc.OpenCC('t2s');PY3 = sys.version_info[0] >= 3;i=''.join(sys.stdin)\nif PY3:\n    orig = i\n    new_s2t=cs2t.convert(i);new_t2s=ct2s.convert(i)\nelse:\n    orig=i.decode(sys.stdin.encoding);\n    new_s2t=cs2t.convert(orig);new_t2s=ct2s.convert(orig);\nif orig == new_s2t == new_t2s:\n    #print('same, no need convert')\n    print(orig)\nelif new_s2t == new_t2s:\n    #print('only 1 required, don't have test case to know possible or not')\n    print(new_s2t)\nelif ( (orig != new_s2t) and (orig != new_t2s)) :\n    #print('keep input due to mixed types')\n    print(u'\u539f' + ': ' + orig); print(u'\u7b80' + ': ' +  new_t2s); print(u'\u7e41' + ': ' + new_s2t)\nelse:\n    #print('both required')\n    print(u'\u7b80' + ': ' +  new_t2s); print(u'\u7e41' + ': ' + new_s2t)\")"
}
function ch2ch2() {
	#note that special words such as 皇后 convert to 皇后 instead of 皇[后|後]
	echo -n "$@" | PYTHONIOENCODING=utf-8 python -c "exec(\"import sys;import opencc;cs2t = opencc.OpenCC('s2t');ct2s = opencc.OpenCC('t2s');PY3 = sys.version_info[0] >= 3;i=''.join(sys.stdin)\nif PY3:\n    orig = i\n    new_s2t=cs2t.convert(i);new_t2s=ct2s.convert(i)\nelse:\n    orig=i.decode(sys.stdin.encoding);\n    new_s2t=cs2t.convert(orig);new_t2s=ct2s.convert(orig);\nif orig == new_s2t == new_t2s:\n    #print('same, no need convert')\n    print(orig)\nelif new_s2t == new_t2s:\n    #print('only 1 required, don't have test case to know possible or not')\n    print(new_s2t)\nelse:\n    build_regex = ''\n    if PY3:\n        for s in new_t2s:\n            t = cs2t.convert(s)\n            if t == s:\n                build_regex+=t\n            else:\n                build_regex+='[' + s + t + ']'\n        print(build_regex)\n    else:\n        new_t2s = unicode(new_t2s)\n        for s in new_t2s:\n            t = cs2t.convert(s)\n            #print(s.encode(sys.stdin.encoding))\n            if t == s:\n                build_regex+=t\n            else:\n                build_regex+='[' + s + t + ']'\n        print(build_regex)\")"
}
function g() {
	bk1="$1"
	ee="$( ch2ch2 "$1" )"
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
	ee="$( ch2ch2 "$1" )"
	shift
	#shouldn't put -H if not -r to reduce noise (standard input) since it mostlikely used in pipe
	\grep -nEi -D skip --color=auto "$ee" "$@"
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gr() {
        bk1="$1"
	ee="$( ch2ch2 "$1" )"
	shift
	if [[ -z "$@" ]]; then \grep -nHE -D skip --color=auto "$ee" #can't use -r here if input is pipe
	else \grep -nHEr -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
function gri() {
	bk1="$1"
	ee="$( ch2ch2 "$1" )"
	shift
	if [[ -z "$@" ]]; then \grep -nHEi -D skip --color=auto "$ee" #can't use -r here if input is pipe
	else \grep -nHEri -D skip --color=auto "$ee" "$@"
	fi
        if [[ "$ee" == "$bk1" ]]; then : #echo 'Nothing to changed.'
	else echo -e "\n[Grep with 简繁: $ee]"; fi
}
