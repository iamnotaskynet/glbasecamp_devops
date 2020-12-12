
import show
import check
import count

result = -1


while True:
    user_input = show.show_prompt()
    if user_input == 'version':
        show.show_version()
    elif user_input == 'exit':
        show.show_debug("GOOD BYE!")
        exit()
    elif not check.check_input(user_input):
        show.show_error(f'Your input \'{user_input}\' is wrong!')
    else:
        result = count.count_holes(user_input)
        show.show_result(result)