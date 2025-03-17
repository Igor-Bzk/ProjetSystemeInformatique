typedef struct symbole
{
    char *nom;
    int profondeur;
} symbole;

symbole symboles[16];
int profondeur_courante = 0;
int indexe = 0;

void decrementer_profondeur();
void add_symbole(char *nom);
void incrementer_profondeur();
int get_pofondeur_symbole(char *nom);