import os
import sys
import re

input_folder = sys.argv[1]
prefix = "k8s-best-practices-"

# Loop over all files and create ids
for filename in os.listdir(input_folder):

    if filename.endswith('.adoc'):
        with open(os.path.join(input_folder, filename), 'r+') as file:
            # Read the entire file into memory
            content = file.read()
            # Create IDs
            matches = re.findall('(\={1,6} )(.*)', content)
            for match in matches:
                level, title = match
                # Generate the ID based on the prefix + title
                generated_id = prefix + title.lower().replace(' ', '-')
                generated_id = generated_id.replace(')', '')
                generated_id = generated_id.replace('(', '')
                generated_id = generated_id.replace('{', '')
                generated_id = generated_id.replace('}', '')
                generated_id = generated_id.replace('_', '-')
                generated_id = generated_id.replace('/', '-')
                # Insert the id attribute before the heading
                id_attribute = '[id="{}"]'.format(generated_id)
                heading_with_id = '{}\n{}{}'.format(id_attribute, level, title)
                # Use regex to replace all occurrences of the existing heading
                pattern = re.escape('{}{}'.format(level, title))
                content = re.sub(pattern, heading_with_id, content, 1)

            # Write the modified content back to the file
            file.seek(0)
            file.write(content)
            file.truncate()
