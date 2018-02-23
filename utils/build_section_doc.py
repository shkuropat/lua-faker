#!/usr/bin/env python

from __future__ import print_function
import sys
import os
import re
import subprocess
from pprint import pprint

BASE_NAME = 'Faker'
MODULE_NAME_MAPS = {'id_number' : 'IDNumber' }
TEMPLATE_FILE_NAME = 'template.lua'
TMP_FILE_PATH = '_tmp.lua'
DOCKER_IMAGE = 'tarantool/tarantool:1.7'
MODULE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def print_err(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def fetch_defined_methods(text):
    pattern = re.compile(r'^(?:M\.)(\w[\w_]+)\s?=\s?function\(.*?\)', flags=re.MULTILINE)
    return [prepare_method(method) for method in re.findall(pattern, text)]

def fetch_example_code(data):
    pattern = re.compile(r'^((?:Faker\.[\w_]+\:)?[\w_]+)\(.*?\)', flags=re.MULTILINE)
    return [prepare_method(method) for method in re.findall(pattern, data)]

def fetch_method_name(data):
    methods = data.translate(None, '\'"').split(',')
    methods = filter(bool, methods)
    return [prepare_method(method) for method in methods]

def match_method(match):
    return add_print_doc(prepare_method(match.group()))

def prepare_method(method):
    method = method.strip()
    if method.find(BASE_NAME) == -1 :
        method = BASE_NAME + '.' + module_name + ':' + method
    if method.find('(') == -1:
        method += '()'
    return method

def add_print_doc(method):
    return 'print_doc(\'' + method + '\')\n'

def parse_examples_block(input_block):
    examples = re.sub(r'(\')', '\\\'', input_block, flags=re.MULTILINE)
    examples = re.sub(r'^((?:Faker\.[\w_]+\:)?[\w_]+)\(.*?\)', match_method, examples, flags=re.MULTILINE)
    return re.sub(r'(--.*?)$', 'print(\'' + r"\1" + '\')', examples, flags=re.MULTILINE)

def run_docker(executed_code):
    tmp_file = os.path.join(MODULE_DIR, TMP_FILE_PATH)
    f = open(tmp_file, 'w')
    f.write(executed_code)
    f.close()
    docker_cmd = "docker run --rm --name mytarantool -v {}:/opt/tarantool {} tarantool /opt/tarantool/{}"
    docker_cmd = docker_cmd.format(MODULE_DIR, DOCKER_IMAGE, TMP_FILE_PATH)
    result = subprocess.check_output(docker_cmd, shell=True)
    os.unlink(tmp_file)
    return result


input_file = sys.argv[1]

try:
    file = open(os.path.join(sys.path[0], TEMPLATE_FILE_NAME), 'r')
    template = file.read()
    file.close()
except:
    print_err("can't read template file", os.path.join(__location__, TEMPLATE_FILE_NAME))
    sys.exit(1)

try:
    file = open(input_file, 'r')
    text = file.read()
    file.close()
except:
    print_err("can't read module file", input_file)
    sys.exit(1)

m = re.search('__prefix\s?=\s?(.*?)[,$]', text, flags=re.MULTILINE)
if not m:
    print_err('module name not found')
    sys.exit(1)

module_name = m.group(1).translate(None, '\'"')
if module_name in MODULE_NAME_MAPS:
    module_name = MODULE_NAME_MAPS[module_name]
else:
    module_name = module_name.title().replace('_', '')


lines = []
executed_code = template.replace('--[[module_name]]', module_name)

# excludes section
# sometimes in localization used plural instead of single form
# for example Faker.Business module
# this fixing by _alias_method usage
excludes = []
m = re.search('--\[=+\[excludes(.*?)\]=+\]', text, flags=re.DOTALL)
if m:
    excludes = fetch_example_code(m.group(1))

# all method from example shoul be excluded from auto build
tail = ''
# universal examples
m = re.search('--\[=+\[examples(.*?)\]=+\]', text, flags=re.DOTALL)
if m:
    tail += parse_examples_block(m.group(1))
    excludes += fetch_example_code(m.group(1))

# locale depended examples
pattern = re.compile(r'--\[=+\[examples\(([\w-]+)\)(.*?)\]=+\]', flags=re.DOTALL)
for (locale, data) in re.findall(pattern, text):
    tail += ("print('-- " + locale + " only')")
    tail += ("Faker.set_locale('" + locale + "')")
    tail += parse_examples_block(data)
    excludes += fetch_example_code(text)


# simple parse methods
pattern = re.compile(r'__(?:parse|fetched)_methods\s?=\s?\{(.*?)\}', flags=re.DOTALL)
for (data) in re.findall(pattern, text):
    for method in fetch_method_name(data):
        lines.append(method)

lines = lines + fetch_defined_methods(text)

# aliases
aliases = {}
m = re.search(r'__alias_method\s?=\s?\{(.*?)\}', text, flags=re.DOTALL)
if m:
    pattern = re.compile(r'\[\'(\w+)\'\]\s?=\s?\'(\w+)\'\,?', flags=re.MULTILINE)
    for (alias_method, original_method) in (re.findall(pattern, m.group(1))):
        for idx, method in enumerate(lines):
            if method.find(original_method) > -1 :
                lines = lines[:idx] + [prepare_method(alias_method)] + lines[idx:]
                break


code = '\n'.join(add_print_doc(x) for x in lines if x not in excludes)

code += tail
prev_line = None
lines = []
r = re.compile(r'print_doc\((\'Faker\.[\w_]+\:[\w_]+)\(.*?\)\'\)')
for line in code.splitlines():
    prev_method = None
    current_method = None
    if line == '':
        continue
    if prev_line :
        res = r.match(prev_line)
        if res:
            prev_method = res.group(1)

        res = r.match(line)
        if res:
            current_method = res.group(1)

        if (prev_method and prev_method != current_method) or (line.find('--')>-1 and prev_line.find('--') == -1 ):
            lines.append('print()')

    lines.append(line)
    prev_line = line

code = '\n'.join(lines)

m = re.search('--\[=+\[description(.*?)\]=+\]', text, flags=re.DOTALL)
if m:
    executed_code = executed_code.replace('--[[description]]', 'local desc = [==[' + m.group(1) + ']==]')

executed_code = executed_code.replace('--[[code]]', code)
result = run_docker(executed_code)



print(result)
