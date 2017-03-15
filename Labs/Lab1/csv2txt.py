#!/usr/bin/python3
'''Transforms *.csv file to newline separated file and numerate every
with next whole number converted to float (plot purposes)'''
import sys

if __name__ == '__main__':

    if len(sys.argv) == 1:
        print("Enter filename.")
        exit()

    with open(sys.argv[1], 'r') as program:
        data = program.readline()

    data = data.replace('\n', '')
    data = data.split(',')

    with open(sys.argv[1], 'w') as program:
        for number, text in enumerate(data):
            program.write('{:f} {}\n'.format(number + 1, text))
