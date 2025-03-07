%{
#include <stdlib.h>
#include <stdio.h>
#include "syntax.tab.h"
%}

%option noyywrap

%%%%


"main" { return tMAIN;}
"while"{return tWHILE;}
"if" {return tIF;}
"else" {return tELSE;}
"!" {return tEXCL;}
">" {return tSUP;}
"<" {return tINF;}
"&&" {return tAND;}
"||" {return tOR;}
"const" { return tCONST;}
"int" { return tINT;}
\t { }
" " { }
"," { return tVIRG;}
\n { }
";" { return tPVIRG;}
"printf" { return tPRINT;}
[0-9]+	{
	  return tNB;
	}
"="	{ return tEGAL; }
"-"	{  return tSOU;}
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV;}
"("	{  return tPO;}
")"	{ return tPF;}
"{"	{  return tAO;}
"}"	{  return tAF;}
[a-z]([a-z]|[0-9]|_)*	{
	  return tID;
	}
.	{ }

%%

/*"main" { printf("tMAIN "); return tMAIN;}
"const" { printf("tCONST ");return tCONST;}
"int" { printf("tINT ");return tINT;}
"while" { printf("tWHILE ");return tWHILE;}
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
*/