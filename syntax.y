%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tMAIN tVIRG tPVIRG tPRINT tEGAL tSOU tADD tMUL tDIV tPO tPF tAO tAF tCONST tINT tERROR
%token <nb> tNB
%token <var> tID
%type <nb> Expr Main Def Var Val
%start Programme
%%
Main: tMAIN tPO tPF tAO Expr tAF {}; 
Expr:   Expr tPVIRG Expr {}
        | Expr tPVIRG {}
        | Def{}
        | tPRINT tPO tID tPF {};
Def : tINT Var tEGAL Val {}
      | tINT Var {}
      |tCONST Var tEGAL Val {}
      |tCONST Var {};
Val : Val tADD Val {}
     |Val tSOU Val {}
     |Val tMUL Val {}
     |Val tDIV Val {}
     |tID {}
     |tNB {};
Var : tID tVIRG Var {}
     |tID {};
        
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 0;
}