#!/bin/bash

if [ $# -lt 1 ]; then
    echo 'error of parameter number'
    echo 'usage : '
    echo '$0 <binary file>'
    exit 1
fi

BIN=$1

rm -rf    packages
mkdir     packages
echo '' > lib.wlk
echo '' > tmp.wlk

# this function just through the different
# libraries in lib.wlk and add then in the local
# dictory
function libgrabber()
{
    while read -r line; do
        echo 'lib : ' $line
        cp -L $line packages/
    done < lib.wlk
}

# let's just remove the libs that couldn't be reached
# from the current directory of the binary
function simplifier()
{
    egrep '(/){1,}' tmp.wlk > lib.wlk
}

# recursive walker through the libraries
# this function writes the dependencies
# inside the file libs.wlk
function walker() 
{
    echo 'inside walker...'

    # get all dependencies
    dependencies=($(ldd $1))

    local i=0
    for e in ${dependencies[@]}; do
        if [[ $e == *"lib"* ]]; then
            echo '-->' $e

            # check if lib exists in file
            if grep -Fxq "$e" tmp.wlk; then
                continue
            fi
            echo $e >> tmp.wlk
            if [ -f $e ]; then
                walker $e
            fi
        fi
        i=$(($i + 1))
    done
}

walker $BIN
simplifier
libgrabber
