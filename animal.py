import json 

def readJson():
  with open('data.json') as data_file:
    Data = json.load(data_file)
  return Data
def ask(question):
  Input = raw_input(question+'\n\t')
  return Input[0].lower()

def addQuestion(Data, correct, incorrect):
  Question = raw_input(Data['differ'] + correct + Data['fromA'] + incorrect + '\n')
  if Question.lower() == 'q':
    return Data
  Data['data'].append([Question, correct, incorrect])
  start (Data)

def Traverse(Data):
  for item in Data['data']:
    Response = ask(item[0])
    if Response == 'y':
      if ask(Data['isItA'] + item[1] + '?\t') == 'y':
        print Data['again']
        Traverse(Data)
      
    elif Response == 'n':
      if ask(Data['isItA'] + item[2] + '?\t') == 'y':
        print Data['again']
        Traverse(Data)

    elif Response.lower() == 'q':
      Traverse(Data)
  itWas = raw_input(Data['itWas'])
  Data = addQuestion(Data, itWas, item[2])


def start(Data):
  Response = ask(Data['mood'])
  if Response == 'p':
    print Data['data']
    start(Data)
  if Response == 'l':
    print Data['known']
    for item in Data['data']:
      print '\t', item[1], '\t', item[2]
    start(Data)
  elif Response == 'y':
    Traverse(Data)
  else:
    Response = ask(Data['confirmExit'])
    if Response == 'y':
      print Data['exit']
    else:
      start(Data)

def main():
  Data = readJson()
  print Data['start']
  start(Data)

main()
