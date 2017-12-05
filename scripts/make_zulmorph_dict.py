#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import unicode_literals, division, print_function #Py2

__author__ = "Daniel van Niekerk"
__email__ = "dvn.demitasse@gmail.com"

import sys, os, codecs
import cPickle as pickle

DICTFN = "lang/morph/zulmorph.dict"

if __name__ == "__main__":
    try:
        dictfn = sys.argv[1]
    except IndexError:
        dictfn = DICTFN
        
    morphdict = {}
    with codecs.open(dictfn, encoding="utf-8") as infh:
        for line in infh:
            word, pos, parse = line.split()
            morphdict[word] = parse

    print(pickle.dumps(morphdict, protocol=2))
