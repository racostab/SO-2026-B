import os
import sys

try:
    pid = os.fork()

except OSError as e:
    #Error de creación
    print(f"Error al crear el proceso: {e}")
    sys.exit(1)

if pid == 0:
    #Codigo del hijo
    print("[HIJO] Proceso hijo ejecutándose.")
    print(f"[HIJO] Mi PID es: {os.getpid()}")
    print(f"[HIJO] El PID de mi padre es: {os.getppid()}")

else:
    #Codigo del padre
    print("[PADRE] Proceso padre ejecutándose.")
    print(f"[PADRE] Mi PID es: {os.getpid()}")
    print(f"[PADRE] El PID de mi hijo recién creado es: {pid}")

    os.wait()
