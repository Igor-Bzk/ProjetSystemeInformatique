%{
#include <stdlib.h>
#include <stdio.h>
//#include "y.tab.h"
%}

%option noyywrap

%%

[ \t]+	{};
[0-9]+	{
	  printf("tNB: %s\n",yytext);
	}
"="	{ printf("tEGAL\n"); }
"-"	{ printf("tSOU\n"); }
"+"	{ printf("tADD\n"); }
"*"	{ printf("tMUL\n"); }
"/"	{ printf("tDIV\n"); }
"("	{ printf("tPO\n"); }
")"	{ printf("tPF\n"); }
[a-z]	{
	  printf("tID: %c\n",yytext[0]);
	}
\n	{ printf("tFL\n"); }
.	{ printf("tERROR\n"); }

%%

int main(){
yylex();
return 0;
}