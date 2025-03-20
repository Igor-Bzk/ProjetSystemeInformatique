build: compilateur syntax

compilateur: lex.yy.c
	gcc -o compilateur.exe lex.yy.c

syntax: syntax.tab.c lex.yy.c syntax.tab.h
	gcc -o syntax.exe syntax.tab.c lex.yy.c table_symbole.c

syntax.tab.c: syntax.y
	bison -t -v -g -d syntax.y 

lex.yy.c: compilateur.l
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o *.exe *.pdf *.gv *.output *.tab.c *.tab.h compilateur *.yy.c *.yy.h assembleur.txt

test: syntax
	./syntax.exe < test.txt
