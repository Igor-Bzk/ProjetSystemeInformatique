%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%
"main" { printf("tMAIN "); return tMAIN;}
"const" { printf("tCONST ");return tCONST;}
"int" { printf("tINT ");return tINT;}
\t { printf("	");}
" " { printf(" ");}
"," { printf("tVIRG ");return tVIRG;}
\n { printf("tENDL\n");}
";" { printf("tPVIRG ");return tPVIRG;}
"printf" { printf("tPRINT ");return tPRINT;}
[0-9]+	{
	  printf("tNB: %s ",yytext);
	  return tNB;
	}
"="	{ printf("tEGAL ");return tEGAL; }
"-"	{ printf("tSOU "); return tSOU;}
"+"	{ printf("tADD ");return tADD; }
"*"	{ printf("tMUL ");return tMUL; }
"/"	{ printf("tDIV "); return tDIV;}
"("	{ printf("tPO "); return tPO;}
")"	{ printf("tPF "); return tPF;}
"{"	{ printf("tAO "); return tAO;}
"}"	{ printf("tAF "); return tAF;}
[a-z]([a-z]|[0-9]|_)*	{
	  printf("tID: %s ",yytext); return tID;
	}
.	{ printf("tERROR\n"); }


%%
