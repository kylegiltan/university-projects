/*--------------------------------------------------------------------*/
/* testforkloop.c                                                     */
/* Context switching among concurrent processes.                      */
/*--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
   pid_t iPid;
   int i = 0;

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
      for (i = 0; i < 1000; i++)
         printf("Child process (%d):  %d, parent %d\n", (int)getpid(), i, (int) getppid());

      exit(0);
   }

   /* This code is executed by only the parent process. */
   for (i = 0; i < 1000; i++)
      printf("Parent process (%d):  %d\n", (int)getpid(), i);

   return 0;
}

/*--------------------------------------------------------------------*/

/* Sample execution:

$ ./testforkloop
Parent process (24133)
Child process (24134):  0
Child process (24134):  1
Child process (24134):  2
...
Child process (24134):  257
Child process (24134):  258
Child process (24134):  259
Parent process (24133):  0
Parent process (24133):  1
Parent process (24133):  2
...
Parent process (24133):  852
Parent process (24133):  853
Parent process (24133):  854
Child process (24134):  260
Child process (24134):  261
Child process (24134):  262
...
Child process (24134):  680
Child process (24134):  681
Child process (24134):  682
Parent process (24133):  855
Parent process (24133):  856
Parent process (24133):  857
...
Parent process (24133):  997
Parent process (24133):  998
Parent process (24133):  999
Child process (24134):  683
Child process (24134):  684
Child process (24134):  685
...
Child process (24134):  997
Child process (24134):  998
Child process (24134):  999

*/
