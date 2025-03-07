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
%left tMUL tDIV
%left tADD tSOU
%start Main
%%
Main: tMAIN tPO tPF tAO Expr tAF {printf("Main detecte\n")}; 
Expr:   Expr tPVIRG Expr {printf("Expr tPVIRG Expr\n")}
        | Expr tPVIRG {printf("Expr tPVIRG\n")}
        | Def{printf("Def\n")}
        | tPRINT tPO tID tPF {printf("tPRINT tPO tID tPF\n")};
Def : tINT Var tEGAL Val {printf("tINT Var tEGAL Val\n")}
      | tINT Var {printf("tINT Var\n")}
      |tCONST Var tEGAL Val {printf("tCONST Var tEGAL Val\n")}
      |tCONST Var {printf("tCONST Var\n")};
Val : Val tADD Val {printf("Val tADD Val\n")}
     |Val tSOU Val {printf("Val tSOU Val\n")}
     |Val tMUL Val {printf("Val tMUL Val\n")}
     |Val tDIV Val {printf("Val tDIV Val\n")}
     |tID {printf("tID\n")}
     |tNB {printf("tNB\n")};
Var : tID tVIRG Var {printf("tID tVIRG Var\n")}
     |tID {printf("tID\n")};
        
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s);
int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 0;
}