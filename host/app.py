'''Main system'''

import signal
import string
from threading import Thread
import json
import os
import sys
import socket
import pystray
from PIL import Image
from auth.auth import new_key
from config import key_path
from server.server import app

def get_ip_host() -> string:
    '''Get the ip of flask host'''
    s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    try:
        s.connect(('10.254.254.254',1))
        ip = s.getsockname()[0]
    except ImportError:
        ip = '127.0.0.1'
    finally:
        s.close()
    return str(ip) + ':5000'

def run_host():
    '''Open host'''
    app.run(host='0.0.0.0',port=5000)

def setup_menu():
    '''Action Bar Menu'''
    if getattr(sys, 'frozen', False):
        script_dir = sys._MEIPASS
    else:
        script_dir = os.path.dirname(os.path.abspath(__file__))

    icon_path = os.path.join(script_dir, '.', 'icon.ico')

    icon_image = Image.open(icon_path)
    def on_clicked(icon):
        os.kill(os.getpid(), signal.SIGINT)
        icon.stop()
    menu = pystray.Menu(
        pystray.MenuItem('IP: ' + get_ip_host(), lambda: None),
        pystray.MenuItem('Key: ' + str(json.load(open(key_path,'r', encoding="utf-8"))['key']),
                          lambda: None),
        pystray.MenuItem('Exit', on_clicked))

    icon = pystray.Icon('my_pc', icon_image, 'MyPC', menu=menu)

    icon.run()

if not os.path.exists(key_path):
    new_key()

flask_thread = Thread(target=run_host)
flask_thread.daemon = True
flask_thread.start()

setup_menu()
