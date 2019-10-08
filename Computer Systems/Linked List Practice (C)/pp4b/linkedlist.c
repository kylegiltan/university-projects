//Kyle Tan pp4b

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

LIST change_head (LIST head, int x,int (*compare_color)(void * A, void * B),
int (*compare_special)(void * A, void * B), int(*return_x)(void *A),void (*printFunction)(void * A)){
  LIST temp;
  int i;
  int j;
  temp=head;
  while (temp != NULL){
    if (x==1){
    i=compare_color("RED",temp->item);
    if (i==0){
      break;
    }
    else{
      temp=temp->next;
    }
    if (temp==NULL){
      return head;
    }
  }
    else if (x==2){
    i=compare_color("BLUE",temp->item);
    if (i==0){
      break;
    }
    else{
      temp=temp->next;
    }
    if (temp==NULL){
      return head;
    }
  }
    else if (x==3){
    i=compare_color("ORANGE",temp->item);
    if (i==0){
      break;
    }
    else{
      temp=temp->next;
    }
    if (temp==NULL){
      return head;
    }
  }
    else if (x==4){
    i=compare_color("GREEN",temp->item);
    if (i==0){
      break;
    }
    else{
      temp=temp->next;
    }
    if (temp==NULL){
      return head;
    }
  }
  }
  j=compare_special("NONE", temp->item);
  if (j==0){return temp;}
  else{
    printFunction(temp->item);
    int k=compare_special("GOFORWARD", temp->item);
    printf("You landed on a special \n");
    if (k==0){
      int a=return_x(temp->item);
      for (int b=0;b<a;b++){
        temp=temp->next;
      }
      printf("Because of special, you are now at:\n");
    }
    int l=compare_special("GOBACK",temp->item);
    if (l==0){
      int c=return_x(temp->item);
      for (int d=0;d<c;d++){
        temp=temp->prev;
      }
      printf("Because of special, you are now at:\n");
    }
    int m=compare_special("WIN",temp->item);
    if (m==0){
      printf("Congrats, you've won \n");
    }
  }
  return temp;
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
