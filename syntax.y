%{
#include <stdlib.h>
#include <stdio.h>
#include "syntax.tab.h"
#include "table_symbole.h"
#include "assembleur.h"
int var[26];
void yyerror(char *s);
int yylex();
%}
%union { int nb; char* str; }
%token tMAIN tVIRG tPVIRG tPRINT tEGAL tSOU tADD tMUL tDIV tPO tPF tAO tAF tCONST tINT tWHILE 
%token tERROR tIF tELSE tEXCL tSUP tINF tAND tOR
%token <nb> tNB
%token <str> tID
%type <nb> Expr Main Def Var Cond Body Var_def Val
%right tMUL tDIV
%right tADD tSOU
%right tVIRG
%right tPVIRG
%right tIF
%right tOR
%right tAND tAF tPF tELSE
%start Main
%%
Main: tMAIN {ouvrir();}tPO tPF tAO Expr tAF {printf("Main detecte\n");fermer();}; 


Expr:   Expr tPVIRG Expr {printf("Expr tPVIRG Expr\n");}
        | Expr tPVIRG {printf("Expr tPVIRG\n");}
        | IfCond tPF Else Body Expr{printf("tIF tPO Expr tPF tAO Expr tAF tELSE tAO Expr tAF Expr\n");}
        | IfCond tPF Body Expr{printf("tIF tPO Expr tPF tAO Expr tAF Expr \n");}
        | IfCond tPF Else Body {printf("tIF tPO Expr tPF tAO Expr tAF tELSE tAO Expr tAF\n");}
        | IfCond tPF Body {printf("tIF tPO Expr tPF tAO Expr tAF \n");}
        | Def{printf("Def\n");}
        | tWHILE tPO Cond tPF Body {printf("tWHILE tPO Cond tPF tAO Expr tAF\n");}
        | tWHILE tPO Cond tPF Body Expr {printf("tWHILE tPO Cond tPF tAO Expr tAF\n");}
        | Var tEGAL Val{affectation($1,$3);printf("Var tEGAL Val");}
        | tPRINT tPO tID tPF {print(get_index($3)),printf("tPRINT tPO tID tPF\n");};

Body: {incrementer_profondeur();print_table_symbole();} tAO Expr tAF {print_table_symbole();printf("Valeur recherchee : %d\n",get_index("a"));printf("body");decrementer_profondeur();$$=add_label(get_profondeur());}

IfCond: tIF tPO Cond {if_not_goto($3,get_profondeur());}

Else: Body tELSE{else_goto(get_profondeur());}

Def : tINT Var_def tEGAL Val {affectation($2,$4);printf("tINT Var tEGAL Val\n");}
      | tINT Var_def {printf("tINT Var\n");}
      |tCONST Var_def tEGAL Val {printf("tCONST Var tEGAL Val\n");}
      |tCONST Var_def {printf("tCONST Var\n");};


Val : tPO Val tPF {printf("tPO Val tPF\n");$$ = $2;}
     |Val tADD Val {printf("Val tADD Val\n");$$=operation(0,$1,$3);}
     |Val tSOU Val {printf("Val tSOU Val\n");$$=operation(1,$1,$3);}
     |Val tMUL Val {printf("Val tMUL Val\n");$$=operation(2,$1,$3);}
     |Val tDIV Val {printf("Val tDIV Val\n");$$=operation(3,$1,$3);}
     |tID {printf("tID\n");$$=copy_to_tmp(get_index($1));}
     |tNB {printf("tNB\n");$$=aff_tmp(add_tmp(), $1);};

Var_def: tID tVIRG Var_def {$$=add_symbole($1);printf("tID tVIRG Var\n");}
          |  tID {$$=add_symbole($1);};


Var : tID tVIRG Var {$$ = get_index($1);printf("tID tVIRG Var\n");}
     |tID {$$ = get_index($1);};

Cond : tEXCL tPO Cond tPF {printf("tEXCL tPO Cond tPF");}
     | Cond tAND Cond {printf("Cond tAND Cond");$$=operation(2,$1,$3);}
     | Cond tOR Cond {printf("Cond tOR Cond");$$=operation(0,$1,$3);}
     | Val tEGAL tEGAL Val {printf("Val tEGAL tEGAL Val");$$=cmp(0,$1,$4);}
     | Val tEXCL tEGAL Val {printf("Val tEXCL tEGAL Val");$$=cmp(5,$1,$4);}
     | Val tSUP Val {printf("Val tSUP Val");$$=cmp(1,$1,$3);}
     | Val tSUP tEGAL Val {printf("Val tSUP tEGAL Val");$$=cmp(2,$1,$4);}
     | Val tINF Val {printf("Val tINF Val");$$=cmp(3,$1,$3);}
     | Val tINF tEGAL Val {printf("Val tINF tEGAL Val");$$=cmp(4,$1,$4);}; 
        
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