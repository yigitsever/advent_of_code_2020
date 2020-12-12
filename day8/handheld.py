boot_code = list()
with open("input", "r") as file:
    for line in file:
        line = line.strip()
        oparg = line.split(" ")
        boot_code.append((oparg[0], int(oparg[1])))


cursor = 0

accumulator = 0

sofar = set()

while cursor not in sofar:
    sofar.add(cursor)

    if boot_code[cursor][0] == "acc":
        accumulator += boot_code[cursor][1]
    elif boot_code[cursor][0] == "jmp":
        cursor += boot_code[cursor][1] - 1
    else:
        pass

    cursor += 1

print(accumulator)
