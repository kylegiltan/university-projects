#include "player.h"

PLAYER newPlayer(char *name, void *position, int myTurn,
                 char *(*getName)(void *P), void *(*getPosition)(void *P),
                 int (*getMyTurn)(void *P), char *(*toString)(void *P)) {
  PLAYER p;
  p = (PLAYER)malloc(sizeof(player_t));
  p->name = (char *)malloc(sizeof(char) * 20);
  strcpy(p->name, name);
  p->position = position;
  p->myTurn = myTurn;
  p->getPosition = getPosition;
  p->getMyTurn = getMyTurn;
  p->getName = getName;
  p->toString = toString;
  return p;
}

void printPlayer(void *P) // for all spaces
{
  PLAYER p;
  p = (PLAYER)P;
  puts(p->toString(p));
}

char *getName(void *P)     // for a particular space
{
  PLAYER p;
  p = (PLAYER)P;
  return p->name;
}
void *getPosition(void *P) // for a particular space
{
  PLAYER p;
  p = (PLAYER) P;
  return p->position;
}
int getMyTurn(void *P)     // for a particular space
{
  PLAYER p;
  p = (PLAYER)P;
  return p->myTurn;
}
char *toStringPlayer(void *P)    // for a particular space
{
  PLAYER p;
  char *buffer;
  buffer = (char *)malloc(sizeof(char) * 200);
  p = (PLAYER)P;
  sprintf(buffer, "it is %s turn to play\n", p->getName(p));
  return buffer;
}
