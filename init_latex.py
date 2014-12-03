#!/usr/bin/env python
import subprocess
import sys
import os
import fileinput
import shutil

if __name__ == "__main__":
    student_number = '464125'

    if len(sys.argv) != 2:
        print("Usage: init_latex.py exercise_number")
        exit()

    pwd = os.getcwd().split('/')
    
    if 'studies' not in pwd:
        print("You are not in a subfolder of 'studies'.")
        exit()

    dropbox_path = os.environ['DROPBOX']
    
    if dropbox_path == '':
        print("Environment setting $DROPBOX for Dropbox path is not set.")
        exit()

    course_name = pwd[pwd.index('studies') + 1]
    ex_number = sys.argv[1]

    subprocess.call('cp -r $DROPBOX/studies/latex-template/* .', shell=True)

    template_file = open('template.tex', 'r')
    target_filename = 'ex%s_%s.tex' % (ex_number, student_number)
    target_file = open(target_filename, 'w')

    replacements = {'#COURSE_NAME#':course_name, '#EXERCISE_NUMBER#':ex_number}

    for line in template_file:
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        target_file.write(line)
    
    template_file.close()
    target_file.close()

    os.remove('template.tex')



