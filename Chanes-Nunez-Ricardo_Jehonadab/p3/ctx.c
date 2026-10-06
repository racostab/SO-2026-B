#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

void proceso(int id) {
  int i = 1;
  while(1) {
    for(int t=0; t<=id; t++){
      printf("\t");
    }
    printf("<%d;%d>\n", getpid(), i++);
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
        proceso(i);
        exit(1);
      default:
        //padre();
        break;
    }
  }
  return 0;
}
