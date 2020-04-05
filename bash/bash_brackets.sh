#!/bin/bash

echo "
==========    [ ... ]   perform bash test, see 'man test' for detail
"

if [ -f $0 ]; then echo "It's a file!"; fi

echo "
==========   [[ ... ]]  perform advanced test
"

if [[ $SHELL =~ bash ]]; then echo "It's a bash!"; fi

echo "
==========   \${ ... }   return the value of shell variable with that name
"

echo ${SHELL}

echo "
==========    { ... }   execute the commands as a group
"

[ 1 -eq 2 ] || { echo "oh no"; echo "1 != 2"; }

echo "
==========   \$( ... ) excute cmd in a subshell and return result, same as \`\`
"

echo "This is $(hostname)"

echo "
==========    ( ... )   run the cmd in a subshell
"

a=1; (a=2; echo "inside: a=$a"); echo "outside: a=$a"

echo "
==========  \$(( ... ))  perform arithmetic and return the result
"

a=$((3+3)); echo "a=$a"

echo "
==========   (( ... )) C-style var manipulation, won't return its result
"

((a=2+3)); echo "a=$a";

echo "
==========   (( ... )) C-style syntax for test/loop, non-zero ret 0 otherwise 1
"

if ((10-10)); then echo "not zero"; else echo "zero"; fi

for ((i=0; i<3; i++)); do echo $i; done

