//linkedList.c  -- A GENERIC LINKED LIST

#include "linkedList.h"
#include <assert.h>

LIST makeNewListNode(void * item){
  LIST p;
  p = (LIST) malloc(sizeof(node_t));
  p->item = item;
  p->link = NULL;
  p->back = NULL;
  return p;
}
LIST traverseBackward(LIST m, int number){
  LIST p;
  int i;
  p = m;
  for (i = 0; i<number;i++){
    p = p->back;
  }
  return p;
}
LIST traverseForward(LIST m, int number){
  LIST p;
  int i;
  p = m;
  for (i = 0; i<number;i++){
    p = p->link;
  }
  return p;
}
LIST insert_rear(LIST head,LIST m){
  /*note, this will always insert at the rear of the list*/
  LIST p;
  if (head==NULL)
    return m;
  p=head;
  //now move to the rear of the list
  while(p->link != NULL){
    p=p->link;
  }
  m->back = p;
  p->link = m;
  return head;

}

void displayList(LIST m, void (*printFunction)(void * A)){
  LIST temp;
  int cnt=0;
  temp = m;
  if (temp==NULL){
    puts("NO LINKED LIST");
    return;
  }
  printf("node values are:\n");
  while (temp != NULL){
    printFunction(temp->item);
    temp=temp->link;
    cnt++;
  }
  printf("%d stocks were found\n",cnt);
}

void displayListFromBack(LIST m, void (*printFunction)(void * A)){
  LIST temp;
  int cnt=0;
  temp = m;
  if (temp==NULL){
    puts("NO LINKED LIST");
    return;
  }
  printf("node values are:\n");
  while (temp != NULL){
    printFunction(temp->item);
    temp=temp->back;
    cnt++;
  }
  printf("%d stocks were found\n",cnt);
}

LIST deleteIt(LIST head, void * itemToBeRemoved, int (*compare)(void * A, void * B), int *success){
    LIST p,q;
    p = head;
    q=p;
    //check if no linked list at all
    if(head==NULL){
      puts("empty list");
      *success=0;
      return NULL;
    }
    // there can be three cases, m->first node, m->last node
    // or  m->some other node in between
    while (p != NULL){
      if (compare(itemToBeRemoved, p->item) == 0){//new try, this is better
        if (head==p){ // first node is to be deleted
          head=head->link;
          free(p->item);
          free(p);
          *success = 1;
          return head;
        }
        else if(p->link==NULL){ //last node is to be deleted
          q->link = NULL;
          free(p->item);
          free(p);
          *success = 1;
          return head; //successful find p = address of node
        }
        else{
          q->link=p->link;
          free(p->item);
          free(p);
          *success = 1;
          return head;
        }
      }
      q=p;
      p = p->link;
    }
    *success = 0;
    return head;  //could not find the node, return old head
  }
