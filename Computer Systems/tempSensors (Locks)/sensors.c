#include "sensors.h"
void sensors(int *t) {
  int sensorNum, cycles = 1;
  sensorNum = *t + 1;
  while (cycles <= NUM_OF_CYCLES) {
    //printf("Sensor # %d turn to go\n", sensorNum);
    addToList(sensorNum, cycles);
    //printf("Sensor # %d added to list\n", sensorNum);
  //  goOrWait1(sensorNum, cycles);
    //goOrWait(sensorNum, cycles);
    //printf("Sensor # %d here\n", sensorNum);
    lastSensorInCycle(sensorNum);
    waitForCycleToFinish(sensorNum,cycles);
    cycles++;
  }
  printf("all cycles completed %d is done\n", sensorNum);
  pthread_exit(NULL);
}
sensor_t *addToRear(sensor_t *head, sensor_t *newNode) {
  sensor_t *temp;
  if (head == NULL) {
    head = newNode;
    return head;
  }
  temp = head;
  while (temp->next != NULL) {
    temp = temp->next;
  }
  temp->next = newNode;
  return head;
}
void toString(sensor_t *head) {
  sensor_t *s;
  s = head;
  while (s != NULL) {
    printf("NODE has id: %i with temp: %i\n", s->id, s->temp);
    s = s->next;
  }
}
void addToList(int t, int cycles) {
  sensor_t *s;
  s = (sensor_t *)malloc(sizeof(sensor_t));
  s->id = t;
  s->temp = 1 + rand() % 100;
  s->next = NULL;
  pthread_mutex_lock(&lock);  //notice where the lock/unlock are placed
  numberSensors++;
  SENSORS = addToRear(SENSORS, s);
  printf("sensor # %d is inserting temp %i for cycle # %d\n", s->id, s->temp,
         cycles);
  pthread_mutex_unlock(&lock);
}
void goOrWait1(int t, int cycles) {
  sensor_t *temp;
  int sum=0;
  float avg;
  pthread_mutex_lock(&lock);
  if (numberSensors == NUM_OF_SENSORS) {
    numberSensors = 0;
    puts("current cycle has temps");
    toString(SENSORS);
    printf("Sensor # %d starts new cycle\n", t);
    temp = SENSORS;
    while (temp != NULL){
      sum = sum + SENSORS->temp;
      SENSORS = temp->next;
      free(temp);
      temp = SENSORS;
    }
    printf("the sum of the sensor readings is : %i\n",sum);
    avg = (float)sum/NUM_OF_SENSORS;
    printf("the average of the sensor readings is: %6.2f\n",avg);
    SENSORS = NULL;
    pthread_mutex_unlock(&lock);
    pthread_cond_broadcast(&self);
    return;
  }
  printf("Sensor # %d inserted now must wait until cycle ends\n", t);
  pthread_cond_wait(&self, &lock);
  pthread_mutex_unlock(&lock);
}
void goOrWait(int t, int cycles) {
  sensor_t *temp;
  int sum=0;
  float avg;
  pthread_mutex_lock(&lock);
  if (numberSensors == NUM_OF_SENSORS) {
    numberSensors = 0;
    puts("current cycle has temps");
    toString(SENSORS);
    printf("Sensor # %d starts new cycle\n", t);
    temp = SENSORS;
    temp = SENSORS;
    while (temp != NULL){
      sum = sum + SENSORS->temp;
      SENSORS = temp->next;
      free(temp);
      temp = SENSORS;
    }
    printf("the sum of the sensor readings is : %i\n",sum);
    avg = (float)sum/NUM_OF_SENSORS;
    printf("the average of the sensor readings is: %6.2f\n",avg);
    SENSORS = NULL;
    pthread_cond_broadcast(&self);
    pthread_mutex_unlock(&lock);
    return;
  }
  while (isertedInList(SENSORS,t)) {
    printf("Sensor # %d inserted now must wait until cycle ends\n", t);
    pthread_cond_wait(&self, &lock);
  }
  pthread_mutex_unlock(&lock);
}

void waitForCycleToFinish(int t, int cycles) {
  pthread_mutex_lock(&lock);
  while (isertedInList(SENSORS,t)) {
    printf("Sensor # %d inserted now must wait until cycle ends\n", t);
    pthread_cond_wait(&self, &lock);
  }
  pthread_mutex_unlock(&lock);
}

void lastSensorInCycle(int t) {
  sensor_t *temp;
  int sum=0;
  float avg;
  pthread_mutex_lock(&lock);
  if (numberSensors == NUM_OF_SENSORS) {
    numberSensors = 0;
    puts("current cycle has temps");
    toString(SENSORS);
    printf("Sensor # %d starts new cycle\n", t);
    temp = SENSORS;
    while (temp != NULL){
      sum = sum + SENSORS->temp;
      SENSORS = temp->next;
      free(temp);
      temp = SENSORS;
    }
    printf("the sum of the sensor readings is : %i\n",sum);
    avg = (float)sum/NUM_OF_SENSORS;
    printf("the average of the sensor readings is: %6.2f\n",avg);
    SENSORS = NULL;
    pthread_cond_broadcast(&self);
  }
  pthread_mutex_unlock(&lock);
}
int isertedInList(sensor_t * head, int t){
  sensor_t * temp = head;
  while (temp != NULL){
    if (temp->id == t)
      return (1);
    temp = temp->next;
  }
  return 0;
}
