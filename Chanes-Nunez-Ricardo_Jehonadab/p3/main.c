#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

void hijo() {
  while(1) {
    sleep(2);
    printf("Este es el hijo PID=%d\n", getpid());
  }
}

void padre() {
  while(1) {
    sleep(2);
    printf("Este es el padre PID=%d\n", getpid());
  }
}

int main() {
  for(int i=1; i<=3; i++){
    pid_t pid;
    pid = fork();
    switch(pid){
      case -1:
        printf("Error de creacion\n");
        break;
      case 0:
        hijo();
        exit(1);
      default:
        //padre();
        break;
    }
  }
  return 0;
}
