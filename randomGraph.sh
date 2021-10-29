#!/bin/bash

FILE="mygraph"

gengraph -w 1 5 > mygraph.grp
grp2dot mygraph.grp > mygraph.dot
