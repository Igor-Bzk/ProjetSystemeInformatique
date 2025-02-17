%{
#include <stdlib.h>
#include <stdio.h>
//#include "y.tab.h"
%}

%option noyywrap

%%
"main ()" { printf("tMAIN ");}
"const" { printf("tCONST ");}
"int" { printf("tINT ");}
\t { printf("	");}
" " { printf(" ");}
"," { printf("tVIG ");}
\n { printf("tENDL\n");}
";" { printf("tPVIG ");}
"printf" { printf("tPRI ");}
[0-9]+	{
	  printf("tNB: %s ",yytext);
	}
"="	{ printf("tEGAL "); }
"-"	{ printf("tSOU "); }
"+"	{ printf("tADD "); }
"*"	{ printf("tMUL "); }
"/"	{ printf("tDIV "); }
"("	{ printf("tPO "); }
")"	{ printf("tPF "); }
"{"	{ printf("tAO "); }
"}"	{ printf("tAF "); }
[a-z]([a-z]|[0-9]|_)*	{
	  printf("tID: %s ",yytext);
	}
.	{ printf("tERROR\n"); }


%%

int main(){
yylex();
return 0;
}