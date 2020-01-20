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

        Pieces := (others => false);
        
    end InitPartie;

    procedure Configurer(f : in out p_piece_io.file_type; nb : in positive; Grille: in out TV_Grille; Pieces: in out TV_Pieces) is
    --  {f ouvert, nb est un numéro de configuration (appelé numéro de partie),
    --  une configuration décrit le placement des pièces du jeu, pour chaque configuration:
    --      * les éléments d’une même pièce (même couleur) sont stockés consécutivement 
    --      * il n’y a pas deux pièces mobiles ayant la même couleur 
    --      *les deux éléments constituant le virus (couleur rouge)terminent la configuration}
    --  =>  {Grille a été mis à jour par lecture dans f de la configuration de numéro nb
    --          Pieces a été initialisé en fonction des pièces de cette configuration}
        procedure estRouge (elem: in TR_elemP; i: in out natural) is
        -- on test si la pièce est rouge, si oui, on incrémente i
        begin
            if elem.couleur = rouge then
                i := i + 1;
            end if;
        end estRouge;
        
        elem: TR_elemP;
        i: natural := 0; -- variable destinée à compter les pieces rouges
        j: natural := 1;

    begin

        reset(f);

        while i < (nb-1)*2 loop -- on skip les configs précédentes
            read(f, elem);
            estRouge(elem, i);
        end loop;

        i := 0;

        loop
            read(f, elem);
            
            Grille(elem.ligne, elem.colonne) := elem.couleur; -- on ajoute la pièce à la grille
            Pieces(elem.couleur) := true; -- la piece existe

            estRouge(elem, i);
        exit when i = 2;
        end loop;

    end Configurer;

    --pour test configuration... 
    procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP) is
    --{} => {la position de la pièce de couleur coul a été affichée si cette pièce est dans Grille
    --       exemple: ROUGE: F4 G5}
    begin
        ecrire(coul); ecrire(": ");
        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if Grille(i, y) = coul then
                    ecrire(y);
                    ecrire(t_lig'image(i));
                    ecrire(", ");
                end if;
            end loop;
        end loop;
        a_la_ligne;
    end PosPiece;
    
    ---------------Contrôle du jeu
    function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean is
    --  {coul/= blanc} 
    --=> {résultat= vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}

        compteurCouleur : natural := 0; --nombre d'elements de la couleur coul
        elementsBon : natural := 0; --nombre d'elemnts de la couleur coul qui peuvent se deplacer
    begin
        if coul = blanc then
            return false;
        end if;

        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if Grille(i, y) = coul then
                    compteurCouleur := compteurCouleur +1;
                end if;
            end loop;
        end loop;

        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if Grille(i, y) = coul then
                    case Dir is
                    when bg => 
                        if (i /= t_lig'last and y /= t_col'first) and then ((Grille(i+1, T_col'pred(y)) = vide or Grille(i+1, T_col'pred(y)) = coul)) then
                            elementsBon := elementsBon +1;
                        end if;
                    when hg =>
                        if (i /= t_lig'first and y /= t_col'first) and then ((Grille(i-1, t_col'pred(y)) = vide or Grille(i-1, t_col'pred(y)) = coul)) then
                            elementsBon := elementsBon +1;
                        end if;
                    when bd =>
                        if (i /= t_lig'last and y /= t_col'last) and then  ((Grille(i+1, t_col'succ(y)) = vide or Grille(i+1, t_col'succ(y)) = coul)) then
                            elementsBon := elementsBon +1;
                        end if;
                    when hd =>
                        if (i /= t_lig'first and y /= t_col'last) and then ((Grille(i-1, t_col'succ(y)) = vide or Grille(i-1, t_col'succ(y)) = coul)) then
                            elementsBon := elementsBon +1;
                        end if;
                    when others => null;
                    end case;
                end if;

                if compteurCouleur = elementsBon then
                    return true;
                end if;
            end loop;
        end loop;
        return false;

    exception 
      when CONSTRAINT_ERROR => return false;
    end Possible;


    procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction) is
    --  {la pièce de couleur coul peut être déplacéedans la direction Dir} 
    --=> {Grillea été mis à jour suite au déplacement}
    baseGrille : TV_Grille := grille;
    begin
        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if baseGrille(i, y) = coul then
                    case Dir is
                    when bg => 
                        Grille(i+1, T_col'pred(y)) := baseGrille(i, y);
                        Grille(i, y) := vide;
                    when hg =>
                        Grille(i-1, t_col'pred(y)) := baseGrille(i, y);
                        Grille(i, y) := vide;
                    when bd =>
                        Grille(i+1, t_col'succ(y)) := baseGrille(i, y);
                        Grille(i, y) := vide;
                    when hd =>
                        Grille(i-1, t_col'succ(y)) := baseGrille(i, y);
                        Grille(i, y) := vide;
                    when others => null;
                    end case;
                end if;
            end loop;
        end loop;

    exception
        when CONSTRAINT_ERROR => ecrire("erreur de merde");
    end MajGrille;

    function Guerison(Grille: in TV_Grille) return boolean is
    --{} => {résultat = le virus (pièce rouge) est prêt à sortir (position coin haut gauche)}
    begin
        if Grille(1, 'A') = rouge then
            return true;
        else 
            return false;
        end if;
    end Guerison;

end p_virus;