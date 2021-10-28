# randomGraph: create a random graph and convert the created graph to a dot format file

[Requirements]
- OCaml
- OCaml yacc
- OCaml lexer
- make
- xdot or something


[Compile]

$ make

--> two executables gengraph and grp2dot are created


[Usage]

$ ./graph.sh


[Usage of gengraph]

$ ./gengraph <num> [options]

(creates random graph with nodes 0,1,2,..,num-1 and shows it on stdout)


[Options for gengraph]

-u			: generates undirected graph

-w <num>	: number of weights of each edge (default=1)

-d <num>	: set denseness of graphs [0:sparse .. 9:dense] (default=5)



[Usage of grp2dot]

$ ./grp2dot <grpfile>

(converts the input <grpfile> to a dot format file and shows it on stdout)


[grp file example1]

directed

(0,1,10,3)

(1,3,14,5)

(2,4,3,2) 


A directed graph with edges

0 -[10,3]-> 1

1 -[14,5]-> 3

2 -[3,2]->  4



[grp file example2]

undirected

(0,1,10,3)

(1,3,14,5)

(2,4,3,2)


An undirected graph with edges

0 -[10,3]- 1

1 -[14,5]- 3

2 -[3,2]-  4
