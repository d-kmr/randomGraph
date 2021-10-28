(* Lexer for .grp 2021/10/28 *)

{
  open Gparser
}

let space = [' ' '\t' '\n' '\r']
let eol = ['\n' '\r']
let digit = ['0'-'9']
let comment = "//"
  
rule token = parse
  | '('       { LPAREN }
  | ')'       { RPAREN }
  | ','       { COMMA }
  | "directed"   { DIRECTED }
  | "undirected" { UNDIRECTED }  
  
  | digit*
    { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  
  | eof       { EOF }

  | space+    { token lexbuf }

  | comment [^ '\n' '\r']* eol { token lexbuf }

  | _
    {
      let message = Printf.sprintf
        "unknown token %s near characters %d-%d"
        (Lexing.lexeme lexbuf)
        (Lexing.lexeme_start lexbuf)
        (Lexing.lexeme_end lexbuf)
      in
      failwith message
    }

and comment = parse
  | eol     { token lexbuf }
  | eof     { EOF }            
  | _       { comment lexbuf }    
