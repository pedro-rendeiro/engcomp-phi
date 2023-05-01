import random
import os

filename = "entradas.txt"
n_lines = 90

if os.path.exists(filename):
    os.remove(filename)

with open(filename, "w") as file:
    for i in range(n_lines):
        line1 = random.randint(0, 15)
        if line1 != 0:
            line2 = random.randint(0, line1 - 1)
        else:
            line2 = 0
        line3 = random.randint(0, 1)
        file.write(str(line1) + "\n" + str(line2) + "\n" + str(line3) + "\n")
