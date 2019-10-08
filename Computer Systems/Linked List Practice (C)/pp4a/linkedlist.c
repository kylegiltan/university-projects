//Kyle Tan pp4a

#include "linkedlist.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

LIST makeNewListNode(void * item){
  LIST p;
  p = (LIST) malloc(sizeof(node_t));
  p->item = item;
  p->next = NULL;
  p->prev = NULL;
  return p;
}

LIST insert_rear (LIST head, LIST m){
  LIST p;
  if (head==NULL){
    return m;
  }
  p=head;
  while(p->next != NULL){
    p=p->next;
  }
  p->next = m;
  m->prev = p;
  return head;
}

void traverse_forward (LIST m, void (*printFunction)(void * A)){
  LIST temp;
  temp = m;
  while (temp != NULL){
    printFunction(temp->item);
    temp=temp->next;
  }
}

void traverse_backward (LIST m, void (*printFunction)(void * A)){
  LIST temp;
  temp = m;
  while (temp->next!= NULL){
    temp=temp->next;
  }
  while (temp!= NULL){
    printFunction(temp->item);
    temp=temp->prev;
  }
}

void display_node (LIST head, void * itemToBeDisplayed,int (*compare)(void * A, void * B),void (*printFunction)(void * A)){
  LIST temp;
  int i;
  temp=head;
  while (temp != NULL){
    i=compare(itemToBeDisplayed,temp->item);
    if (i==0){
      printFunction(temp->item);
      break;
    }
    else{
      temp=temp->next;
    }
  }
  if (temp==NULL){
    printf("Item to be displayed not found\n");
  }
}

LIST delete_node (LIST head, void * itemToBeRemoved, int (*compare)(void * A, void * B)){
  LIST temp;
  LIST before;
  LIST after;
  int i;
  temp=head;
  while (temp != NULL){
    i=compare(itemToBeRemoved, temp->item);
    if (i==0){
      if (temp->prev==NULL){
        head=temp->next;
        temp->next->prev=NULL;
        temp->next=NULL;
        break;
      }
      else if (temp->next==NULL){
        temp->prev->next=NULL;
        temp->prev=NULL;
        break;
      }
      else{
      temp->prev->next=temp-> next;
      temp->next->prev = temp-> prev;
      temp->next=NULL;
      temp->prev=NULL;
      break;
    }
    }
    else{
      temp=temp->next;
    }
  }
  if (temp==NULL){
    printf("Item to be deleted not found\n");
  }
  return head;
}
