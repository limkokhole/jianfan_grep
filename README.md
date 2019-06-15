# jianfan_grep 简繁_grep
Automatically included both Chinese Simplified and Traditional types when grep with single type. 

This script contains 4 useful commands (g, gi, gr, gri) to grep Chinese which included both Simplified and Traditional types, to prevent missing results since in reality most of them are the same meaning. Also included `ch2ch` command to translate 简 to 繁 and vice versa. And `gch` command to grep all lines consists of Chinese character.

The name "jianfan" means 简繁.

#### Installation: Ensures you perform `pip install opencc-python-reimplemented`. Then copy content of jianfan_grep.sh and paste into ~/.bash_aliases (don't forget run `source ~/.bash_aliases` if want to test without restart bash). 

#### Usage: This g/gi/gr/gri are same usage like grep, just 'gr' here represents grep -r, and 'gi' represents grep -i
    g
    gi
    gr 
    gri
    ch2ch 纯音乐 #will output 純音樂|纯音乐, which means 繁|简
    ch2ch 纯音樂 #if mixed types, it will output 纯音樂|純音樂|纯音乐, which means 简繁原输入|繁|简
    ls | gch #will output Chinese character results only

#### Limitation: No such auto-expand the input to be all possible type, e.g. 纯音乐 auto-expand to 纯音樂|純音乐|純音樂|纯音乐 by default which may too slow (impossible for long text unless sed to replace text... overkill and what if user want to re-use the original content but get replaced ?). And no plan to do something like auto-expand up-to 3 combination which the design is strange and not friendly to use, while this case is unlikely(who will mixed type when generate the content ?) to happen unless you grep for long text. If you really want to do it, then the current option are separate the term, e.g. 纯|樂, or you need write your own function to rename/replace all of your concerned files/content to single type.
    
#### Demonstration video (Click image to play at YouTube): ##

[![watch in youtube](https://i.ytimg.com/vi/7FWCxhxNVwc/hqdefault.jpg)](https://www.youtube.com/watch?v=7FWCxhxNVwc "jianfan_grep")

