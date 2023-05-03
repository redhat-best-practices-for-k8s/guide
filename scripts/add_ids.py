import os
import sys

input_folder = sys.argv[1]

# Loop over all files and create id based on filename
for filename in os.listdir(input_folder):

    if filename.endswith('.adoc'):
        id_attribute = f'[id="{os.path.splitext(filename)[0]}"]'

        with open(filename, 'r') as file:
            file_contents = file.readlines()
        file_contents.insert(0, id_attribute + '\n')

        with open(filename, 'w') as file:
            file.writelines(file_contents)
