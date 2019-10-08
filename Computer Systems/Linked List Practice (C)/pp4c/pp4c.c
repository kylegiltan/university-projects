//Kyle Tan pp4c

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
  LIST head1, head2, player1, player2;
  int rn1, rn2;
  head1 = readFile();
  head2=readFile();
  printf("BOARD:\n");
  traverse_forward(head1, printIt);
  printf("\n");
  player1=head1;
  player2=head2;
  printf("Player 1:\n");
  rn1 = randomNumber(4);
  printf("You got: %d\n",rn1);
  corresponding_color(rn1);
  player1=change_head(player1,rn1,compare_color,compare_special,return_x,printIt);
  printIt(player1->item);
  printf("Player 2:\n");
  rn2 = randomNumber(4);
  printf("You got: %d\n",rn2);
  corresponding_color(rn2);
  player2=change_head(player2,rn2,compare_color,compare_special,return_x,printIt);
  printIt(player2->item);
  while (1){
    printf("Player 1:\n");
    rn1 = randomNumber(4);
    printf("You got: %d\n",rn1);
    corresponding_color(rn1);
    player1=change_head(player1,rn1,compare_color,compare_special,return_x,printIt);
    printIt(player1->item);
    if (player1->next == NULL){
      printf("Congrats player 1\n");
      break;
    }
    printf("Player 2:\n");
    rn2 = randomNumber(4);
    printf("You got: %d\n",rn2);
    corresponding_color(rn2);
    player2=change_head(player2,rn2,compare_color,compare_special,return_x,printIt);
    printIt(player2->item);
    if (player2->next == NULL){
      printf("Congrats player 2\n");
      break;
    }
  }
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
