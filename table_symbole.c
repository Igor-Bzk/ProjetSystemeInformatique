#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <string.h>
#include "table_symbole.h"

typedef struct symbole
{
    char *nom;
    int profondeur;
} symbole;

symbole symboles[16];
int profondeur_courante = 0;

int indexe = 0;
int indexe_tmp = 15;
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


| d 1 | <- indexe
| c 1 |
| b 0 |
| a 0 |
profondeur = 1


| b 0 | <- indexe
| a 0 |
profondeur = 0
*/

void decrementer_profondeur()
{
    while (indexe > 0 && symboles[indexe - 1].profondeur == profondeur_courante)
    {
        indexe -= 1;
    }
    profondeur_courante -= 1;
}

int add_symbole(char *nom)
{
    symbole sy;
    sy.nom = nom;
    sy.profondeur = profondeur_courante;
    symboles[indexe] = sy;
    indexe += 1;
    return indexe - 1;
}

int add_tmp()
{
    char *tmp = malloc(10);
    sprintf(tmp, "tmp%d", indexe_tmp);
    indexe_tmp -= 1;
    return indexe_tmp + 1;
}

void free_tmp(int tmp)
{
    for (int i = tmp; i > indexe_tmp; i--)
    {
        symboles[i] = symboles[i - 1];
    }
    indexe_tmp += 1;
}

void incrementer_profondeur()
{
    profondeur_courante += 1;
}

void print_table_symbole()
{
    printf("profondeur_courante: %d, indexe :%d\n", profondeur_courante, indexe);
    for (int i = 0; i < indexe; i++)
    {
        printf("%s %d\n", symboles[i].nom, symboles[i].profondeur);
    }
}

int get_index(char *variable)
{
    for (int i = indexe - 1; i >= 0; i--)
    {
        if (!strcmp(variable, symboles[i].nom))
        {
            return i;
        }
    }

    for (int i = indexe_tmp + 1; i < 16; i++)
    {
        if (!strcmp(variable, symboles[i].nom))
        {
            return i;
        }
    }
}