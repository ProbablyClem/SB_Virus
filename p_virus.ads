with sequential_io; with p_esiut; use p_esiut;

package p_virus is


    ---------------Types pour représenter lagrille de jeu

    subtype T_Col is character range 'A'..'G';
    subtype T_Lig is integer range 1..7;
    type T_Coul is (rouge, turquoise, orange, rose, marron, bleu, violet, vert, jaune, blanc, vide);

    type TV_Grille is array (T_lig, T_col) of T_Coul;

    ---------------Types pour représenter les pièces du jeu

    subtype T_CoulP is T_Coul range rouge..blanc;  --couleurs des pièces
    package p_coul_io is new p_enum(T_CoulP); use p_coul_io;
    type TV_Coul is array (T_Coul range rouge..blanc) of natural;
    colors : constant TV_Coul := (9,     14,        214,    219,  94,     110,  99,     106,  178,   15);
    --                            rouge, turquoise, orange, rose, marron, bleu, violet, vert, jaune, blanc

    type TR_ElemP is record --un élément constituant une pièce
        colonne:T_Col;  --la colonne qu’il occupe dans la grille
        ligne:T_Lig;  --la ligne qu’il occupe dans la grille
        couleur:T_CoulP;   --sa couleur
    end record;
    
    type TV_Pieces is array(T_coulP) of boolean;
  
  ----Instanciation de sequential_io pour un fichier de TR_ElemP;
    package p_piece_io is new sequential_io(TR_ElemP);  use p_piece_io;
  
  ----type pour la direction de déplacementdes pièces
    type T_Direction is (bg, hg, bd, hd);
    package p_dir_io is new p_enum(T_Direction); use p_dir_io;

  ----Exeptions   
      EX_NumConfig : Exception;
    
    ---------------Primitives d’initialisation d’une partie

    procedure InitPartie(Grille: in out TV_Grille; Pieces: in out TV_Pieces);
    --{} => {Tous les éléments de Grilleont été initialisés avec la couleur vide
    --      y compris les cases inutilisables
    --      Tous les éléments de Pieces ont été initialisés à false}
    
    procedure Configurer(f : in out p_piece_io.file_type; nb : in positive; Grille:in out TV_Grille; Pieces: in out TV_Pieces);
    --  {f ouvert, nb est un numéro de configuration (appelé numéro de partie),
    --  une configuration décrit le placement des pièces du jeu, pour chaque configuration:
    --      * les éléments d’une même pièce (même couleur) sont stockés consécutivement 
    --      * il n’y a pas deux pièces mobiles ayant la même couleur 
    --      *les deux éléments constituant le virus (couleur rouge)terminent la configuration}
    --  =>  {Grillea été mis à jour par lecture dans f de la configuration de numéro nb
    --          Pieces a été initialisé en fonction des pièces de cette configuration}

    --pour test configuration... 
    procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP);
    --{} => {la position de la pièce de couleur coul a été affichée si cette pièce est dans Grille
    --       exemple: ROUGE: F4 G5}
    
    ---------------Contrôledu jeu
    function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean;
    --  {coul/= blanc} 
    --=> {résultat= vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}
    
    procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction);
    --  {la pièce de couleur coul peut être déplacéedans la direction Dir} 
    --=> {Grillea été mis à jour suite au déplacement}

    function Guerison(Grille: in TV_Grille) return boolean;
    --{} => {résultat = le virus (pièce rouge) est prêt à sortir (position coin haut gauche)}
    
end p_virus;