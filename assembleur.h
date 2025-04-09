

// Ouvre le fichier assembleur.txt en écriture
void ouvrir(void);

// Ferme le fichier assembleur et corrige les labels
void fermer(void);

// Ajoute un label nommé dans le fichier
void add_label_named(const char* label_name);

// Génére une instruction JMF avec un label symbolique
void if_not_goto(int cond, const char* label_name);
void else_goto(const char* label_name);
void corriger_labels(const char* nom_fichier);

