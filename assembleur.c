#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "table_symbole.h"
#include "assembleur.h"

int num_labels = 0;

FILE *code_assembleur;

void ouvrir()
{
    code_assembleur = fopen("assembleur.txt", "w");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }
}

void fermer()
{
    fclose(code_assembleur);
}

int copy_to_tmp(int v)
{
    int tmp = add_tmp();
    fprintf(code_assembleur, "COP %d %d\n", tmp, v);
    return tmp;
}

int operation(int op, int v1, int v2)
{
    char op_str[4];
    switch (op)
    {
    case 0:
        strcpy(op_str, "ADD");
        break;
    case 1:
        strcpy(op_str, "SUB");
        break;
    case 2:
        strcpy(op_str, "MUL");
        break;
    case 3:
        strcpy(op_str, "DIV");
        break;
    default:
        break;
    }
    int tmp = add_tmp();
    fprintf(code_assembleur, "%s %d %d %d\n", op_str, tmp, v1, v2);
    free_tmp(v2);
    return tmp;
}

int affectation(int v, int tmp)
{
    fprintf(code_assembleur, "COP %d %d\n", v, tmp);
    return v;
}

int aff_tmp(int tmp, int val)
{
    fprintf(code_assembleur, "AFS %d %d\n", tmp, val);
    return tmp;
}

void print(int v)
{
    fprintf(code_assembleur, "PRI %d\n", v);
}

int add_label()
{
    fprintf(code_assembleur, "LBL%d\n", num_labels);
    return num_labels = -1;
}

void if_not_goto(int cond)
{
    fprintf(code_assembleur, "JMF %d %d\n", cond, num_labels);
    num_labels++;
}

void else_goto()
{
    fprintf(code_assembleur, "JMP %d\n", num_labels);
    num_labels++;
}

int cmp(int op, int v1, int v2)
{
    char op_str[4];
    int tmp = add_tmp();
    int tmp2 = add_tmp();

    switch (op)
    {
    case 0: // egal
        fprintf(code_assembleur, "EQU %d %d %d\n", tmp, v1, v2);
        break;
    case 1: // Superieur
        fprintf(code_assembleur, "SUP %d %d %d\n", tmp, v1, v2);
        break;
    case 2: // superieur ou egal
        fprintf(code_assembleur, "SUP %d %d %d\n", tmp, v1, v2);
        fprintf(code_assembleur, "EQU %d %d %d\n", tmp2, v1, v2);
        fprintf(code_assembleur, "ADD %d %d %d\n", tmp, tmp, tmp2);
        break;
    case 3: // inferieur
        fprintf(code_assembleur, "INF %d %d %d\n", tmp, v1, v2);
        break;
    case 4: // inferieur ou egal
        fprintf(code_assembleur, "INF %d %d %d\n", tmp, v1, v2);
        fprintf(code_assembleur, "EQU %d %d %d\n", tmp2, v1, v2);
        fprintf(code_assembleur, "ADD %d %d %d\n", tmp, tmp, tmp2);
        break;
    case 5: // non egal
        fprintf(code_assembleur, "SUP %d %d %d\n", tmp, v1, v2);
        fprintf(code_assembleur, "INF %d %d %d\n", tmp2, v1, v2);
        fprintf(code_assembleur, "ADD %d %d %d\n", tmp, tmp, tmp2);
        break;
    }

    free_tmp(v2);
    free_tmp(tmp2);
    return tmp;
}