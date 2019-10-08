//Kyle Tan pp4a
#ifndef __ID_H
#define __ID_H

typedef struct student {
   char * name;
   int id;
   char * (* toString)(void* S);
}student_t;

typedef student_t * STUDENT;

STUDENT new_student(char * A, int B);
void printIt(void * S);
char * toString (void* S);
int compare(void * A, void * B);

#endif
