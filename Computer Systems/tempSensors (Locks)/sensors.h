#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#define NUM_OF_CYCLES 10
//#define NUM_OF_SENSORS 5

pthread_mutex_t lock;  /* mutex ensuring exclusive access to buffer */
pthread_cond_t self;

typedef struct sensor{
  int id;
  int temp;
  struct sensor *next;
}sensor_t;

int numberSensors ;
int cycleDone ;
int NUM_OF_SENSORS;
sensor_t *SENSORS;

void sensors(int *t);
void addToList(int t,int cycles);
void lastSensorInCycle(int t) ;
void waitForCycleToFinish(int t, int cycles);
void goOrWait(int t, int cycles);
sensor_t * addToRear(sensor_t * head, sensor_t *newNode);
void toString(sensor_t * s);
int isertedInList(sensor_t * head, int t);
void goOrWait1(int t, int cycles) ;
