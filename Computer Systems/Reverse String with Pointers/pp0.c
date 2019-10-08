#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

//there are two ways to syntactically pass an array of char

//int getLine(char line[]);
//void printLine(char line[], int size);
//void changeCap(char line[], int size);

int getLine(char *line);
void printLine(char *line, int size);
void changeCap(char *line, int size);
void reverseString(char *line, int size);

int main(){
  char m[80];
  char *a;
  int i,size=0;
  printf("Input : \t");
  size = getLine(m);
  //changeCap(m,size);
  printf("Output: \t");
  //printLine(m,size);
  reverseString(m,size);
  printf("\n");
  printf("All done\n");
  return 0;}

void reverseString(char *line, int size){
  char *a;
  int i;
  a = line;
  for (i=size-1;i>=0;i--)
    printf("%c",*(a+i));
}

//int getLine(char line[])
int getLine(char *line){
  char *a,b;
  int i,size=0;
  a = line;
  b = getchar();
  while( b != '\n' && size < 80)
  { *(a+size) = b; //remember at this point size = 0
    //printf("a = %c\n",*(a+size));
    size++;
    b = getchar();}
  return size;}

//void printLine(char line[], int size)
void printLine(char *line, int size){
char *a;
int i;
a = line;
for (i=0;i<size;i++)
  //printf("a = %c\n",*(a+i));
    printf("%c",*(a+i)); //no end of line
printf("\n");
}

//void changeCap(char line[], int size)
void changeCap(char *line, int size){
int i;
char *a;
a = line;//*a = *a - 97 + 65;
//change the first letter of first word to be Upper Case
*a = toupper(*a);
i = 1;
while (i < size){
  if (*(a+i) == ' '){ //skip this and capitalze next letter which is first letter of next word
  i++;
  //*(a+i) = *(a+i) - 97 + 65;
  *(a+i) = toupper(*(a+i));}
  i++;}
  }
