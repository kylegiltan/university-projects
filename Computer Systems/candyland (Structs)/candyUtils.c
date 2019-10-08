#include "candyUtils.h"
#include <time.h>

int menu() {
  int a;
  char carraigeReturn;
  puts("welcome to CANDYLAND generics");
  puts("please choose from the following choices");
  puts("0. Read from a file");
  puts("1. Print Board");
  puts("2. Play Game");
  puts("3. Quit and leave");
  scanf("%d%c", &a, &carraigeReturn);
  return a;
}

LIST readFile(char *filename, int *boardSize, LIST *rear) {
  FILE *inf = fopen(filename, "r"); // opens a file for READING
  // FILE *inf = fopen("board2.txt", "r"); // opens a file for READING
  char buffer[80];
  SPACE S;
  LIST head, l;
  int count = 0, answer;
  head = NULL;

  if (inf == NULL) {
    puts("no file you idiot");
    exit(1);
  }

  while (1) {
    fgets(buffer, 80, inf); // reads in at most 80 char from a line
    if (feof(inf))          // this checks to see if the special EOF was read
      break; // if so, break out of while and continue with your main
    count++;
    S = makeSpaceNode(buffer, count);
    l = makeNewListNode(S);
    head = insert_rear(head, l); // now you need to insert the stock into a node
                                 // of the generic link list
  }

  fclose(inf); // Closes a file.
  printf("%d new records were read\n", count);
  *boardSize = count;
  *rear = l;
  return head;
}

SPACE makeSpaceNode(char buffer[], int hh) {
  SPACE S;
  char *color, *special, *moves; // need these since you read data in as a char
                                 // string then convert to float or int
  int number;

  color = (char *)malloc(sizeof(char) * 20);
  special = (char *)malloc(sizeof(char) * 20);
  moves = (char *)malloc(sizeof(char) * 20);

  color = strtok(buffer, " "); // get first token up to space
  special = strtok(NULL, " "); // get next token up to space
  moves = strtok(NULL, "\n");  // get next token up to space

  number = atof(moves);
  S = newSpace(color, special, number, hh, getColor, getSpecial, getNumber,
               toString);
  return S;
}

int play(LIST head, LIST players) {
  int numMoves = 1, numMoves2 = 1, currIndex = 0, color, temp, i = 1, done = 0;
  SPACE board;
  LIST participants;
  PLAYER p1;
  PLAYER playerPerson;
  if (head == NULL) {
    puts("no board");
    exit(1);
  }
  if (players == NULL) {
    puts("no players");
    exit(1);
  }
  while (1) {
    participants = players;
    while (participants != NULL) {
      p1 = participants->item;
      printf("%s", p1->toString(p1));
      p1->position = moving(p1, &p1->myTurn, &done);
      if (done) {
        printf("Yippee, %s just won!!\n", p1->getName(p1));
        return numMoves;
      }
      participants = participants->link;
      puts("---------------------------------------------------");
    }
  }
}

LIST moving(PLAYER player, int *m, int *done) {
  int numMoves = *m, color;
  SPACE board;
  LIST p, c;
  // c = playerSpace;
  c = player->position;
  printf("MOVE NUMBER %d\n", numMoves);
  color = rand() % 4;
  printf("The random choice was: %s\n", findColor(color));
  if (numMoves == 1)
    p = c;
  else
    p = c->link;
  while (p != NULL) {
    board = (SPACE)p->item;
    if (strcmp(board->color, findColor(color)) == 0) {
      break;
    }
    p = p->link;
  }

  if (p != NULL) {
    printf("landed on: ");
    board = (SPACE)p->item;
    printIt(board);
    if (strcmp(board->special, "NONE") == 0) {
      puts("nothing to do");
      c = p;
      p = c->link;
    } else if (strcmp(board->special, "GOBACK") == 0) {
      puts("GOBACK");
      c = p;
      c = traverseBackward(c, board->x);
      printf("now at: ");
      board = c->item;
      printIt(board);
      p = c->link;
      if (strcmp(board->special, "WIN") == 0) {
        printf("WIN WIN WIN, with %i moves\n", numMoves);
        *done = 1;
        return NULL;
      }
    } else if (strcmp(board->special, "GOFORWARD") == 0) {
      puts("GOFORWARD");
      c = p;
      c = traverseForward(c, board->x);
      printf("now at: ");
      board = c->item;
      printIt(board);
      p = c->link;
      if (strcmp(board->special, "WIN") == 0) {
        printf("WIN WIN WIN, with %i moves\n", numMoves);
        *done = 1;
        return NULL;
      }
    } else if (strcmp(board->special, "WIN") == 0) {
      *done = 1;
      printf("WIN WIN WIN, with %i moves\n", numMoves);
      return NULL;
    }
    numMoves++;
    *m = numMoves;
    return c;
  } else {
    printf("can not find it, remain on ");
    p = c->link;
    board = c->item;
    printIt(board);
    numMoves++;
    *m = numMoves;
    return c;
  }
}

char *findColor(int color) {
  char *c;
  if (color == 0)
    c = "RED";
  if (color == 1)
    c = "BLUE";
  if (color == 2)
    c = "ORANGE";
  if (color == 3)
    c = "GREEN";
  return c;
}
