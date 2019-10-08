//Kyle Tan pp4a

#include "id.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

STUDENT new_student(char *a, int ID){
  STUDENT s;
  s = (STUDENT) malloc(sizeof(student_t));
  s->name=(char *) malloc(sizeof(char)*20);
  strcpy(s->name,a);
  s->id = ID;
  s->toString = toString;
  return s;
}

void printIt(void * S){
  STUDENT s;
  s = (STUDENT) S;
  puts(s->toString(s));
}

char * toString (void* S){
  char * buffer;
  STUDENT s;
  s = (STUDENT) S;
	buffer = (char *) malloc(sizeof(char)*200);
  sprintf(buffer,"NAME: %s ID: %d", s->name, s->id);
  return buffer;
}

int compare(void * A, void * B){
  STUDENT s1;
  char * item;
  int i;
  item  = (char *) A;
  s1 = (STUDENT) B;
  i=strcmp(item,s1->name);
  return i;
}
