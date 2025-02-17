build: compilateur

compilateur: lex.yy.c
	gcc -o compilateur lex.yy.c

lex.yy.c: compilateur.l
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o

test: compilateur
	./compilateur < test.txt