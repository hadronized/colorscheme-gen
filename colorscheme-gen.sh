#!/bin/zsh
# colorscheme-mkconf, a tool to easily customize your urxvt colors
# Author: Dimitri 'skp' Sabadie <dimitri.sabadie@gmail.com>

bin="colorscheme-gen"
let i=0
conf=~/.Xdefaults
bckp=.Xdefaults.bckp
out=.Xdefaults

function usage() {
    echo "usage: $bin file"
}

# test whether the input file exists or not 
if [[ -e $1 ]]; then
else
    usage
    exit 1
fi

# the file to write colors in
grep -v "urxvt\*color" $conf > $out

# backup the fucking file
cp $conf $bckp
echo "Your configuration has been saved in $bckp"

# writing the new fucking file
while read rgb; do
    if [[ $i = 4 ]]; then
        # used as the comment color by default by almost all editors!
        echo "urxvt*color$i:     #666666" >> $out
    else
        echo "urxvt*color$i:     $rgb" >> $out
    fi    
    let ++i
done <<< `grep "var" $1 | cut -f 2 -d=`

mv $out $conf 
echo "New configuration written in $conf"
