#!/usr/bin/python3

import sys
import json

TEXT_FILE_PATH = './text.json'
messages = None

def traverse(parent, path):
    node = parent[path]

    if (isinstance(node, str)):
        if not ask_yes_no_question('{}{}'.format(messages.get('isItA'), node)):
            animal = input(messages.get('itWas'))
            question = input('{}{}{}{}: '.format(
                messages.get('differ'),
                animal,
                messages.get('fromA'),
                node
            ))

            parent[path] = [question, animal, node]

        print(messages.get('again'))
        return
    else:
        if ask_yes_no_question(node[0]):
            traverse(node, 1)
        else:
            traverse(node, 2)

def show_known_animals():
    nodes_to_visit = [messages.get('data')]
    result = set()

    while nodes_to_visit:
        node = nodes_to_visit.pop(0)

        if isinstance(node[1], str):
            result.add(node[1])
        else:
            nodes_to_visit.append(node[1])

        if isinstance(node[2], str):
            result.add(node[2])
        else:
            nodes_to_visit.append(node[2])

    print(messages.get('known'), ', '.join(result))

def exit_game():
    print(messages.get('exit'))
    sys.exit()

def ask_yes_no_question(question):
    while True:
      answer = input('{} ? '.format(question)).upper()
      if answer in ['Y', 'YES', 'TRUE']:
        return True
      elif answer in ['N', 'NO', 'FALSE']:
        return False

def handle_top_command(answer):
    if answer in ['L', 'LIST']:
        show_known_animals()
    elif answer in ['Y', 'YES']:
        traverse(messages, 'data')
    elif answer in ['N', 'NO']:
        exit_game()

def start():
    print(messages.get('start'))

    while True:
        answer = input(messages.get('mood'))
        handle_top_command(answer.upper())

def load_text():
    global messages
    with open(TEXT_FILE_PATH) as f:
        messages = json.load(f);

def main():
    load_text()
    start()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        sys.exit()
