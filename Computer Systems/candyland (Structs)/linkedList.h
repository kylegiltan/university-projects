//linkedList.h
#ifndef _LINKEDLIST_H
#define _LINKEDLIST_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


typedef struct node{
  void * item;
  struct node *link;  /* use this for linked list discussion */
  struct node *back;  /* use this for linked list discussion */
}node_t;

typedef node_t * LIST;

LIST makeNewListNode(void * item);
LIST insert_rear(LIST head,LIST m);
void displayList(LIST m, void (*printFunction)(void * A));
void displayListFromBack(LIST m, void (*printFunction)(void * A));
LIST deleteIt(LIST head, void * itemToBeRemoved, int (*compare)(void * A, void * B), int *success);
LIST traverseBackward(LIST m, int number);
LIST traverseForward(LIST m, int number);

#endif
