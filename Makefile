build: compilateur syntax

compilateur: lex.yy.c
	gcc -o compilateur lex.yy.c

syntax:
	bison -t -v -g syntax.y

lex.yy.c: compilateur.l
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o *.exe *.pdf *.gv

test: compilateur
	./compilateur < test.txt