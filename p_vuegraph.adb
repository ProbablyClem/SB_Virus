with text_io, ada.strings.unbounded; use text_io, ada.strings.unbounded;

package body p_vuegraph is

    procedure AffichefGrille(f : in out TR_Fenetre; grille : in TV_Grille) is
        largeur, hauteur : natural;
    begin
        largeur := 700;
        hauteur := 500;
        f := DebutFenetre("Virus", largeur, hauteur);
        
        AjouterTexte(f, "background", "", 0, 0, largeur, hauteur);
        ChangerCouleurFond(f, "background", FL_RIGHT_BCOL);
        --ChangerEtatBouton(f, "background", arret);
        
        AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
        AjouterBouton(f, "boutonReset", "Recommencer", largeur - 80 - 135, 15, 120, 30);

        AjouterTexte(f,"fondGrille1", "", (largeur - (hauteur - 160)) / 2 - 2, 78, hauteur - 156, hauteur - 156);
        ChangerCouleurFond(f, "fondGrille1", FL_WHITE);

        AjouterTexte(f,"fondGrille2", "", (largeur - (hauteur - 160)) / 2, 80, hauteur - 160, hauteur - 160);
        ChangerCouleurFond(f, "fondGrille2", FL_RIGHT_BCOL);
        --ChangerEtatBouton(f, "boutonFond", arret);

        AjouterTexte(f,"colorCase","", largeur-110 , hauteur / 2 + 90, 65, 65);
        CacherElem(f, "colorCase");

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
                                  "",
                                  (largeur - (hauteur-160)) / 2 + (T_col'pos(c) - 65) * (hauteur - 160)/7,
                                  80 + (l - 1) * (hauteur - 160)/7,
                                  (hauteur - 160)/7,
                                  (hauteur - 160)/7);
                end if;
            end loop;
        end loop;
        MontrerFenetre(f);
    end AffichefGrille;

    procedure AffichefMenu(f : in out TR_Fenetre; pseudo : out unbounded_string; niveau : out natural) is
    largeur : natural := 700;
    hauteur : natural := 500;

        procedure getNiveau is
            valBouton : unbounded_string;
        begin
            valBouton := to_unbounded_string(AttendreBouton(f));
               put_line(to_string(valBouton));

            if to_string(valBouton) = "boutonJouer" then
                if ConsulterContenu(f, "inputNiveau") = "" then
                    cacherElem(f, "warningPseudo");
                    raise Ex_niveau;
                elsif ConsulterContenu(f, "inputPseudo") = "" then
                    cacherElem(f, "warningNiveau");
                    raise Ex_pseudo;
                else niveau := natural'value(ConsulterContenu(f, "inputNiveau"));
                end if;
            elsif to_string(valBouton) = "boutonQuitter" then
                raise Ex_Quitter;
            else getNiveau;
            end if;
            

            exception
                when Ex_niveau =>
                    MontrerElem(f, "warningNiveau");
                    if ConsulterContenu(f, "inputPseudo") = "" then
                        raise Ex_pseudo;
                    end if;
                    getNiveau;
                when Ex_pseudo =>
                    MontrerElem(f, "warningPseudo");
                    getNiveau;

        end getNiveau;

    begin
    f := DebutFenetre("Menu", largeur, hauteur);

        AjouterBouton(f, "background", "", 0, 0, largeur-2, hauteur-2);
        ChangerCouleurFond(f, "background", FL_RIGHT_BCOL);
        ChangerEtatBouton(f, "background", arret);

        AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
        AjouterBouton(f, "boutonJouer","Jouer", largeur/2 - 70/2, 130, 70, 30); 
        AjouterChamp(f, "inputPseudo","Pseudo","Invite", largeur/2 - 130/2, 50, 130, 30);
        AjouterChamp(f, "inputNiveau", "niveau", "", largeur/2 - 70/2, 90, 70, 30);
        AjouterTexte(f, "warningNiveau", "Veuillez rentrer un niveau entre 1 et 20", largeur/2 + 45, 90, 280, 30);
        AjouterTexte(f, "warningPseudo", "Veuillez rentrer un pseudo", largeur/2 + 75, 50, 280, 30);
        ChangerCouleurTexte(f, "warningNiveau", FL_RED);
        ChangerCouleurTexte(f, "warningPseudo", FL_RED);
        cacherElem (f, "warningNiveau");
        cacherElem (f, "warningPseudo");
        ChangerCouleurTexte(f, "inputPseudo", FL_WHITE);
        ChangerCouleurTexte(f, "inputNiveau", FL_WHITE);
        ChangerCouleurTexte(f, "boutonJouer", FL_WHITE);
        ChangerCouleurFond(f, "boutonJouer", FL_RIGHT_BCOL);
        ChangerCouleurFond(f, "warningNiveau", FL_RIGHT_BCOL);
        ChangerCouleurFond(f, "warningPseudo", FL_RIGHT_BCOL);
        MontrerFenetre(f);

    getNiveau;
    put_line(natural'image(niveau));
    pseudo := to_unbounded_string(ConsulterContenu(f, "inputPseudo"));
    end AffichefMenu;

    procedure RefreshfGrille(f : in out TR_Fenetre; grille : TV_Grille) is
    begin
        for i in grille'range(1) loop
            for y in grille'range(2) loop
                ChangerCouleurFond(f,"bg" & t_lig'image(i)(2..2) & y , FL_INACTIVE);

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

            showMoves(f, grille, coul);
        
        elsif btnStr(1..2) = "mv" then

            MajGrille(grille, coul, T_direction'value(btnStr(3..4)));
            showMoves(f, grille, coul);
            AfficheGrille(grille);
            RefreshfGrille(f, grille);
            if Guerison(grille) then
                raise EX_GG;
            end if;

        else
                if btnStr = "boutonQuitter" then
                    raise EX_Quitter;
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

    procedure showmoves (f: in out TR_Fenetre; grille: in TV_Grille; coul: in T_coul) is
    begin
        MontrerElem(f, "colorCase");
        ChangerCouleurFond(f, "colorCase", couleurs(coul));
        for i in 0..3 loop
            MontrerElem(f, "mv" & T_direction'image(T_direction'val(i)));
            if Possible(grille, coul, T_direction'val(i)) then
                ChangerCouleurFond(f, "mv" & T_direction'image(T_direction'val(i)), FL_TOP_BCOL);
                ChangerEtatBouton(f, "mv" & T_direction'image(T_direction'val(i)), marche);
            else
                ChangerCouleurFond(f, "mv" & T_direction'image(T_direction'val(i)), FL_INACTIVE);
                ChangerEtatBouton(f, "mv" & T_direction'image(T_direction'val(i)), arret);
            end if;
        end loop;
    end showmoves;

    procedure affichefGG(lvl: in positive) is
        f : TR_fenetre;
    begin
        f := DebutFenetre("GG", 400, 300);

        AjouterTexte(f, "titreGG", "Bravo !", 0, 0, 400, 125);
        
        AjouterTexte(f, "txtGG", "Vous avez battu le niveau" & positive'image(lvl), 0, 125, 400, 50);

        AjouterBouton(f, "btnGG", "Merci", 160, 200, 80 , 40);

        FinFenetre(f);
    end affichefGG;

end p_vuegraph;