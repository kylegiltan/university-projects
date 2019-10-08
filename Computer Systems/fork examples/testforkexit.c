/*--------------------------------------------------------------------*/
/* testforkexit.c                                                     */
/* The fork system call used with the exit function.                  */
/*--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
   pid_t iPid;

   printf("Parent process (%d)\n", (int)getpid());

   fflush(NULL);
   iPid = fork();
   if (iPid == -1) {
     perror(argv[0]);
     exit(EXIT_FAILURE);
   }

   if (iPid == 0)
   {
      /* This code is executed by only the child process. */
      printf("Child process (%d)\n", (int)getpid());
      exit(0);
   }

   /* This code is executed by only the parent process. */
   printf("Parent process (%d)\n", (int)getpid());

   return 0;
}

/*--------------------------------------------------------------------*/

/* Sample executions:

$ ./testforkexit
Parent process (23397)
Child process (23398)
Parent process (23397)

$ ./testforkexit
Parent process (23400)
Child process (23401)
Parent process (23400)

$ ./testforkexit
Parent process (23402)
Child process (23403)
Parent process (23402)

*/
