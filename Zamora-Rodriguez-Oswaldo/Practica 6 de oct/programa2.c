#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

void hijo() {
    printf("Soy un hijo, PID: %d\n", getpid());}
void padre() {
    printf("Soy el padre, PID: %d\n", getpid());}
int main() {
    pid_t pid;
    for (int i = 1; i <= 3; i++) {
        pid = fork();
        switch (pid) {
            case -1:
                printf("Error\n");
                return 1;
            case 0:
                hijo();
                exit(0);
            default:
                padre();
        }
    }
    return 0;
}
