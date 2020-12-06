import math

seat_ids = list()

with open("input", "r") as passes:

    for seat in passes:
        front = 0
        back = 127

        left = 0
        right = 7

        for i in seat:
            if i == "F":
                back = math.floor((front + back) / 2)
            elif i == "B":
                front = math.ceil((front + back) / 2)
            elif i == "L":
                right = math.floor((right + left) / 2)
            else:
                left = math.ceil((right + left) / 2)

        assert front == back
        assert left == right

        row = front
        col = left

        seat_id = row * 8 + col

        seat_ids.append(seat_id)

seat_ids.sort()

# answer to the first part
print(seat_ids[-1])

# answer to the second part
lent = len(seat_ids)
left = 0
right = lent - 1
cursor = 0

while right - left > 1:
    cursor = math.ceil((left + right) / 2)
    if (seat_ids[left] - left) != (seat_ids[cursor] - cursor):
        right = cursor
    elif (seat_ids[right] - right) != (seat_ids[cursor] - cursor):
        left = cursor

print(seat_ids[cursor] + 1)
