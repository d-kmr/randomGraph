type graphtype = DIRECTED | UNDIRECTED
;;
type weights = int list
;;
type node = int
;;
type edge = node * node * weights
;;
type graph = graphtype * edge list
;;
