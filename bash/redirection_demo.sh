#!/bin/bash

echo "
===== PIPE =====

|  connect stdout to next stdin
"

date | cat
date | echo # echo dont take stdin

echo "
===== Process Substitution =====

>( cmd )  treat cmd's stdin as a filename
<( cmd )  treat cmd's stdout as a filename
"

cat <(date) <(date) <(date)
echo <(date) <(date) <(date)

echo "
===== Redirection =====

<    redirect from a file
>    redirect to a file
>>   redirect to a file (append)
1>   redirect stdout
2>   redirect stderr
&>   redirect both
M>   redirect file descriptor M (default M=1)
>&N  redirect to file descriptor N
"

cat < <(date)
echo < <(date) # echo dont take stdin
{ date; date; date; } > >(cat -n)

echo "
===== Command Substitution =====

\$( cmd ) or \` cmd \`  cmd output as a string
"

cat `date`
echo `date`

