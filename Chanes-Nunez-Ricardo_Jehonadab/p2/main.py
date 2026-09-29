import os

pid = os.fork()

if pid == -1:
    print("Error de creacion")
elif pid == 0:
    print("Este es el hijo")
else:
    print("Este es el padre")
