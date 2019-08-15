#!/usr/bin/env python

import nbformat
import sys
import os
import codecs
from typing import Sequence, NoReturn, Any

USAGE = f"{os.path.basename(sys.argv[0])} input_notebook output_notebook [encoding]"

def die(msg: str) -> NoReturn:
    print(msg, file=sys.stderr)
    sys.exit(1)


def is_answer_cell(source_lines: Sequence[str]) -> bool:
    def line_is_answer(line: str) -> bool:
        return line.lower().strip().startswith('// answer')

    for line in source_lines:
        if line_is_answer(line):
            return True

    return False


def check_notebook_extension(path: str) -> NoReturn:
    _, ext = os.path.splitext(path)
    if ext != '.ipynb':
        die(f'"{path}" does not end with ".ipynb".')


if len(sys.argv) not in (3, 4):
    die(USAGE)

src_notebook = sys.argv[1]
dest_notebook = sys.argv[2]

check_notebook_extension(src_notebook)
check_notebook_extension(dest_notebook)

encoding = sys.argv[3] if len(sys.argv) == 4 else 'utf-8'

with codecs.open(src_notebook, mode='r', encoding=encoding) as f:
    notebook = nbformat.read(f, as_version=4)

try:
   lang = notebook.metadata.kernelspec.language
except Exception as e:
    die(f'Cannot get language metadata from "{src_notebook}": {e}')

if lang.lower() != 'scala':
    die('''"{src_notebook}" isn't a Scala notebook.''')

new_cells = []
for cell in notebook.cells:
    if cell.cell_type != 'code':
        new_cells.append(cell)
        continue

    if is_answer_cell(cell.source.split('\n')):
        continue

    new_cells.append(cell)

notebook.cells = new_cells

with codecs.open(dest_notebook, mode='w', encoding=encoding) as f:
    nbformat.write(notebook, f)
