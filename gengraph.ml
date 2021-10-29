(* Options *)
let size = ref 0;; (* number of nodes *)
let undirected = ref false;;
let set_undirected () = undirected := true;;
let weightnum = ref 1;;
let set_weightnum n = weightnum := n;;
let dense = ref 5;;
let set_dense n = dense := n;;
let f_help () = print_endline "help";;

let speclist = [
    ("-u", Arg.Unit set_undirected, "generate an undirected graph");
    ("-d", Arg.Int set_dense, "set denseness of graphs [0:sparse .. 9:dense] (default = 5)");
    ("-w", Arg.Int set_weightnum, "set number of weights of edges (default = 1)");
  ];;

let msgUsage = "USAGE: gengraph <number> [options]"
;;

let usage_and_exit () =
  Arg.usage speclist msgUsage;
  exit 0
;;  

let getsize nStr =
  try
    size := int_of_string nStr
  with
    _ ->
    print_endline "Illegal input";
    usage_and_exit ()
;;

let string_of_list sep to_string ls =
  List.fold_left (fun str x -> if str = "" then to_string x else str ^ sep ^ (to_string x)) "" ls
;;

type weights = int list;;  (* [1;2;3] is on an edge *)
type graph = weights array array;;
  
let existEdge () =
  let num = !dense - Random.int 10 in
  if num >= 0 then true else false
;;

let generate_directedgraph () =
  let empty:weights = [] in
  let graph = Array.make_matrix !size !size empty in
  for i = 0 to !size-1 do
    for j = 0 to !size-1 do
      match existEdge () with
      | true  ->
         for k = 0 to !weightnum-1 do
           graph.(i).(j) <- (1+Random.int 20) :: graph.(i).(j)
         done
      | false -> ()
    done;
  done;
  graph
;;

let generate_undirectedgraph () : graph = 
  let empty:weights = [] in
  let g = Array.make_matrix !size !size empty in
  for i = 0 to !size-1 do
    for j = i to !size-1 do
      match existEdge () with
      | true  ->
         for k = 0 to !weightnum-1 do
           g.(i).(j) <- (1+Random.int 20) :: g.(i).(j);
           g.(j).(i) <- g.(i).(j)
         done
      | false -> ()
    done;
  done;
  g
;;

let print_matrix (g: graph) =
  for i = 0 to !size-1 do
    for j = 0 to !size-1 do
      let weight = g.(i).(j) in
      let weightStr = string_of_list "," string_of_int weight in
      Printf.printf "[%s] " weightStr
    done;
    print_endline "";
  done
;;  

let to_string_undirected (g:graph): string =
  let str = ref "undirected\n" in  
  for i = 0 to !size-1 do
    for j = i to !size-1 do
      if g.(i).(j) = [] then ()
      else
        str := !str ^ "(" ^ (string_of_int i) ^ "," ^ (string_of_int j) ^ "," ^ (string_of_list "," string_of_int g.(i).(j)) ^ ")\n";
    done;
  done;
  !str
;;  

let to_string_directed (g:graph): string =
  let str = ref "directed\n" in
  for i = 0 to !size-1 do
    for j = 0 to !size-1 do
      if g.(i).(j) = [] then ()
      else
        str := !str ^ "(" ^ (string_of_int i) ^ "," ^ (string_of_int j) ^ "," ^ (string_of_list "," string_of_int g.(i).(j)) ^ ")\n";
    done;
  done;
  !str
;;  


let () =
  Random.self_init ();
  Arg.parse speclist getsize msgUsage;
  if !size = 0 then usage_and_exit () else ();
    
  let (graph,output) =
    match !undirected with
    | true  ->
       let grp = generate_undirectedgraph () in
       let str = to_string_undirected grp in
       (grp,str)
    | false ->
       let grp = generate_directedgraph () in
       let str = to_string_directed grp in
       (grp,str)
  in
  (* print_matrix graph; *)
  print_endline output
;;
