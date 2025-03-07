build: compilateur syntax

compilateur: lex.yy.c
	gcc -o compilateur.exe lex.yy.c

syntax: syntax.tab.c lex.yy.c
	gcc -o syntax.exe syntax.tab.c lex.yy.c

syntax.tab.c: syntax.y
	bison -t -v -g syntax.y

lex.yy.c: compilateur.l
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o *.exe *.pdf *.gv

test: compilateur
	./compilateur.exe < test.txt