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

void set_val(table_symbole *table, char *nom, int val);
int get_val(table_symbole *table, char *nom);
void push(table_symbole *table, symbole *symb);
symbole pop(table_symbole *table);
