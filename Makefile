build: compilateur

compilateur: lex.yy.c
	gcc -o compilateur.exe lex.yy.c

lex.yy.c: compilateur.l
	lex compilateur.l

clean: 
	rm -f lex.yy.c *.o *.exe

test: compilateur
	./compilateur.exe < test.txt

test_powershell: compilateur
	cat test.txt | ./compilateur.exe