%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tMAIN tVIRG tPVIRG tPRINT tEGAL tSOU tADD tMUL tDIV tPO tPF tAO tAF tCONST tINT 
%token tERROR tIF tELSE tEXCL tSUP tINF tAND tOR
%token <nb> tNB
%token <var> tID
%type <nb> Expr Main Def Var Val Cond
%right tMUL tDIV
%right tADD tSOU
%right tVIRG
%right tPVIRG
%start Main
%%
Main: tMAIN tPO tPF tAO Expr tAF {printf("Main detecte\n");}; 
Expr:   Expr tPVIRG Expr {printf("Expr tPVIRG Expr\n");}
        | Expr tPVIRG {printf("Expr tPVIRG\n");}
        | tIF tPO Cond tPF tAO Expr tAF tELSE tAO Expr tAF Expr{printf("tIF tPO Expr tPF tAO Expr tAF tELSE tAO Expr tAF Expr\n");}
        | tIF tPO Cond tPF tAO Expr tAF Expr{printf("tIF tPO Expr tPF tAO Expr tAF Expr \n");}
        | tIF tPO Cond tPF tAO Expr tAF tELSE tAO Expr tAF {printf("tIF tPO Expr tPF tAO Expr tAF tELSE tAO Expr tAF\n");}
        | tIF tPO Cond tPF tAO Expr tAF {printf("tIF tPO Expr tPF tAO Expr tAF \n");}
        | Def{printf("Def\n");}
        | Aff{printf("AFF");}
        | tPRINT tPO tID tPF {printf("tPRINT tPO tID tPF\n");};
Def : tINT Var tEGAL Val {printf("tINT Var tEGAL Val\n");}
      | tINT Var {printf("tINT Var\n");}
      |tCONST Var tEGAL Val {printf("tCONST Var tEGAL Val\n");}
      |tCONST Var {printf("tCONST Var\n");};
Val : tPO Val tPF {printf("tPO Val tPF\n");}
     |Val tADD Val {printf("Val tADD Val\n");}
     |Val tSOU Val {printf("Val tSOU Val\n");}
     |Val tMUL Val {printf("Val tMUL Val\n");}
     |Val tDIV Val {printf("Val tDIV Val\n");}
     |tID {printf("tID\n");}
     |tNB {printf("tNB\n");};
Var : tID tVIRG Var {printf("tID tVIRG Var\n");}
     |tID {printf("tID\n");};
Aff :  Var tEGAL Val{printf("Var tEGAL Val");}
     | Var tADD tEGAL Val{printf("Var tADD tEGAL Val");}
     | Var tSOU tEGAL Val{printf("Var tSOU tEGAL Val");}
     | Var tMUL tEGAL Val{printf("Var tMUL tEGAL Val");}
     | Var tDIV tEGAL Val{printf("Var tDIV tEGAL Val");}
Cond : tEXCL tPO Cond tPF {printf("tEXCL tPO Cond tPF");}
     | Cond tAND Cond {printf("Cond tAND Cond");}
     | Cond tOR Cond {printf("Cond tOR Cond");}
     | Val tEGAL tEGAL Val {printf("Val tEGAL tEGAL Val");}
     | Val tEXCL tEGAL Val {printf("Val tEXCL tEGAL Val");}
     | Val tSUP Val {printf("Val tSUP Val");}
     | Val tSUP tEGAL Val {printf("Val tSUP tEGAL Val");}
     | Val tINF Val {printf("Val tINF Val");}
     | Val tINF tEGAL Val {printf("Val tINF tEGAL Val");}; 
        
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s);}
int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 0;
}

//bison -t -v -g syntax.y 
//ore syntax.gv
//dot -Tpdf syntax.gv > out.pdf
//open out.pdf 
//vi syntax.output 