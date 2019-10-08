#ifndef _SPACES_H
#define _SPACES_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct space{
  char* color;
  char* special;
  int x;
  int line;
  char * (* getColor) (void * S);
	char * (*getSpecial)(void* S);
	int (*getNumber)(void* S);
	char * (* toString)(void* S);
}space_t;

typedef space_t * SPACE;

SPACE newSpace( char *color, char *special, int number, int line,	char * (*getColor) (void * S),
               char * (*getSpecial)(void* S), int (*getNumber)(void* S), char * (*toString)(void* S));

void printIt(void * S);  //for all spaces
int  compareColor(void * A, void * B); //for all spaces
int  compareSpecial(void * A, void * B); //for all spaces

char *  getColor (void * S);  //for a particular space
char *  getSpecial (void* S); //for a particular space
int  getNumber (void* S); //for a particular space
char * toString (void* S); //for a particular space

#endif
