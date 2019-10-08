//Kyle Tan pp4a

#include "linkedlist.h"
#include "id.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

int menu();
STUDENT makeStudentNode(char buffer[]);
LIST readFile();

int main(int argc, char *argv[]) {
  LIST head;
  int answer;
  char *name_display,*name_delete;

  while(1){
    answer = menu();
    switch (answer){
      case 0:
      {
        head = readFile();
        break;
      }
      case 1:{
        traverse_forward(head, printIt);
        break;
      }
      case 2:{
        traverse_backward(head, printIt);
        break;
      }
      case 3:{
        name_display = (char *) malloc(sizeof(char) * 20);
        printf("Enter name of student you want to view\n");
        scanf("%s",name_display);
        display_node(head,name_display,compare,printIt);
        break;
      }
      case 4:{
        name_delete =(char *) malloc(sizeof(char) * 20);
        printf("Enter name of student you want to delete\n");
        scanf("%s",name_delete);
        head=delete_node(head, name_delete, compare);
        printf("new list with deletion:\n");
        traverse_forward (head, printIt);
        break;
      }
      case 5:{
        printf("goodbye\n");
        exit(0);
      }
    }
  }
}

LIST readFile(){
  FILE *inf = fopen("Students.txt", "r");
  char buffer[80];
  STUDENT S;
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

    S = makeStudentNode(buffer);
 	  count++;
    l = makeNewListNode(S);
    head =  insert_rear(head,l);
  }

  fclose(inf);
  printf("%d new records were read\n", count);
  return head;
}



STUDENT makeStudentNode(char buffer[]){
  STUDENT S;
  char *name, *id;
  int ID;

  name = (char *) malloc(sizeof(char)*20);
  id = (char *) malloc(sizeof(char)*20);

  name = strtok(buffer, " ");//get first token up to space
  id = strtok(NULL, " ");  //get next token up to space
  ID = atof(id);
  S = new_student(name, ID);
  return S;
}

int menu(){
  int a;
  char carraigeReturn;
  puts("Welcome to student fun generics");
  puts("please choose from the following choices");
  puts("0. Read from a file");
  puts("1. Traverse forward");
  puts("2. Traverse backward");
  puts("3. Search for student");
  puts("4. Delete a student");
  puts("5. Quit and leave");
  scanf("%d%c", &a, &carraigeReturn);
  return	a;
}
