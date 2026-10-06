#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

void hijo() {
  while(1) {
    sleep(1000);
  }
}

int main() {
  int i = 1;
  while(1){
    pid_t pid;
    pid = fork();
    switch(pid){
      case -1:
        printf("Error de creacion. Max processes reached: %d\n", i - 1);
        exit(1);
      case 0:
        hijo();
      default:
        printf("PID: %d ;;; %d\n", getpid(), i);
        i++;
        break;
    }
  }
  return 0;
}
