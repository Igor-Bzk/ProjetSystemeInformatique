#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <string.h>
#include "table_symbole.h"

typedef struct symbole
{
    char *nom;
    int valeur;
} symbole;

typedef struct table_symbole
{
    symbole simb;
    symbole suiv[16];
    int profondeur;
} table_symbole;

symbole pop(table_symbole *table)
{
    table->profondeur -= 1;
    return table->suiv[table->profondeur];
}

void push(table_symbole *table, symbole *symb)
{
    if (table->profondeur == 15)
    {
        printf("Table deja pleine\n");
    }
    else
    {
        table->suiv[table->profondeur] = *symb;
        table->profondeur += 1;
    }
}

void set_val(table_symbole *table, char *nom, int val)
{
    for (int i = 0; i < table->profondeur; i++)
    {
        if (strcmp(table->suiv[i].nom, nom) == 0)
        {
            table->suiv[i].valeur = val;
            return;
        }
    }
    printf("Symbole non trouvé\n");
}

int get_val(table_symbole *table, char *nom)
{
    for (int i = 0; i <= table->profondeur; i++)
    {
        symbole sy = table->suiv[i];
        if (strcmp(sy.nom, nom))
        {
            return sy.valeur;
        }
    }
    printf("Symbole non trouvé\n");
    return -1;
}

int get_profondeur(table_symbole *table)
{
    return table->profondeur;
}

int main()
{
    return 0;
}