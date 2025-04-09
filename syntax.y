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
Main: tMAIN {ouvrir();}tPO tPF tAO Expr tAF {printf("Main detecte\n");corrige_labels();fermer();}; 


Expr: Expr tPVIRG Expr {}
    | Expr tPVIRG {}
    | IfCond tPF Else Body {afficher_cours(); add_label_named("IF_END");} Expr {}
    | IfCondElse tPF Body {afficher_cours(); add_label_named("IF_END");} Expr {}
    | IfCondElse tPF Else Body {afficher_cours(); add_label_named("IF_END");}
    | IfCond tPF Body {afficher_cours(); add_label_named("IF_END");}
    | Def {}
    | tWHILE tPO Cond tPF Body {}
    | tWHILE tPO Cond tPF Body Expr {}
    | Var tEGAL Val {affectation($1, $3);}
    | tPRINT tPO tID tPF {};

Body: {incrementer_profondeur(); print_table_symbole();} tAO Expr tAF {decrementer_profondeur();};

IfCondElse: tIF tPO Cond {if_not_goto($3, "IF_ELSE");};

IfCond: tIF tPO Cond {if_not_goto($3, "IF_ELSE");};

Else: Body tELSE {else_goto("IF_END"); afficher_cours(); add_label_named("IF_ELSE");};

Def : tINT Var_def tEGAL Val {affectation($2,$4);} //printf("tINT Var tEGAL Val\n");
      | tINT Var_def {} //printf("tINT Var\n");
      |tCONST Var_def tEGAL Val {} //printf("tCONST Var tEGAL Val\n");
      |tCONST Var_def {}; //printf("tCONST Var\n");


Val : tPO Val tPF {$$ = $2;} //printf("tPO Val tPF\n");
     |Val tADD Val {$$=operation(0,$1,$3);} //printf("Val tADD Val\n");
     |Val tSOU Val {$$=operation(1,$1,$3);} //printf("Val tSOU Val\n");
     |Val tMUL Val {$$=operation(2,$1,$3);} // printf("Val tMUL Val\n");
     |Val tDIV Val {$$=operation(3,$1,$3);} //printf("Val tDIV Val\n");
     |tID {$$=copy_to_tmp(get_index($1));} //printf("tID\n");
     |tNB {$$=aff_tmp(add_tmp(), $1);}; //printf("tNB\n");

Var_def: tID tVIRG Var_def {$$=add_symbole($1);} //printf("tID tVIRG Var\n");
          |  tID {$$=add_symbole($1);};


Var : tID tVIRG Var {$$ = get_index($1);} //printf("tID tVIRG Var\n");
     |tID {$$ = get_index($1);};

Cond : tEXCL tPO Cond tPF {} //printf("tEXCL tPO Cond tPF");
     | Cond tAND Cond {$$=operation(2,$1,$3);} //printf("Cond tAND Cond");
     | Cond tOR Cond {$$=operation(0,$1,$3);} //printf("Cond tOR Cond");
     | Val tEGAL tEGAL Val {$$=cmp(0,$1,$4);} //printf("Val tEGAL tEGAL Val");
     | Val tEXCL tEGAL Val {$$=cmp(5,$1,$4);} //printf("Val tEXCL tEGAL Val");
     | Val tSUP Val {$$=cmp(1,$1,$3);} //printf("Val tSUP Val");
     | Val tSUP tEGAL Val {$$=cmp(2,$1,$4);} //printf("Val tSUP tEGAL Val");
     | Val tINF Val {$$=cmp(3,$1,$3);} // printf("Val tINF Val");
     | Val tINF tEGAL Val {$$=cmp(4,$1,$4);}; //printf("Val tINF tEGAL Val");
        
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