#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    switch (pid) {
        case -1:
            perror("Error de creación del proceso");
            exit(EXIT_FAILURE);

        case 0:
            // Código del hijo
            printf("[HIJO] Proceso hijo ejecutandose.\n");
            printf("[HIJO] Mi PID es: %d\n", getpid());
            printf("[HIJO] El PID de mi padre es: %d\n", getppid());
            break;

        default:
            // Código del padre
            printf("[PADRE] Proceso padre ejecutandose.\n");
            printf("[PADRE] Mi PID es: %d\n", getpid());
            printf("[PADRE] El PID de mi hijo recien creado es: %d\n", pid);
            wait(NULL);
            break;
    }

    return 0;
}
