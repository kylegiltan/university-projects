#include "RollerCoasterUtilities.h"
#include <unistd.h>

void RollerCoasterInit(int pChairNum, int pPassengers) {
  seats = 0;
  x = 0;
  totalSeats = 0;
  numPassengers = 0;
  ZERO = 0;
  riding = 0;
  sleeping = 1;
  totalSeats = pChairNum; // number of seats in roller coaster car
  seats = totalSeats;
  RIDE_TIME = 4;
  WAIT_TIME = 3;
  numPassengers = pPassengers; // just to end this thing,not so nice
  //pthread_mutex_init(&mutex, NULL);
  pthread_mutex_init(&ride, NULL);
  pthread_mutex_init(&seat, NULL);
  pthread_mutex_init(&wakeupcar, NULL);
  //pthread_mutex_lock(&wakeupcar);  //lock it since CAR waits on this
  pthread_cond_init(&chairs, NULL);
  pthread_cond_init(&waittoride, NULL);
  pthread_cond_init(&carWaits, NULL);
  int c;
  for (c = 0; c < totalSeats; c++){
    seatUsage[c] = (char *) malloc(sizeof(char)*10);
    strcpy(seatUsage[c],"empty");
  }
}
int getSeats() {
  return totalSeats;
}
int getNumPassenger() {
  return numPassengers;
}
void getOnBoard(int passengerID) {
  pthread_mutex_lock(&seat);
  while (seats == 0){
    pthread_cond_wait(&chairs, &seat);
  }
  //pthread_mutex_lock(&mutex);
  sprintf(seatUsage[seats - 1], "Pass ID: %i", passengerID);
  seats--;
  numPassengers--;
  if ((seats == ZERO) || (numPassengers == ZERO))  //last passenger to enter car
  {
    sleeping=0;
    pthread_cond_broadcast(&carWaits);  //see below
  }
  //pthread_mutex_unlock(&wakeupcar); //could use just this
  //pthread_mutex_unlock(&mutex);
  pthread_mutex_unlock(&seat);
  riding = 1;
  goForRide();
}
void leaveRollerCoaster() {
  // wake up waiting passengers on CV chairs
  pthread_cond_broadcast(&chairs);
}
void goForRide() {
  pthread_mutex_lock(&ride);
  while (riding){
    pthread_cond_wait(&waittoride, &ride);
  }
  pthread_mutex_unlock(&ride);
}
void waitForFullCar() {
  //pthread_mutex_lock(&wakeupcar); //could use just this
  pthread_mutex_lock(&wakeupcar);
  while (sleeping){
    puts("car sleeping");
    pthread_cond_wait(&carWaits, &wakeupcar);
  }
  sleeping = 1; //set up for next time so car can sleep
  pthread_mutex_unlock(&wakeupcar);
  //now the car can run around the track
}
void returnToStation() {
  int y;
  y = totalSeats - seats;
  seats = totalSeats; // all the seats are available
  puts("back at the station");
  for (x = 0; x < totalSeats; x++)
    strcpy(seatUsage[x],"empty");
  riding = 0;
  pthread_cond_broadcast(&waittoride);
}

void goRiding() {
  int x, y;
  y = getSeats();
  puts("SEATING ARRANGEMENT");
  puts("Seat Number Passenger ID");
  puts("----------- ------------");

  for (x = 0; x < y; x++) {
    printf(RED "SEAT[%i]         %s \n" RESET, x,seatUsage[x]);
  }
  int sleepTime = rand() % RIDE_TIME;
  sleep(sleepTime);
}
