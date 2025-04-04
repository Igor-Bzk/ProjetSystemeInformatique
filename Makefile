build: compilateur syntax

compilateur: lex.yy.c
	gcc -o compilateur.exe lex.yy.c

syntax: syntax.tab.c lex.yy.c syntax.tab.h table_symbole.c table_symbole.h assembleur.c assembleur.h label_parser.c label_parser.h
	gcc -o syntax.exe syntax.tab.c lex.yy.c table_symbole.c assembleur.c
	gcc -o label_parser.exe label_parser.c

syntax.tab.c syntax.tab.h: syntax.y
	bison -t -v -g -d syntax.y 

lex.yy.c: compilateur.l syntax.tab.h
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o *.exe *.pdf *.gv *.output *.tab.c *.tab.h compilateur *.yy.c *.yy.h assembleur.txt

test: syntax
	./syntax.exe < test.txt
	./label_parser.exe < assembleur.txt
