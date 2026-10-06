#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main() {

    pid_t pid;

    pid = fork();

    if (pid < 0) {
        printf("Error\n");
    }

    if (pid == 0) {
        printf("Soy el hijo, PID: %d\n", getpid());
    }
    else {
        printf("Soy el padre, PID: %d\n", getpid());
    }

    return 0;
}
