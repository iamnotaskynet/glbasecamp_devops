
# Should return Boolean value,
# Answers to question:
# Is input data valid?
def check_input(input_data):
    return __is_digits(input_data)

def __is_digits(str):
    for char in str: 
        if not char.isdigit(): return False
    return True