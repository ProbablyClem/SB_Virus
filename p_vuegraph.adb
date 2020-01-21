with text_io, ada.strings.unbounded; use text_io, ada.strings.unbounded;

package body p_vuegraph is

    procedure AffichefGrille(f : in out TR_Fenetre; grille : in TV_Grille) is
        largeur, hauteur : natural;
    begin
        largeur := 700;
        hauteur := 500;
        f := DebutFenetre("Virus", largeur, hauteur);
        
        AjouterBouton(f, "background", "", 0, 0, largeur-2, hauteur-2);
        ChangerCouleurFond(f, "background", FL_RIGHT_BCOL);
        ChangerEtatBouton(f, "background", arret);
        
        AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
        AjouterBouton(f, "boutonReset", "Recommencer", largeur - 80 - 135, 15, 120, 30);

        AjouterBouton(f,"boutonFond", "", (largeur - (hauteur - 160)) / 2, 80, hauteur - 160, hauteur - 160);
        ChangerCouleurFond(f, "boutonFond", FL_BLACK);
        ChangerEtatBouton(f, "boutonFond", arret);

        AjouterBouton(f, "mvHG", "HG", largeur-155, hauteur / 2 - 75, 70, 70);
        AjouterBouton(f, "mvHD", "HD", largeur-75, hauteur / 2 - 75, 70, 70);
        AjouterBouton(f, "mvBG", "BG", largeur-155, hauteur / 2 + 5, 70, 70);
        AjouterBouton(f, "mvBD", "BD", largeur-75, hauteur / 2 + 5, 70, 70);

        for i in 0..3 loop
            put_line("cache '" & "mv" & T_direction'image(T_direction'val(i)) & "'");
            CacherElem(f, "mv" & T_direction'image(T_direction'val(i)));
        end loop;



        for c in T_col'range loop
            for l in T_lig'range loop
                if (T_col'pos(c) mod 2) = (T_lig'pos(l) mod 2) then
                    AjouterBouton(f,
                                  "bg" & T_lig'image(l)(2..2) & c,
                                  T_lig'image(l)(2..2) & c,
                                  (largeur - (hauteur-160)) / 2 + (T_col'pos(c) - 65) * (hauteur - 160)/7,
                                  80 + (l - 1) * (hauteur - 160)/7,
                                  (hauteur - 160)/7,
                                  (hauteur - 160)/7);
                end if;
            end loop;
        end loop;
        MontrerFenetre(f);
    end AffichefGrille;

    function AffichefMenu(f : in out TR_Fenetre; pseudo : out unbounded_string; niveau : out natural) return boolean is
    largeur : natural := 700;
    hauteur : natural := 500;
    niveauBool : boolean := true;

        procedure getNiveau (returnBool : out boolean) is

        begin
            while AttendreBouton(f) /= "boutonJouer" loop
                if AttendreBouton(f) = "boutonQuitter" then
                    returnBool := false;      
                end if;
            end loop;

            if AttendreBouton(f) = "boutonJouer" then
                niveau := natural'value(ConsulterContenu(f, "inputNiveau"));
                returnBool := true;
            end if;
            

            exception
                when CONSTRAINT_ERROR =>
                    MontrerElem(f, "warningMessage");
                    put_line("CONSTRAINT_ERROR");
                    getNiveau(niveauBool);
        end getNiveau;

    begin
    f := DebutFenetre("Menu", largeur, hauteur);

        AjouterBouton(f, "background", "", 0, 0, largeur-2, hauteur-2);
        ChangerCouleurFond(f, "background", FL_RIGHT_BCOL);
        ChangerEtatBouton(f, "background", arret);

        AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
        AjouterBouton(f, "boutonJouer","Jouer", largeur/2 - 70/2, 130, 70, 30); 
        AjouterChamp(f, "inputPseudo","Pseudo","", largeur/2 - 130/2, 50, 130, 30);
        AjouterChamp(f, "inputNiveau", "niveau", "", largeur/2 - 70/2, 90, 70, 30);
        AjouterTexte(f, "warningMessage", "Veulliez rentrer un niveau entre 1 et 20", largeur/2 + 45, 90, 280, 30);
        ChangerCouleurTexte(f, "warningMessage", FL_RED);
        cacherElem (f, "warningMessage");
        ChangerCouleurTexte(f, "inputPseudo", FL_WHITE);
        ChangerCouleurTexte(f, "inputNiveau", FL_WHITE);
        ChangerCouleurTexte(f, "boutonJouer", FL_WHITE);
        ChangerCouleurFond(f, "boutonJouer", FL_RIGHT_BCOL);
        ChangerCouleurFond(f, "warningMessage", FL_RIGHT_BCOL);
        MontrerFenetre(f);

    getNiveau(niveauBool);
    put_line(boolean'image(niveauBool));
    pseudo := to_unbounded_string(ConsulterContenu(f, "inputPseudo"));
    return niveauBool;
    end AffichefMenu;

    procedure RefreshfGrille(f : in out TR_Fenetre; grille : TV_Grille) is
    begin
        for i in grille'range(1) loop
            for y in grille'range(2) loop
                ChangerCouleurFond(f,"bg" & t_lig'image(i)(2..2) & y , FL_MCOL);

                if grille(i,y) = vide then
                    ChangerEtatBouton(f,"bg" & t_lig'image(i)(2..2) & y , arret);
                end if;
            end loop;
        end loop;


        for i in T_lig'range loop
            for y in T_col'range loop
                case Grille(i, y) is
                    when vide =>
                        if (T_lig'pos(i) mod 2) = (T_col'pos(y) mod 2) then
                            ChangerEtatBouton(f, "bg" & t_lig'image(i)(2..2) & y, arret);
                        end if;
                    when blanc =>
                        ChangerEtatBouton(f, "bg" & t_lig'image(i)(2..2) & y, arret);
                        ChangerCouleurFond(f, "bg" & t_lig'image(i)(2..2) & y, FL_WHITE);
                    when others =>
                        ChangerEtatBouton(f, "bg" & t_lig'image(i)(2..2) & y, marche);
                        ChangerCouleurFond(f, "bg" & t_lig'image(i)(2..2) & y, couleurs(grille(i,y)));
                end case;
            end loop;
        end loop;
    end RefreshfGrille;

    procedure detectButton (f: in out TR_Fenetre; btnStr: string; grille: in out TV_Grille; coul: in out T_coul) is
    
        c : T_col;
        l : T_lig;
        mv: T_direction;

    begin
        put_line("'" & btnStr & "'");

        if btnStr(1..2) = "bg" then
            l := T_lig'value(btnStr(3..3));
            put_line("l =" & T_lig'image(l));
            c := btnStr(4);
            put_line("c =" & T_col'image(c));
            put_line(T_coul'image(grille(l, c)));
            put_line("---");

            coul := grille(l, c);

            selectPiece(f, grille, coul);

            showMoves(f);
        
        elsif btnStr(1..2) = "mv" then

            MajGrille(grille, coul, T_direction'value(btnStr(3..4)));
            AfficheGrille(grille);
            RefreshfGrille(f, grille);

        else
                if btnStr = "boutonQuitter" then
                    raise Quitter;
                else
                    put_line("pas encore implémenté");
                    return;
                end if;
        
        end if;
    end detectButton;

    procedure selectPiece (f: in out TR_Fenetre; grille: in TV_Grille; coul: in T_coul) is
    begin
        for l in T_lig'range loop
            for c in T_col'range loop
                if grille(l, c) = vide then
                    null;
                elsif grille(l, c) = coul then
                    ChangerEtatBouton(f, "bg" & t_lig'image(l)(2..2) & c, arret);
                else
                    ChangerEtatBouton(f, "bg" & t_lig'image(l)(2..2) & c, marche);
                end if;
            end loop;
        end loop;
    end selectPiece;

    procedure showmoves (f: in out TR_Fenetre) is
    begin
        for i in 0..3 loop
            MontrerElem(f, "mv" & T_direction'image(T_direction'val(i)));
        end loop;
    end showmoves;

end p_vuegraph;