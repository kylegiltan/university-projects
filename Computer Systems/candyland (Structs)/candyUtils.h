#ifndef _CANDYUTILS_H
#define _CANDYUTILS_H

#include "linkedList.h"
#include "spaces.h"
#include "player.h"

int menu();
LIST readFile(char * filename,int *boardSize, LIST *rear);
SPACE makeSpaceNode(char buffer[], int hh);
int play(LIST head, LIST players);
char *findColor(int color);
LIST moving(PLAYER player, int *m, int *done);
#endif
