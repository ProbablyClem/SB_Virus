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
    --  =>  {Grille a été mis à jour par lecture dans f de la configuration de numéro nb
    --          Pieces a été initialisé en fonction des pièces de cette configuration}
        procedure test (elem: in TR_elemP; i: in out natural) is
        -- on test si la pièce est rouge, si oui, on incrémente i
        begin
            if elem.couleur = rouge then
                i := i + 1;
            end if;
        end test;
        
        elem: TR_elemP;
        i: natural := 0; -- variable destinée à compter les pieces rouges
        j: natural := 1;

    begin

        reset(f);

        while i < (nb-1)*2 and not end_of_file(f) loop -- on skip les configs précédentes
            read(f, elem);

            test(elem, i);
        end loop;

        if end_of_file(f) then
            raise CONSTRAINT_ERROR;
        end if;

        i := 0;

        loop
            read(f, elem);
            
            Grille(elem.lig, elem.col) := elem.couleur; -- on ajoute la pièce à la grille
            Pieces(j) := elem;

            test(elem, i);
            j := j + 1;
        exit when i = 2;
        end loop;

    exception
        when CONSTRAINT_ERROR =>
            put_line("Veuillez rentrer une configuration entre 1 et 20");

    end Configurer;

    --pour test configuration... 
    procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP) is
    --{} => {la position de la pièce de couleur coul a été affichée si cette pièce est dans Grille
    --       exemple: ROUGE: F4 G5}
    begin
        ecrire(coul);
        for i in Grille'range(1) loop
            for y in Grille'range(2) loop
                if Grille(i, y) = coul then
                    ecrire(Grille(i, y));
                    ecrire(' ');
                end if;
            end loop;
        end loop;
    end PosPiece;
    
    ---------------Contrôle du jeu
    function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean is
    --  {coul/= blanc} 
    --=> {résultat= vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}
    begin
        return false;
    end Possible;


    procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction) is
    --  {la pièce de couleur coul peut être déplacéedans la direction Dir} 
    --=> {Grillea été mis à jour suite au déplacement}
    begin
        return;
        -- à compléter
    end MajGrille;

    function Guerison(Grille: in TV_Grille) return boolean is
    --{} => {résultat = le virus (pièce rouge) est prêt à sortir (position coin haut gauche)}
    begin
        -- à compléter

        return false; -- à enlever
    end Guerison;

end p_virus;