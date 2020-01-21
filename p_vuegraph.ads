with p_vuetxt; use p_vuetxt;
with p_fenbase, forms, p_virus, ada.strings.unbounded; use p_fenbase, forms, p_virus, ada.strings.unbounded;

package p_vuegraph is
    
    type TV_Couleurs is array(t_coulP) of T_Couleur;
    couleurs : constant TV_Couleurs := (FL_RED, FL_CYAN, FL_DARKORANGE, FL_DEEPPINK, FL_DARKTOMATO, FL_BLUE, FL_DARKVIOLET, FL_GREEN, FL_YELLOW, FL_WHITE);

    Quitter : exception;

    procedure AffichefGrille(f : in out TR_Fenetre; Grille : TV_Grille);

    function AffichefMenu(f : in out TR_Fenetre; pseudo: out unbounded_string; niveau : out natural) return boolean;

    procedure RefreshfGrille(f : in out TR_Fenetre; Grille : TV_Grille);
    
    procedure detectButton (f: in out TR_Fenetre; btnStr: string; grille: in out TV_Grille; coul: in out T_coul);

    procedure selectPiece (f: in out TR_Fenetre; grille: in TV_Grille; coul: in T_coul);

    procedure showmoves (f: in out TR_Fenetre);

end p_vuegraph;