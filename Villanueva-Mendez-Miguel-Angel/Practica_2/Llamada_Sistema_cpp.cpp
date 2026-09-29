#include <iostream>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    switch (pid) {
        case -1:
            std::cerr << "Error de creación\n";
            return 1;

        case 0:
            // Código del hijo
            std::cout << "[HIJO] Proceso hijo ejecutándose.\n";
            std::cout << "[HIJO] Mi PID es: " << getpid() << "\n";
            std::cout << "[HIJO] El PID de mi padre es: " << getppid() << "\n";
            break;

        default:
            // Código del padre
            std::cout << "[PADRE] Proceso padre ejecutándose.\n";
            std::cout << "[PADRE] Mi PID es: " << getpid() << "\n";
            std::cout << "[PADRE] El PID de mi hijo recién creado es: " << pid << "\n";
            wait(NULL);
            break;
    }

    return 0;
}
