//Kyle Tan pp4b

#ifndef __LINKEDLIST_H
#define __LINKEDLIST_H

typedef struct node{
   void * item;
   struct node * next;
   struct node * prev;
}node_t;

typedef node_t * LIST;

LIST makeNewListNode(void * item);
LIST insert_rear (LIST head, LIST m);
void traverse_forward (LIST m, void (*printFunction)(void * A));
void traverse_backward (LIST m, void (*printFunction)(void * A));
void display_node(LIST head, void * itemToBeDisplayed, int (*compare)(void * A, void * B), void (*printFunction)(void * A));
LIST change_head (LIST head, int x,int (*compare_color)(void * A, void * B),
                  int (*compare_special)(void * A, void * B),int(*return_x)(void *A),void (*printFunction)(void * A));
LIST delete_node (LIST head, void * itemToBeRemoved, int (*compare)(void * A, void * B));

#endif
