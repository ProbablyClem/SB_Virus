with text_io; use text_io;
with p_virus; use p_virus;

package p_vuetxt is
    
    procedure AfficheGrille (Grille: in TV_Grille);
    --{} => {la grille a été affichée selon les spécifications suivantes :
    --      *la sortie est indiquée par la lettre S
    --      *une case inactive ne contient aucun caractère
    --      *une case de couleur vide contient un point
    --      *une case de couleur blanche contient le caractère F (Fixe)
    --      *une case de la couleur d’une pièce mobile contient le chiffre correspondant à la
    --       position de cette couleur dans le type T_Coul}

    procedure clear;

    procedure sautLigne (x: in positive);

end p_vuetxt;