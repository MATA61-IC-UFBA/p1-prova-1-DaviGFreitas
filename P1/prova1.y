%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *msg);
%}

%token ERROR
%token NUM STRING IDENT
%token PRINT CONCAT LENGTH
%token PLUS MINUS TIMES DIV ASSIGN COMMA
%token LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIV

%start program

%%

program
  : stmt_list
  ;

stmt_list
  : stmt
  | stmt_list stmt
  ;

stmt
  : IDENT ASSIGN expr
  | PRINT LPAREN exprlist RPAREN
  | expr
  ;

exprlist
  : expr
  | exprlist COMMA expr
  ;

expr
  : expr PLUS expr
  | expr MINUS expr
  | expr TIMES expr
  | expr DIV expr
  | LPAREN expr RPAREN
  | CONCAT LPAREN exprlist RPAREN
  | LENGTH LPAREN expr RPAREN
  | NUM
  | STRING
  | IDENT
  ;

%%
