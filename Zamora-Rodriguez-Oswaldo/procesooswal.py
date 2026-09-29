import os

print("Anterior a ")

pid = os.fork()

if pid < 0:
    print("Error")

elif pid == 0:
    print("Soy su hijo")
    print("Mi PID es:", os.getpid())
    print("El PID de mi pa es:", os.getppid())

else:
    print("Luke soy tu PADRE")
    print("Mi PID es:", os.getpid())
    print("El PID de mi hijo es:", pid)

