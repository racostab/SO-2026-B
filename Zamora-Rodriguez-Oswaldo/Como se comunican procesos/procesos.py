from multiprocessing import Process
import time

def contador(i):
    while True:
        with open("contador.txt", "r+") as archivo:
            texto = archivo.read().strip()

            if not texto:
                continue

            n = int(texto)
            print(f"R{i}={n}", flush=True)

            n += 1
            archivo.seek(0)
            archivo.write(str(n))
            archivo.truncate()
            archivo.flush()

            print(f"W{i}={n}", flush=True)

        time.sleep(0.1)

if __name__ == "__main__":
    with open("contador.txt", "w") as archivo:
        archivo.write("0")

    p1 = Process(target=contador, args=(1,))
    p2 = Process(target=contador, args=(2,))

    p1.start()
    p2.start()

    try:
        p1.join()
        p2.join()
    except KeyboardInterrupt:
        p1.terminate()
        p2.terminate()
        p1.join()
        p2.join()