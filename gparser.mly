// Parser for grp 2021/10/28
                          
%{
open Grpdata
%}

%token <int> NUM
            
%token LPAREN   // '('
%token RPAREN   // ')'
%token COMMA    // ','
%token DIRECTED   // "directed"
%token UNDIRECTED // "undirected"
%token EOF 

// 結合力(優先度が低い順)
%nonassoc COMMA

%start main            
%type <Grpdata.graph> main
%%

main:
  | DIRECTED body EOF
       { (DIRECTED,$2) }
  | UNDIRECTED body EOF
       { (UNDIRECTED,$2) }      
;

weights:
  | NUM
      { [$1] }
  | weights COMMA NUM
	  { $1@[$3] }
;

one_edge:
  | LPAREN NUM COMMA NUM COMMA weights RPAREN
      { ($2,$4,$6) }
;
  
body:
  | one_edge
      { [$1] }
  | body one_edge
      { $1@[$2] }
;
