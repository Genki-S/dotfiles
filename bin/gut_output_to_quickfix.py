# /usr/bin/env python

import sys

context = {
    "test_file": "",
    "test_name": "",
}


def qfformat(context, message, lnum=""):
    return "{test_file}:{lnum}:{test_name} {message}".format(
        test_file=context["test_file"],
        lnum=lnum,
        test_name=context["test_name"],
        message=message
    )


lines = []

for line in sys.stdin:
    lines.append(line)

for i, line in enumerate(lines):
    if line.startswith("*** Run Summary ***"):
        break

    if line.startswith("res://"):
        context["test_file"] = line.strip().removeprefix("res://")
        continue
    if line.startswith("* "):
        context["test_name"] = line.strip().removeprefix("* ").strip()
        continue
    if line.strip().startswith("[WARNING]"):
        msg = line.strip().removeprefix("[WARNING]:").strip()
        print(qfformat(context, msg))
        continue
    if line.strip().startswith("[Failed]"):
        msg = line.strip().removeprefix("[Failed]").removeprefix(
            ":").removesuffix(":").strip()
        lnum = ""
        nl = lines[i+1]
        if nl.strip().startswith("at line"):
            lnum = nl.strip().removeprefix("at line ").strip()
        print(qfformat(context, msg, lnum=lnum))
        continue
