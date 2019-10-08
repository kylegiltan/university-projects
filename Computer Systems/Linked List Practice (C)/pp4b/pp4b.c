//Kyle Tan pp4b

#include "linkedlist.h"
#include "square.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

SQUARE makeSquareNode(char buffer[]);
LIST readFile();
int randomNumber(int upperBound);
void corresponding_color(int i);

int main(int argc, char *argv[]) {
  LIST head, player;
  int rn;
  int moves=0;
  int game=1;
  int average=0;
  head = readFile();
  printf("BOARD:\n");
  traverse_forward(head, printIt);
  printf("\n");
  while (game<6){
  printf("Game # %d\n",game);
  player=head;
  rn = randomNumber(4);
  printf("You got: %d\n",rn);
  corresponding_color(rn);
  player=change_head(player,rn,compare_color,compare_special,return_x,printIt);
  moves=1;
  printIt(player->item);
  while (player->next != NULL){
    rn = randomNumber(4);
    printf("You got: %d\n",rn);
    corresponding_color(rn);
    player=change_head(player,rn,compare_color,compare_special,return_x,printIt);
    printIt(player->item);
    moves++;
  }
  printf("It took %d moves to win\n", moves);
  game++;
  average=average+moves;
  moves=0;
  printf("\n");}
  average=average/5;
  printf("After running the game 5 times, the average number of moves is %d\n", average);
}

LIST readFile(){
  FILE *inf = fopen("board.txt", "r");
  char buffer[80];
  SQUARE S;
  LIST head, l;
  int count = 0, answer;
  head = NULL;

	if (inf == NULL){
		puts("no file you idiot");
		exit(1);
	}

  while (1) {
	  fgets(buffer, 80, inf);
	  if (feof(inf))
		  break;

    S = makeSquareNode(buffer);
 	  count++;
    l = makeNewListNode(S);
    head =  insert_rear(head,l);
  }

  fclose(inf);
  printf("%d new records were read\n", count);
  return head;
}

SQUARE makeSquareNode(char buffer[]){
  SQUARE S;
  char *color, *special, *x;
  int X;

  color = (char *) malloc(sizeof(char)*20);
  special = (char *) malloc(sizeof(char)*20);
  x = (char *) malloc(sizeof(char)*20);

  color = strtok(buffer, " ");
  special = strtok(NULL, " ");
  x = strtok(NULL, " ");


  X = atof(x);
  S = new_square(color, special, X);
  return S;
}

int randomNumber(int upperBound){
    int j;
    j=1+(rand() % upperBound);
    return j;
}

void corresponding_color(int i){
  if (i==1){
    printf("Move to red space\n");
  }
  else if (i==2){
    printf("Move to blue space\n");
  }
  else if (i==3){
    printf("Move to orange space\n");
  }
  else if (i==4){
    printf("Move to green space\n");
  }
}

/*
NEED TO FIX:
when you get to the last of the color
when you get to the green at the end
then when it all works, i have to change checking for specials and how much to move
*/
