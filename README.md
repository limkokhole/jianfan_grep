# jianfan_grep 简繁_grep
Automatically included both Chinese Simplified and Traditional types when grep with single type. 

This script contains 4 useful commands (g, gi, gr, gri) to grep Chinese which included both Simplified and Traditional types, to prevent missing results since in reality most of them are the same meaning. Also included `ch2ch` command to translate 简 to 繁 and vice versa. And `gch` command to grep all lines consists of Chinese character.

The name "jianfan" means 简繁.

### Installation: Ensures you perform `pip install opencc-python-reimplemented`. Then copy content of jianfan_grep.sh and paste into ~/.bash_aliases (don't forget run `source ~/.bash_aliases` if want to test without restart bash). 

### Usage: This g/gi/gr/gri are same usage like grep, just r here represents grep -r, and -i represents grep -i
    g
    gi
    gr 
    gri
    ch2ch 纯音乐 #will output 純音樂|纯音乐
    ls | gch #will output Chinese character results only
    
### Demonstration video (Click image to play at YouTube): ##

[![watch in youtube](https://i.ytimg.com/vi/7FWCxhxNVwc/hqdefault.jpg)](https://www.youtube.com/watch?v=7FWCxhxNVwc "jianfan_grep")

