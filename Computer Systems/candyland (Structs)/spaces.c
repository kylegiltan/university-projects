/*--------------------------------------------------------------------*/
/* spaces.c                                                            */
/*--------------------------------------------------------------------*/
#include "spaces.h"
#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"

SPACE newSpace(char *color, char *special, int number, int line,
               char *(*getColor)(void *S), char *(*getSpecial)(void *S),
               int (*getNumber)(void *S), char *(*toString)(void *S)) {
  SPACE s;
  s = (SPACE)malloc(sizeof(space_t));
  s->color = (char *)malloc(sizeof(char) * 20);
  strcpy(s->color, color);
  s->special = (char *)malloc(sizeof(char) * 20);
  strcpy(s->special, special);
  s->x = number;
  s->line = line;
  s->getSpecial = getSpecial;
  s->getNumber = getNumber;
  s->getColor = getColor;
  s->toString = toString;
  return s;
}

void printIt(void *S) {
  SPACE s;
  s = (SPACE)S;
  puts(s->toString(s));
}

int compareColor(void *A, void *B) {
  SPACE s1;
  char *item;
  item = (char *)A;
  s1 = (SPACE)B;
  return (strcmp(item, s1->color));
}
int compareSpecial(void *A, void *B) {
  SPACE s1;
  char *item;
  item = (char *)A;
  s1 = (SPACE)B;
  return (strcmp(item, s1->special));
}

char *getColor(void *S) {
  SPACE s;
  s = (SPACE)S;
  return s->color;
}
char *getSpecial(void *S) {
  SPACE s;
  s = (SPACE)S;
  return (s->special);
}
int getNumber(void *S) {
  SPACE s;
  s = (SPACE)S;
  return (s->x);
}
char *toString(void *S) {
  char *buffer;
  SPACE s;
  s = (SPACE)S;
  buffer = (char *)malloc(sizeof(char) * 200);

  if (strcmp(s->getColor(s),"RED")==0){
    sprintf(buffer, "Space: %i COLOR: " RED "%s " RESET "SPECIAL: %s NUMBER: %i", s->line, s->getColor(s),
            s->getSpecial(s), s->getNumber(s));
  }
  else if (strcmp(s->getColor(s),"GREEN")==0){
    sprintf(buffer, "Space: %i COLOR: " GRN "%s " RESET "SPECIAL: %s NUMBER: %i", s->line, s->getColor(s),
            s->getSpecial(s), s->getNumber(s));
  }
  else if (strcmp(s->getColor(s),"BLUE")==0){
    sprintf(buffer, "Space: %i COLOR: " BLU "%s " RESET "SPECIAL: %s NUMBER: %i", s->line, s->getColor(s),
            s->getSpecial(s), s->getNumber(s));
  }
  else if (strcmp(s->getColor(s),"ORANGE")==0){
    sprintf(buffer, "Space: %i COLOR: " YEL "%s " RESET "SPECIAL: %s NUMBER: %i", s->line, s->getColor(s),
            s->getSpecial(s), s->getNumber(s));
  }
  return buffer;
}
