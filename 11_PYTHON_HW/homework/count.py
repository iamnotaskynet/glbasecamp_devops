def digit_hole(digit):
    return {
        1:0, 2:0, 3:0, 4:1, 5:0, 6:1, 7:0, 8:2, 9:1, 0:1
    }.get( int(digit), "count.py: error: lines 2-4")

def count_holes(str):
    str = str.lstrip('0')
    counter = 0
    for digit in str:
        counter = counter + digit_hole(digit)
    return counter