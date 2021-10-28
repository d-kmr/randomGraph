(* grp2dot. 2021.10.28 *)

(*
converter from .grp data to .dot data
Usage: grp2dot aaa.grp
- output: stdout in the dot format
- In grp, each edge can have multiple weights
-- An edge with multiple weights converted to multiple edges of same nodes with single weight
-- 1st edge: black + solid
-- 2nd edge: black + dotted
-- 3rd edge: blue  + solid
-- 4th edge: blue  + dotted
-- 5th edge: red   + solid
-- 6th edge: red   + dotted
*)

open Grpdata
;;

let string_of_list sep to_string ls =
  List.fold_left (fun str x -> if str = "" then to_string x else str ^ sep ^ (to_string x)) "" ls
;;

(* read from file *)
let inputstr_stdin () =
  let x = ref "" in
  try
    while true do
      x := !x ^ (input_line stdin) ^ "\n"
    done ;
    "" (* dummy *)
  with End_of_file -> !x ;;

let readfile strp filename =
  let ic = open_in filename in
  try
	while true do
	  strp := !strp ^ (input_line ic) ^ "\n"
	done
  with End_of_file -> close_in ic
;;

(* parser *)
let parse str = 
  Gparser.main Glexer.token 
    (Lexing.from_string str)
;;

let speclist = []
;;

let msgUsage = "USAGE: grp2dot <grpfile>"
;;

let usage_and_exit () =
  Arg.usage speclist msgUsage;
  exit 0
;;  

let to_dot gtype gbody : string =
  let name = "mygraph" in
  let gtypeS = match gtype with DIRECTED -> "digraph" | UNDIRECTED -> "graph" in
  let edgeS = match gtype with DIRECTED -> "->" | UNDIRECTED -> "--" in
  let gbodyS =
    List.fold_left
      (fun s (n1,n2,ww) ->
        let n1S = string_of_int n1 in
        let n2S = string_of_int n2 in
        let edgeHeaderS = n1S ^ " " ^ edgeS ^ " " ^ n2S in
        let edges = ref "" in
        for i = 0 to List.length ww - 1 do
          let w = List.nth ww i in
          let styleS =
            match i mod 2 with
            | 0 -> ""
            | _ -> " style=dotted"
          in
          let colorS = 
            match (i / 2) mod 3 with
            | 0 -> ""
            | 1 -> " color=blue"
            | _ -> " color=red"
          in
          let labelS = "label = \"" ^ (string_of_int w) ^ "\"" in
          let attriv = labelS ^ colorS ^ styleS in
          edges := !edges ^ (edgeHeaderS ^ " [" ^ attriv ^ "];")
        done;
        s ^ "\n  " ^ !edges
      )
      ""
      gbody
  in
  gtypeS ^ " " ^ name ^ "{" ^ gbodyS ^ "\n}"
;;

let () =
  let strp = ref "" in
  Arg.parse speclist (readfile strp) msgUsage;
  let (gtype,gbody) = parse !strp in
  let dotfile = to_dot gtype gbody in
  print_endline dotfile
;;
