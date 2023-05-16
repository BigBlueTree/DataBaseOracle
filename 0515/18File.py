f=open("./data/textTest.txt","r",encoding='UTF8')
print(f.read())
f.close()

import os

os.chdir('D:/storage')
print(os.getcwd())
print(os.listdir('.'))
os.mkdir('test')
print(os.listdir('.'))
os.chdir('test')
print(os.getcwd())
os.chdir('../')
print(os.getcwd())
os.rmdir('test')
print(os.listdir('.'))

os.makedirs('test2/test3')
print(os.listdir('.'))
os.chdir('test2')
print(os.listdir('.'))
os.chdir('../')
os.removedirs('test2/test3')
print(os.listdir('.'))

import os.path

print(dir(os.path))

os.chdir('D:/pythonwork')
print(os.getcwd())
print(os.listdir('.'))
print(os.path.abspath('17etc.py'))
print(os.path.dirname('pythonwork/17etc.py'))
print(os.path.exists('D:/pythonwork/17etc.py'))
print(os.path.isfile('17etc.py'))
print(os.path.isdir('17etc.py'))
print(os.path.split('d:\\test\\test.txt'))
print(os.path.join('c:\\text','text.txt'))
print(os.path.getsize('17etc.py'))
