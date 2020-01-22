with text_io, ada.strings.unbounded, forms; use text_io, ada.strings.unbounded, forms;

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
        AjouterBouton(f,"boutonMenu","Menu", 15 , 15, 70, 30);

        AjouterTexte(f,"fondGrille1", "", (largeur - (hauteur - 160)) / 2 - 2, 78, hauteur - 156, hauteur - 156);
        ChangerCouleurFond(f, "fondGrille1", FL_WHITE);

        AjouterTexte(f,"fondGrille2", "", (largeur - (hauteur - 160)) / 2, 80, hauteur - 160, hauteur - 160);
        ChangerCouleurFond(f, "fondGrille2", FL_RIGHT_BCOL);
        --ChangerEtatBouton(f, "boutonFond", arret);

        AjouterTexte(f,"colorCase","", largeur-110 , hauteur / 2 + 90, 65, 65);
        CacherElem(f, "colorCase");

        AjouterBouton(f, "mvHG", "", largeur-155, hauteur / 2 - 75, 70, 70);
        AjouterImage(f, "imgHG", "img/HG.xpm", "", largeur-145, hauteur / 2 - 65, 50, 50);
        AjouterBouton(f, "mvHD", "", largeur-75, hauteur / 2 - 75, 70, 70);
        AjouterImage(f, "imgHD", "img/HD.xpm", "", largeur-65, hauteur / 2 - 65, 50, 50);
        AjouterBouton(f, "mvBG", "", largeur-155, hauteur / 2 + 5, 70, 70);
        AjouterImage(f, "imgBG", "img/BG.xpm", "", largeur-145, hauteur / 2 + 15, 50, 50);
        AjouterBouton(f, "mvBD", "", largeur-75, hauteur / 2 + 5, 70, 70);
        AjouterImage(f, "imgBD", "img/BD.xpm", "", largeur-65, hauteur / 2 + 15, 50, 50);


        for i in 0..3 loop
            put_line("cache '" & "mv" & T_direction'image(T_direction'val(i)) & "'");
            CacherElem(f, "mv" & T_direction'image(T_direction'val(i)));
            CacherElem(f, "img" & T_direction'image(T_direction'val(i)));
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
        largeur : natural := 1200;
        hauteur : natural := 1000;
        fond: T_Couleur := FL_RIGHT_BCOL;

        procedure getNiveau is
            valBouton : unbounded_string;
        begin
            valBouton := to_unbounded_string(AttendreBouton(f));
               put_line(to_string(valBouton));

            if to_string(valBouton)(1..3) = "cfg" then
                if ConsulterContenu(f, "inputPseudo") = "" then
                    raise Ex_pseudo;
                else
                    niveau := integer'value(to_string(valBouton)(4..to_string(valBouton)'last));
                end if;
            elsif to_string(valBouton) = "boutonQuitter" then
                raise Ex_Quitter;
            else getNiveau;
            end if;

            put_line(integer'image(niveau));

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

        AjouterTexte(f, "background", "", 0, 0, largeur, hauteur);
        ChangerCouleurFond(f, "background", fond);

        AjouterTexte(f, "titre", "Anti-Virus", 0, 0, largeur, 120);
        ChangerCouleurTexte(f, "titre", FL_WHITE);
        ChangerCouleurFond(f, "titre", fond);
        ChangerTailleTexte(f, "titre", 60);
        ChangerAlignementTexte(f, "titre", FL_ALIGN_CENTER);

        AjouterChamp(f, "inputPseudo", "", "Invite", largeur/2 + 10, 140, 200, 60);
        ChangerTailleTexte(f, "inputPseudo", 30);

        AjouterTexte(f, "txtPseudo", "Pseudo :", 0, 140, largeur/2 - 10, 60);
        ChangerCouleurTexte(f, "txtPseudo", FL_CYAN);
        ChangerCouleurFond(f, "txtPseudo", fond);
        ChangerTailleTexte(f, "txtPseudo", 30);
        ChangerAlignementTexte(f, "txtPseudo", FL_ALIGN_RIGHT);

        AjouterTexte(f, "lvlTitre", "Niveaux", 0, 220, largeur, 40);
        ChangerCouleurTexte(f, "lvlTitre", FL_WHITE);
        ChangerCouleurFond(f, "lvlTitre", fond);
        ChangerTailleTexte(f, "lvlTitre", 30);
        ChangerAlignementTexte(f, "lvlTitre", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlS", "Starter", 0, 280, largeur, 40);
        ChangerCouleurTexte(f, "lvlS", FL_GREEN);
        ChangerCouleurFond(f, "lvlS", fond);
        ChangerTailleTexte(f, "lvlS", 24);
        ChangerAlignementTexte(f, "lvlS", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlJ", "Junior", 0, 460, largeur, 40);
        ChangerCouleurTexte(f, "lvlJ", FL_DODGERBLUE);
        ChangerCouleurFond(f, "lvlJ", fond);
        ChangerTailleTexte(f, "lvlJ", 24);
        ChangerAlignementTexte(f, "lvlJ", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlE", "Expert", 0, 640, largeur, 40);
        ChangerCouleurTexte(f, "lvlE", FL_RED);
        ChangerCouleurFond(f, "lvlE", fond);
        ChangerTailleTexte(f, "lvlE", 24);
        ChangerAlignementTexte(f, "lvlE", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlW", "Wizard", 0, 820, largeur, 40);
        ChangerCouleurTexte(f, "lvlW", FL_MAGENTA);
        ChangerCouleurFond(f, "lvlW", fond);
        ChangerTailleTexte(f, "lvlW", 24);
        ChangerAlignementTexte(f, "lvlW", FL_ALIGN_CENTER);

        for i in 1..20 loop
            AjouterBouton(f,
                          "cfg" & integer'image(i)(2..integer'image(i)'last),
                          "",
                          260 + (((i - 1) mod 5)) * 140 ,
                          330 + ((i- 1) / 5) * 180,
                          120,
                          120
                          );
            AjouterImage(f,
                        "img" & integer'image(i)(2..integer'image(i)'last),
                        "img/lvl" & integer'image(i)(2..integer'image(i)'last) & ".xpm",
                        "",
                        260 + (((i - 1) mod 5)) * 140 ,
                        330 + ((i- 1) / 5) * 180,
                        120,
                        120);
        end loop;

        AjouterBouton(f,"boutonQuitter","Quitter", largeur - 155 , 15, 140, 60);
        ChangerCouleurFond(f, "boutonQuitter", FL_WHITE);
        ChangerTailleTexte(f, "boutonQuitter", 20);

        AjouterTexte(f, "warningPseudo", "Veuillez rentrer un pseudo", largeur/2 + 75, 50, 280, 30);
        ChangerCouleurTexte(f, "warningPseudo", FL_RED);
        cacherElem (f, "warningPseudo");
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

    function detectButton (f: in out TR_Fenetre; btnStr: string; grille: in out TV_Grille; coul: in out T_coul) return unbounded_string is
    
        c : T_col;
        l : T_lig;

    begin
        put_line("'" & btnStr & "'");

        -- Il est obligatoire de mettre btnStr'first pour le compilateur sous peine de warning

        if btnStr(btnStr'first..(btnStr'first+1)) = "bg" then
            l := T_lig'value(btnStr((btnStr'first+2)..(btnStr'first+2)));
            put_line("l =" & T_lig'image(l));
            c := btnStr((btnStr'first+3));
            put_line("c =" & T_col'image(c));
            put_line(T_coul'image(grille(l, c)));
            put_line("---");

            coul := grille(l, c);

            selectPiece(f, grille, coul);

            showMoves(f, grille, coul); 
        
        elsif btnStr(btnStr'first..(btnStr'first+1)) = "mv" then

            MajGrille(grille, coul, T_direction'value(btnStr((btnStr'first+2)..(btnStr'first+3))));
            showMoves(f, grille, coul);
            AfficheGrille(grille);
            RefreshfGrille(f, grille);
            if Guerison(grille) then
                return to_unbounded_string("GG");
            end if;

        else
                if btnStr = "boutonQuitter" then
                    return to_unbounded_string("quit");
                elsif btnStr = "boutonMenu" then
                    return to_unbounded_string("menu");
                elsif btnStr = "boutonReset" then
                    return to_unbounded_string("reset");
                else
                    put_line("pas encore implémenté");
                end if;
        
        end if;

        return to_unbounded_string("");
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
                MontrerElem(f, "img" & T_direction'image(T_direction'val(i)));
            else
                ChangerCouleurFond(f, "mv" & T_direction'image(T_direction'val(i)), FL_INACTIVE);
                ChangerEtatBouton(f, "mv" & T_direction'image(T_direction'val(i)), arret);
                CacherElem(f, "img" & T_direction'image(T_direction'val(i)));
            end if;
        end loop;
    end showmoves;

    procedure affichefGG(lvl: in positive) is
        f : TR_fenetre;
    begin
        f := DebutFenetre("GG", 400, 300);

        AjouterTexte(f, "titreGG", "Bravo !", 0, 0, 400, 125);
        ChangerTailleTexte(f, "titreGG", FL_HUGE_SIZE);
        ChangerAlignementTexte(f, "titreGG", FL_ALIGN_CENTER);

        AjouterTexte(f, "txtGG", "Vous avez battu le niveau" & positive'image(lvl), 0, 125, 400, 50);
        ChangerTailleTexte(f, "txtGG", FL_MEDIUM_SIZE);
        ChangerAlignementTexte(f, "txtGG", FL_ALIGN_CENTER);

        AjouterBouton(f, "btnGG", "Merci", 145, 200, 120 , 60);
        ChangerTailleTexte(f, "btnGG", FL_LARGE_SIZE);

        MontrerFenetre(f);
        while AttendreBouton(f) /= "btnGG" loop
            null;
        end loop;
        CacherFenetre(f);
    end affichefGG;

end p_vuegraph;