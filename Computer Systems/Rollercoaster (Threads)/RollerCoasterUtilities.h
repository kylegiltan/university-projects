#ifndef _RCU_H
#define _RCU_H
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"

int seats;
int x;
int totalSeats;
int numPassengers;
char * seatUsage[100];
pthread_mutex_t mutex;
pthread_mutex_t seat;
pthread_mutex_t ride;
pthread_mutex_t wakeupcar;
pthread_cond_t chairs;
pthread_cond_t waittoride;
pthread_cond_t carWaits;
int ZERO, riding,sleeping;
int  RIDE_TIME;
int WAIT_TIME;

void RollerCoasterInit(int pChairNum, int pPassengers) ;
int getSeats() ;
int getNumPassenger() ;
void goRiding();
void getOnBoard(int passengerID) ;
void leaveRollerCoaster();
void goForRide();
void waitForFullCar();
void returnToStation();
#endif
