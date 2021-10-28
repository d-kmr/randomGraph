#!/bin/bash

FILE="mygraph"

gengraph -u -w 6 5 > mygraph.grp
grp2dot mygraph.grp > mygraph.dot
