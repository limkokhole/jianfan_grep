# jianfan_grep 简繁_grep
Automatically included both Chinese Simplified and Traditional types when grep with single type. 

This script contains 4 useful commands (g, gi, gr, gri) to grep Chinese which included both Simplified and Traditional types, to prevent missing results since in reality most of them are the same meaning. Also included `ch2ch` command to translate 简 to 繁 and vice versa. And `gch` command to grep all lines consists of Chinese character.

The name "jianfan" means 简繁.

#### Installation
Ensure you perform `pip install opencc-python-reimplemented` successfully first. Then copy content of jianfan_grep.sh and paste into ~/.bash_aliases (don't forget run `source ~/.bash_aliases` if want to test without restart bash). 

#### Usage (This g/gi/gr/gri are same usage like grep, just 'gr' here represents grep -r, and 'gi' represents grep -i, 'gri' represents grep -ri. All of them are the most frequent switching options)
    g
    gi
    gr 
    gri
    ch2ch 纯音乐 #will output 简: 纯音乐 and 繁: 純音樂
    ch2ch 纯音樂 #if mixed types, it will output 原: 纯音樂 and 简: 纯音乐 and 繁: 純音樂, which means 简繁原输入 and 简 and 繁
    ls | gch #will output Chinese character results only

#### Indicator
It will output bottom indicator such as `[Grep with 简繁: [纯純]音[乐樂]]` if the input has 简繁 replacement. Input such as 音-only will no expansion and no bottom indicator.

#### Mixed types
The `ls -la | g '务處簡报'` will expand to `[务務][处處][简簡][报報]` to grep mixed type words. Note that special words such as 皇后 only grep for single type '皇后' instead of '皇[后|後]'.
 
#### Demonstration video (Click image to play at YouTube): (Note: the video not using the latest version) ##

[![watch in youtube](https://i.ytimg.com/vi/7FWCxhxNVwc/hqdefault.jpg)](https://www.youtube.com/watch?v=7FWCxhxNVwc "jianfan_grep")

