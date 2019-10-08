#include "candyUtils.h"
#include "linkedList.h"
#include "player.h"
#include "spaces.h"
#include <time.h>

PLAYER makePayerNode(char *name, int turn, LIST head);

int main(int argc, char *argv[]) {
  LIST head = NULL, rear;
  LIST players = NULL, temp;
  int answer;
  int boardSize, replay = 0;
  int numTimes = 0;
  PLAYER player1, player2;
  char *p1, *p2;
  p1 = (char *)malloc(sizeof(char) * 10);
  srand((unsigned)time(NULL));

  while (1) {
    answer = menu();
    switch (answer) {
    case 0: {
      head = readFile(argv[1], &boardSize, &rear);
      if (rear == NULL)
        puts("hehe");
      break;
    }
    case 1: {
      displayList(head, printIt); // remember, printIt is defined in spaces.h
      displayListFromBack(rear, printIt);
      break;
    }
    case 2: {
      if (!replay) {
        int numberOfPlayers = 1;
        while (1) {
          printf("please enter a name for player %i or STOP for no more "
                 "players:\n",
                 numberOfPlayers);
          scanf("%s", p1);
          if (strcmp(p1, "STOP") == 0) {
            break;
          } else {
            player1 = makePayerNode(p1, 1, head);
            temp = makeNewListNode(player1);
            players = insert_rear(players, temp);
            numberOfPlayers++;
          }
        }
      } else {
        temp = players;
        while (temp != NULL) {
          player2 = temp->item;
          player2->position = head;
          player2->myTurn = 1;
          temp = temp->link;
        }
      }
      play(head, players);
      replay = 1;
      puts("--------------------------------");
      break;
    }
    case 3: {
      printf("goodbye\n");
      exit(0);
    }
    }
  }
}

PLAYER makePayerNode(char *name, int turn, LIST head) {
  PLAYER P;
  P = newPlayer(name, head, turn, getName, getPosition, getMyTurn,
                toStringPlayer);
  return P;
}
