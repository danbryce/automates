import sys
from typing import List
import math
from program_analysis.for2py.format import *
from program_analysis.for2py.arrays import *
from program_analysis.for2py.static_save import *
from program_analysis.for2py.strings import *
from dataclasses import dataclass
from program_analysis.for2py.types_ext import Float32
import program_analysis.for2py.math_ext as math
from numbers import Real
from random import random


def factorial():
    format_10: List[str] = [None]
    format_10 = ["'i = '", 'I3', "'; fact = '", 'I8']
    format_10_obj = Format(format_10)
    
    i: List[int] = [None]
    n: List[int] = [None]
    fact: List[int] = [None]
    i[0] = 0
    n[0] = 10
    fact[0] = 0
    for i[0] in range(1, n[0]+1):
        if (i[0] < 20):
            if (i[0] == 1):
                fact[0] = (fact[0] + 1)
                write_list_stream = [i[0], fact[0]]
                write_line = format_10_obj.write_line(write_list_stream)
                sys.stdout.write(write_line)
            else:
                if (i[0] <= 10):
                    fact[0] = int((fact[0] * i[0]))
                    write_list_stream = [i[0], fact[0]]
                    write_line = format_10_obj.write_line(write_list_stream)
                    sys.stdout.write(write_line)
                else:
                    break
    goto_flag_1: List[bool] = [None]
    goto_flag_1[0] = True
    if goto_flag_1[0]:
        return
    

factorial()