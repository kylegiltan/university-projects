#ifndef _PLAYER_H
#define _PLAYER_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct player{
  char* name;
  void* position;
  int myTurn;
  char * (* getName) (void * P);
	void * (*getPosition)(void* P);
	int (*getMyTurn)(void* P);
	char * (* toString)(void* P);
}player_t;

typedef player_t * PLAYER;

PLAYER newPlayer( char *name, void* position, int myTurn, char * (*getName) (void * P),
               void * (*getPosition)(void* P), int (*getMyTurn)(void* P), char * (*toString)(void* P));

void printPlayer(void * P);  //for all spaces

char *  getName (void * P);  //for a particular space
void *  getPosition (void* P); //for a particular space
int  getMyTurn (void* P); //for a particular space
char * toStringPlayer (void* P); //for a particular space

#endif
