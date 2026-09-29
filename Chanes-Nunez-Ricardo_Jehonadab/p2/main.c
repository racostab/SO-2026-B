#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  pid_t pid;
  pid = fork();
  switch(pid){
    case -1:
      printf("Error de creacion\n");
      break;
    case 0:
      printf("Este es el hijo\n");
      break;
    default:
      printf("Este es el padre\n");
      break;
  }
  return 0;
}
