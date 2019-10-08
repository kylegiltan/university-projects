#include "RollerCoasterUtilities.h"
#include "car.h"
#include "passenger.h"
#include <pthread.h>

int main(int argc, char *argv[]) {
  int sleeptime = 1;
  int n1, n2;
  int customerID = 0;

  int i, *x;
  if (argc != 3) {
    printf("N seats, M passengers expected!\n");
    exit(-1);
  }
  srand(time(NULL));
  n1 = atoi(argv[1]);
  n2 = atoi(argv[2]);
  pthread_t car1, passengers[n2];
  // create the roller coaster ride
  RollerCoasterInit(n1, n2);
  pthread_create(&car1, NULL, (void *)car, NULL);//create car thtread
  puts("created start");
  // add the specifid number of threads to go on the ride
  while (customerID < n2) {
    // add customers to the roller coaster park
    x = (int *)malloc(sizeof(int));
    *x = customerID;
    //create passengers
    if (pthread_create(&(passengers[customerID]), NULL, (void *)pass, x) != 0) {
      perror("pthread_create");
      exit(1);
    }
    customerID++;
    sleeptime = rand() % WAIT_TIME;
    sleep(sleeptime);// wait this amount of time before adding another rider
  }
  for (i = 0; i < n2; i++)
    pthread_join(passengers[i], NULL);
  puts("CLOSE THE PARK, EVERYBODY IS GONE");
}
