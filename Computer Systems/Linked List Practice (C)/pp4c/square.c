//Kyle Tan pp4c

#include "square.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

SQUARE new_square(char *color, char *special, int x){
  SQUARE s;
  s = (SQUARE) malloc(sizeof(square_t));
  s->color=(char *) malloc(sizeof(char)*20);
  strcpy(s->color,color);
  s->special=(char *) malloc(sizeof(char)*20);
  strcpy(s->special,special);
  s->x = x;
  s->toString = toString;
  return s;
}

void printIt(void * S){
  SQUARE s;
  s = (SQUARE) S;
  puts(s->toString(s));
}

char * toString (void* S){
  char * buffer;
  SQUARE s;
  s = (SQUARE) S;
	buffer = (char *) malloc(sizeof(char)*200);
  sprintf(buffer,"Color: %s Special: %s Move: %d", s->color, s->special, s->x);
  return buffer;
}

int compare_color(void * A, void * B){
  SQUARE s1;
  char * item;
  int i;
  item  = (char *) A;
  s1 = (SQUARE) B;
  i=strcmp(item,s1->color);
  return i;
}

int compare_special(void * A, void * B){
  SQUARE s1;
  char * item;
  int i;
  item  = (char *) A;
  s1 = (SQUARE) B;
  i=strcmp(item,s1->special);
  return i;
}

int return_x(void *S){
  int number;
  SQUARE s1;
  s1 = (SQUARE) S;
  number=s1->x;
  return number;
}
