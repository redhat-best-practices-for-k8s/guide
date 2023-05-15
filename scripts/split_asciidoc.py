import os
import sys
import re

# TODO: adjust output AsciiDoc module section titles

input_file = sys.argv[1]

# Splits an input monolithic AsciiDoc file into child modules
# Input file must be marked up with [id="section-id"] markers which are used to generate the filenames
with open(input_file, 'r') as in_file:
    current_section_title = None
    current_section_lines = []
    for line in in_file:
        section_title_regex = r'^\[id="(.*)"\]$'
        section_title_match = re.match(section_title_regex, line.strip())
        if section_title_match:
            if current_section_title:
                section_filename = current_section_title.replace(' ', '-') + '.adoc'
                with open(section_filename, 'w') as section_file:
                    section_file.writelines(current_section_lines)
                print(f"Created file: {section_filename}")
            current_section_title = section_title_match.group(1)
            current_section_lines = []
        else:
            current_section_lines.append(line)
    section_filename = current_section_title.replace(' ', '-') + '.adoc'
    with open(section_filename, 'w') as section_file:
        section_file.writelines(current_section_lines)
