#!/bin/bash

FILE="mygraph"

gengraph -u -w 2 3 > mygraph.grp
grp2dot mygraph.grp > mygraph.dot
