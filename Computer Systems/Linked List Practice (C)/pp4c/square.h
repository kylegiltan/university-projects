//Kyle Tan pp4c

#ifndef __SQUARE_H
#define __SQUARE_H

typedef struct square{
char * color;    // the color of the space. either red, blue, orange or green;
char * special;  // the special space. There are four values for special spaces: GOBACK, GOFORWARD
                 // WIN and NONE (i.e. nothing special)
int x;           // if you land on a special space, this is how many spaces to move.
                 //If you land on WIN, the game is over and you win.
char * (* toString)(void* S);
}square_t;

typedef square_t * SQUARE;

SQUARE new_square(char * A, char * B, int C);
void printIt(void * S);
char * toString (void* S);
int compare_color(void * A, void * B);
int compare_special(void * A, void * B);
int return_x(void *S);

#endif
