'''Auth system'''
import json
import random
from config import key_path

def check(key: str) -> bool:
    '''Key checker'''
    data = json.load(open(key_path,'r', encoding="utf-8"))
    return int(key) == data['key']

def new_key() -> None:
    '''Method of create new key'''
    with open(key_path, 'w', encoding="utf-8") as json_file:
        json.dump({'key' : random.randint(10000,999999)}, json_file)
