#include "passenger.h"

void pass(int * id)
{
    int *customer;
    customer = id;
    printf("ENTERING PARK: Customer [%i] entering park.\n", *customer);
    getOnBoard(*customer);  //in RollerCoasterUtilities
    printf("DONE RIDING: Customer [%i] done riding.\n", *customer);
    leaveRollerCoaster(); //in RollerCoasterUtilities
    printf("LEAVING PARK: Customer [%i] leaving park.\n", *customer);
}
