with text_io; use text_io;
package body p_virus is
    
    procedure InitPartie(Grille: in out TV_Grille; Pieces: in out TV_Pieces) is
    --{} => {Tous les éléments de Grilleont été initialisés avec la couleur vide
    --      y compris les cases inutilisables
    --      Tous les éléments de Pieces ont été initialisés à false}
    begin
        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                Grille(i,y) := Vide;
            end loop;
        end loop;

        for i in Pieces'range loop
            Pieces(i) := false;
        end loop;
    end InitPartie;
    --hmm

    procedure Configurer(f : in out p_piece_io.file_type; nb : in positive; Grille: in out TV_Grille; Pieces: in out TV_Pieces) is
    --  {f ouvert, nb est un numéro de configuration (appelé numéro de partie),
    --  une configuration décrit le placement des pièces du jeu, pour chaque configuration:
    --      * les éléments d’une même pièce (même couleur) sont stockés consécutivement 
    --      * il n’y a pas deux pièces mobiles ayant la même couleur 
    --      *les deux éléments constituant le virus (couleur rouge)terminent la configuration}
    --  =>  {Grillea été mis à jour par lecture dans f de la configuration de numéro nb
    --          Pieces a été initialisé en fonction des pièces de cette configuration}
    begin
        -- à compléter
    end Configurer;

    --pour test configuration... 
    procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP) is
    --{} => {la position de la pièce de couleur coul a été affichée si cette pièce est dans Grille
    --       exemple: ROUGE: F4 G5}
    begin
        put(Grille(i, y));
        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if Grille(i, y) = coul then
                    put(Grille(i, y));
                end if;
            end loop;
        end loop;
        new_line;
    end PosPiece;
    
    ---------------Contrôledu jeu
    function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean is
    --  {coul/= blanc} 
    --=> {résultat= vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}
    begin
        -- à compléter
    end Possible;


    procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction) is
    --  {la pièce de couleur coul peut être déplacéedans la direction Dir} 
    --=> {Grillea été mis à jour suite au déplacement}
    begin
        -- à compléter
    end MajGrille;

    function Guerison(Grille: in TV_Grille) return boolean is
    --{} => {résultat = le virus (pièce rouge) est prêt à sortir (position coin haut gauche)}
    begin
        -- à compléter

        return false; -- à enlever
    end Guerison;

end p_virus;