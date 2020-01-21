with p_fenbase, forms, p_virus; use p_fenbase, forms, p_virus;

package p_vuegraph is
    
    procedure AffichefGrille(f : in out TR_Fenetre; Grille : TV_Grille);

    procedure RefreshfGrille(f : in out TR_Fenetre; Grille : TV_Grille);
    
end p_vuegraph;