with p_vuetxt; use p_vuetxt;
with p_fenbase, forms, p_virus, ada.strings.unbounded; use p_fenbase, forms, p_virus, ada.strings.unbounded;

package p_vuegraph is
    
    type TV_Couleurs is array(t_coulP) of T_Couleur;
    couleurs : constant TV_Couleurs := (FL_RED, FL_CYAN, FL_DARKORANGE, FL_DEEPPINK, FL_DARKTOMATO, FL_BLUE, FL_DARKVIOLET, FL_GREEN, FL_YELLOW, FL_WHITE);

    type TR_Deplacement is record
        coul: T_coul;
        dir: T_Direction;
    end record;
    type TV_Deplacement is array (natural range <>) of TR_Deplacement;

    EX_GG: Exception;
    EX_Quitter : exception;
    EX_Pseudo: exception;
    EX_Niveau : exception;

    procedure AffichefGrille(f : in out TR_Fenetre; Grille : TV_Grille);

    procedure AffichefMenu(f : in out TR_Fenetre; pseudo: out unbounded_string; niveau : out natural);

    procedure RefreshfGrille(f : in out TR_Fenetre; Grille : TV_Grille; score : in out natural);

    function detectButton (f: in out TR_Fenetre; btnStr: string; grille: in out TV_Grille; coul: in out T_coul; score : in out natural; moves: in out TV_Deplacement; indMoves: in out natural) return unbounded_string;

    procedure selectPiece (f: in out TR_Fenetre; grille: in TV_Grille; coul: in T_coul);

    procedure showmoves (f: in out TR_Fenetre; grille: in TV_Grille; coul: in T_coul);

    procedure affichefGG (lvl: in positive);

    procedure affichefAide;

    procedure reset (f: in out p_piece_io.file_type; fgrille: in out TR_Fenetre; grille: in out TV_Grille; pieces: in out TV_Pieces; lvl: in positive; indMoves: in out natural; score : in out natural);

    procedure addMove (moves: in out TV_Deplacement; indMoves: in out natural; deplacement: in TR_Deplacement);

    function removeLastMove (indMoves: in out natural) return boolean;

end p_vuegraph;