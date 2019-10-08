#include "car.h"

void car() {
  puts("CAR IS READY");
  while (1) {
    waitForFullCar();
    puts("GO RIDING with passengers: ");
    goRiding();
    returnToStation();
    if (getNumPassenger() == 0)
      break;
  }
}
