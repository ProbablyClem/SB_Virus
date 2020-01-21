with p_fenbase, forms, p_virus; use p_fenbase, forms, p_virus;

package p_vuegraph is
    
    type TV_Couleurs is array(t_coulP) of T_Couleur;

    procedure AffichefGrille(f : in out TR_Fenetre; Grille : TV_Grille);

    procedure AffichefMenu(f : in out TR_Fenetre);

    procedure RefreshfGrille(f : in out TR_Fenetre; Grille : TV_Grille; couleurs : in TV_Couleurs);
    
end p_vuegraph;