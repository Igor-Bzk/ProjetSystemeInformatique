#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "table_symbole.h"

FILE *code_assembleur;

void ouvrir(){
    code_assembleur = fopen("assembleur.txt", "w");
    if (code_assembleur== NULL) {
        printf("Erreur d'ouverture\n");
    }
}

void fermer(){
    fclose(code_assembleur);
}

void add(char* v1,char* v2){
    printf("valeurs %s, %s\n",v1,v2);
}
