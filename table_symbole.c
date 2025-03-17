#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <string.h>
#include "table_symbole.h"

/*
void f() {
    int a;
    int b;
    if (a) {
        int c;
        int d;
        // ici
    }
    // la
}


| d 1 | <- index
| c 1 |
| b 0 |
| a 0 |
profondeur = 1


| b 0 | <- index
| a 0 |
profondeur = 0
*/

typedef struct symbole
{
    char *nom;
    int profondeur;
} symbole;

symbole symboles[16];
int profondeur_courante=0;
int indexe =0;

void decrementer_profondeur()
{
    while(indexe>1 && symboles[indexe].profondeur==profondeur_courante){
        indexe-=1;
    }
    profondeur_courante-=1;
}


void add_symbole(char* nom)
{
    symbole sy;
    sy.nom = nom;
    sy.profondeur = profondeur_courante;
    symboles[indexe+1]=sy;
    index+=1;
}

void incrementer_profondeur(){
    profondeur_courante+=1;
}

int get_pofondeur_symbole(char* nom){
    for(int i=0;i<indexe;i++){
        if(strcmp(nom,symboles[i].nom)){
            return symboles[i].profondeur;
        }
    }
    printf("Ce symbole n'existe pas ou plus !\n");
    return -1;
}

int main()
{
    return 0;
}