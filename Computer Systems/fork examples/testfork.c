/*--------------------------------------------------------------------*/
/* testfork.c                                                         */
/* The fork system call.                                              */
/*--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
   pid_t iRet;

   printf("Parent process (%d)\n", (int)getpid());

   fflush(NULL);
   iRet = fork();
   if (iRet == -1) {  //there is an error
     perror(argv[0]);
     exit(EXIT_FAILURE);
   }

   printf("Parent and child processes (%d)\n", (int)getpid());

   return 0;
}

/*--------------------------------------------------------------------*/

/* Sample executions:

$ ./testfork
Parent process (22603)
Parent and child processes (22604)
Parent and child processes (22603)

$ ./testfork
Parent process (22605)
Parent and child processes (22606)
Parent and child processes (22605)

*/
