#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main() {

    pid_t pid;
    int contador = 0;

    while (1) {

        pid = fork();

        if (pid == -1) {
            printf("Ya no se pueden crear mas procesos\n");
            printf("Maximo de procesos creados: %d\n", contador);
            break;
        }

        if (pid == 0) {
            sleep(1000);
            exit(0);
        }

        contador++;
    }

    return 0;
}
