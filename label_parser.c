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
    while (fgets(rest_of_line, 25, code_assembleur) != 0)
    {
        i++;
        int j = 0;
        while (sscanf((char *)(rest_of_line + j), "LBL%d ", &num_label, (char *)(rest_of_line + j)) == 1 && j < strlen(rest_of_line))
        {
            labels[num_label][label_depths[num_label]] = i;
            // printf("num_label: %d, label_depth: %d, i:  %d, value: %d\n", num_label, label_depths[num_label], i, labels[num_label][label_depths[num_label]]);
            label_depths[num_label]++;
            j += 5;
        }
        if (j == 0)
        {
            fprintf(tmp, "%s", rest_of_line);
        }
        else
        {
            fprintf(tmp, "%s", (char *)(rest_of_line + j));
        }
    }
}

void replace_labels()
{

    while (fgets(rest_of_line, 25, tmp) != 0)
    {
        if (sscanf(rest_of_line, "JMF %d LBL%d", &tmp_2, &num_label) == 2)
        {
            fprintf(code_assembleur, "JMF %d %d\n", tmp_2, labels[num_label][label_depths[num_label]]);
            // printf("num_label: %d, label_depth: %d, value: %d\n", num_label, label_depths[num_label], labels[num_label][label_depths[num_label]]);
            label_depths[num_label]++;
        }
        else if (sscanf(rest_of_line, "JMP LBL%d", &num_label) == 1)
        {
            fprintf(code_assembleur, "JMP %d\n", labels[num_label][label_depths[num_label]]);
            // printf("num_label: %d, label_depth: %d, value: %d\n", num_label, label_depths[num_label], labels[num_label][label_depths[num_label]]);
            label_depths[num_label]++;
        }
        else
        {
            fprintf(code_assembleur, "%s", rest_of_line);
        }
    }
}

void parser_label()
{

    code_assembleur = fopen("assembleur.txt", "r");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }
    tmp = fopen("tmp.txt", "w+");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }

    for (int i = 0; i < 20; i++)
    {
        label_depths[i] = 0;
    }
    parse_code();
    fclose(code_assembleur);
    code_assembleur = fopen("assembleur.txt", "w");
    if (code_assembleur == NULL)
    {
        printf("Erreur d'ouverture\n");
    }
    rewind(code_assembleur);
    rewind(tmp);
    for (int i = 0; i < 20; i++)
    {
        label_depths[i] = 0;
    }
    replace_labels();
    fclose(tmp);
    fclose(code_assembleur);

    if (remove("tmp.txt") != 0)
    {
        perror("Erreur de suppression du fichier tmp.txt");
    }
}

int main()
{
    parser_label();
    return 0;
}