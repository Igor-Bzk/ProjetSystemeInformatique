#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "label_parser.h"

FILE *code_assembleur, *tmp;
int num_label = 0;

int i = 0;
int tmp_2 = 0;
char rest_of_line[25];
int labels[20][20];
int label_depths[20];

void parse_code()
{
    while (fgets(rest_of_line, 100, code_assembleur) != 0)
    {
        if (sscanf(rest_of_line, "LBL%d %s\n", &num_label, &rest_of_line) == 0)
        {
            fprintf(tmp, "%s", rest_of_line);
            labels[num_label][label_depths[num_label]] = i;
            label_depths[num_label]++;
        }
        else
        {
            fprintf(tmp, "%s", rest_of_line);
        }
        i++;
    }
}

void replace_labels()
{
    while (fgets(rest_of_line, 100, code_assembleur) != 0)
    {
        if (sscanf(rest_of_line, "JMF %d LBL%d\n", &tmp_2, &num_label) == 0)
        {
            fprintf(tmp, "JMF %d %d", tmp_2, labels[num_label][label_depths[num_label]]);
            label_depths[num_label]++;
        }
        else
        {
            fprintf(tmp, "%s", rest_of_line);
        }
        i++;
    }
}

void parser_label()
{

    code_assembleur = fopen("assembleur.txt", "r");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }
    tmp = fopen("tmp.txt", "w");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }
    parse_code();
    replace_labels();
    fclose(code_assembleur);
}

int main()
{
    parser_label();
    return 0;
}