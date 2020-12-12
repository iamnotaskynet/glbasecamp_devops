version = """\x1b[33m
  ____ ___  _   _ _   _ _____   _   _  ___  _     _____ ____  
 / ___/ _ \| | | | \ | |_   _| | | | |/ _ \| |   | ____/ ___| 
| |  | | | | | | |  \| | | |   | |_| | | | | |   |  _| \___ \ 
| |__| |_| | |_| | |\  | | |   |  _  | |_| | |___| |___ ___) |
 \____\___/ \___/|_| \_| |_|___|_| |_|\___/|_____|_____|____/ 
                          |_____|                             
__     __        _                    ___   _ 
\ \   / /__  ___(_) ___  _ __  _____ / _ \ / |
 \ \ / / _ \/ __| |/ _ \| '_ \|_____| | | || |
  \ V /  __/\__ \ | (_) | | | |_____| |_| || |
   \_/ \___||___/_|\___/|_| |_|      \___(_)_|
\x1b[0m"""


def show_debug(str):
    print(f'\x1b[34m \x1b[1m RESULT: \x1b[0m {str} ')

def show_error(str):
    print(f'\x1b[31m \x1b[1m ERROR: \x1b[0m {str} ')

def show_result(str):
    print(f'\x1b[32m \x1b[1m RESULT: \x1b[0m {str} ')

def show_prompt():
    return input("\x1b[34m \x1b[1m (counter_holes): \x1b[0m")

def show_version():
    print(version)

