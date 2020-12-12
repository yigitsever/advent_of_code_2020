boot_code = list()


def gameon(acc, cx, sf):
    """emulates the game until a loop or the end"""

    while cx not in sf:
        sf.add(cx)

        if cx == len(boot_code):
            print(acc)
            exit(0)

        if boot_code[cx][0] == "acc":
            acc += boot_code[cx][1]
        elif boot_code[cx][0] == "jmp":
            cx += boot_code[cx][1] - 1
        else:  # nop
            pass

        cx += 1


with open("input", "r") as file:
    for line in file:
        line = line.strip()
        oparg = line.split(" ")
        boot_code.append((oparg[0], int(oparg[1])))


cursor = 0
accumulator = 0
sofar = set()

# we are allowed to keep a 'main' branch and keep jmp/nops separate because
# task calls for only one instruction change over the whole code

while cursor not in sofar:
    sofar.add(cursor)

    if boot_code[cursor][0] == "acc":
        accumulator += boot_code[cursor][1]
    elif boot_code[cursor][0] == "jmp":
        # one for the jmp
        gameon(accumulator, cursor + boot_code[cursor][1], sofar.copy())
        # one for the nop
        gameon(accumulator, cursor + 1, sofar.copy())
        cursor += boot_code[cursor][1] - 1
    elif boot_code[cursor][0] == "nop":
        # one for the nop
        gameon(accumulator, cursor + 1, sofar.copy())
        # one for the jmp
        gameon(accumulator, cursor + boot_code[cursor][1], sofar.copy())

    cursor += 1
