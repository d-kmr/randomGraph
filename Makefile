

GENGRAPH= gengraph
GRP2DOT = grp2dot


all: grpdata.ml gengraph.ml glexer.mll gparser.mly
	ocamlopt -c grpdata.ml
	ocamllex glexer.mll
	ocamlyacc gparser.mly
	ocamlopt -c gparser.mli
	ocamlopt -o $(GENGRAPH) gengraph.ml
	ocamlopt -o $(GRP2DOT) glexer.ml gparser.ml grp2dot.ml

clean:
	rm gengraph.cmx gengraph.o
