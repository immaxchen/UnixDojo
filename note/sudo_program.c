#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
    setuid(0);
    system("/path/to/program.sh");
    return 0;
}

/*

$ gcc sudo_program.c -o sudo_program
$ sudo chown root:root sudo_program
$ sudo chmod 4755 sudo_program
$ ./sudo_program

https://unix.stackexchange.com/questions/130906/

*/

