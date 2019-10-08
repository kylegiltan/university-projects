#include "sensors.h"

int main(int argc, char **argv){
  int n = 0,*who;
  int count = 0;
  srand(time(NULL));
  if (argc < 2)
    NUM_OF_SENSORS = 5;
  else
    NUM_OF_SENSORS = atoi(argv[1]);
  pthread_t sen[NUM_OF_SENSORS];
  SENSORS = NULL;
  pthread_mutex_init(&lock, NULL);
  pthread_cond_init(&self, NULL);
  numberSensors = 0;
  cycleDone = 0;

  while (count < NUM_OF_SENSORS) {
    who = (int *)malloc(sizeof(int));
    *who = count;
    pthread_create(&(sen[count]), NULL, (void *)sensors, who);
    count++;
  }
  for(count=0;count<NUM_OF_SENSORS;count++)
    pthread_join(sen[count],NULL);
  puts("all done, bye bye");
  exit(0);
}
