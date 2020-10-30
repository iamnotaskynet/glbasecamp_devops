import time
from pynput.keyboard import Key, Controller

keyboard = Controller()


def press_fn(in_str):
    for char in in_str:
        keyboard.press(char)
        keyboard.release(char)
        time.sleep(0.2)
    keyboard.press(Key.enter)
    keyboard.release(Key.enter)

press_fn("ls -a")

press_fn("hostname")
