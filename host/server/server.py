'''Host Server'''

import subprocess
import json
from auth.auth import check
from config import user_data_path
from flask import Flask, request

app = Flask(__name__)

@app.route("/<key>")

def validate_connection(key: str):
    '''Validate connection for client'''
    return str(check(key))

@app.route("/start/<application>/<key>")

def main(application: str, key: str) -> None:
    '''Open Applications with start'''
    if check(key):
        try:
            result = subprocess.run('start ' + application, shell=True,
                                    capture_output=True, text=True,check=True)
            print(result.stdout)
            return f'{application} open'

        except subprocess.CalledProcessError as e:
            print(f'Error:{e}')
            return f'Error:{e}'
    else:
        return 'invalid key'


@app.route("/get_user_data/<key>")

def get_user_data(key: str):
    '''Send of user data on client'''
    if check(key):
        return json.load(open(user_data_path, 'r', encoding='utf-8'))

@app.route("/set_user_data/<key>", methods = ['POST'])

def set_user_data(key: str):
    '''Get user data the client'''
    if check(key):
        with open(user_data_path, 'w', encoding='utf-8') as json_file:
            json.dump(request.json,json_file)
        return str('save in ' + user_data_path)
