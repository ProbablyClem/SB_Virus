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
        
        AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
        AjouterBouton(f, "boutonReset", "Recommencer", largeur - 80 - 135, 15, 120, 30);
        AjouterBouton(f,"boutonMenu","Menu", 15 , 15, 70, 30);

        AjouterBouton(f, "boutonRetour", "Annuler", largeur-130 , hauteur / 2 + 105, 105, 40);
        CacherElem(f, "boutonRetour");
        AjouterTexte(f, "errorRetour", "Aucun mouvement precedent", 0, 430, largeur, 50);
        ChangerAlignementTexte(f, "errorRetour", FL_ALIGN_CENTER);
        ChangerCouleurFond(f, "errorRetour", FL_RIGHT_BCOL);
        ChangerCouleurTexte(f, "errorRetour", FL_RED);
        ChangerTailleTexte(f, "errorRetour", 15);
        cacherElem(f, "errorRetour");

        AjouterBouton(f, "boutonAide","?", 30, hauteur - 50, 30, 30);

        AjouterTexte(f,"fondGrille1", "", (largeur - (hauteur - 160)) / 2 - 2, 78, hauteur - 156, hauteur - 156);
        ChangerCouleurFond(f, "fondGrille1", FL_WHITE);

        AjouterTexte(f,"fondGrille2", "", (largeur - (hauteur - 160)) / 2, 80, hauteur - 160, hauteur - 160);
        ChangerCouleurFond(f, "fondGrille2", FL_RIGHT_BCOL);
        --ChangerEtatBouton(f, "boutonFond", arret);

        AjouterTexte(f,"colorCase","", largeur-110 , hauteur / 2 - 155, 65, 65);
        CacherElem(f, "colorCase");

        AjouterBouton(f, "mvHG", "", largeur-155, hauteur / 2 - 75, 70, 70);
        AjouterImage(f, "imgHG", "img/HG.xpm", "", largeur-145, hauteur / 2 - 65, 50, 50);
        AjouterBouton(f, "mvHD", "", largeur-75, hauteur / 2 - 75, 70, 70);
        AjouterImage(f, "imgHD", "img/HD.xpm", "", largeur-65, hauteur / 2 - 65, 50, 50);
        AjouterBouton(f, "mvBG", "", largeur-155, hauteur / 2 + 5, 70, 70);
        AjouterImage(f, "imgBG", "img/BG.xpm", "", largeur-145, hauteur / 2 + 15, 50, 50);
        AjouterBouton(f, "mvBD", "", largeur-75, hauteur / 2 + 5, 70, 70);
        AjouterImage(f, "imgBD", "img/BD.xpm", "", largeur-65, hauteur / 2 + 15, 50, 50);

        AjouterTexte(f, "scoreText", "score : 0", 15, 70, 100, 30);
        ChangerCouleurFond(f, "scoreText", FL_RIGHT_BCOL);
        ChangerCouleurTexte(f, "scoreText", FL_WHITE);
        ChangerTailleTexte(f, "scoreText", 14);


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

    procedure AffichefMenu(f : in out TR_Fenetre; pseudo : in out unbounded_string; niveau : out natural) is
        largeur : natural := 1200;
        hauteur : natural := 1000;
        fond: T_Couleur := FL_RIGHT_BCOL;

        procedure getNiveau is
            valBouton : unbounded_string;
            tempPseudo : unbounded_string;
        begin

            put_line(integer'image(niveau));

            loop
                valBouton := to_unbounded_string(AttendreBouton(f));
                tempPseudo := to_unbounded_string(ConsulterContenu(f, "inputPseudo"));

                if to_string(valBouton)(1..3) = "cfg" and tempPseudo /= "" then
                        niveau := integer'value(to_string(valBouton)(4..to_string(valBouton)'last));
                        pseudo := tempPseudo;
                        exit;
            elsif valBouton = "boutonQuitter" then 
                raise EX_Quitter;
            elsif valBouton = "boutonAide" then
                CacherElem(f, "boutonAide");
                AffichefAide;
                MontrerElem(f, "boutonAide");
                tempPseudo := to_unbounded_string(ConsulterContenu(f, "inputPseudo"));
                put("aide");
            end if;

            end loop;

            exception
                when Ex_help => 
                        getNiveau;
                when Constraint_Error => 
                    MontrerElem(f, "warningNiveau");
                    if ConsulterContenu(f, "inputPseudo") = "" then
                        raise Ex_pseudo;
                    end if;
                    getNiveau;
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
        
        AjouterTexte(f, "author", "2020 - Clement Guiton - Thomas Duplessis", 0, 0, 400, 40);
        ChangerCouleurTexte(f, "author", FL_BOTTOM_BCOL);
        ChangerCouleurFond(f, "author", fond);
        ChangerTailleTexte(f, "author", 15);
        ChangerStyleTexte(f, "author", FL_ITALIC_STYLE);

        AjouterChamp(f, "inputPseudo", "", to_string(pseudo), largeur/2 + 10, 120, 200, 60);
        ChangerTailleTexte(f, "inputPseudo", 30);

        AjouterTexte(f, "txtPseudo", "Pseudo :", 0, 120, largeur/2 - 10, 60);
        ChangerCouleurTexte(f, "txtPseudo", FL_CYAN);
        ChangerCouleurFond(f, "txtPseudo", fond);
        ChangerTailleTexte(f, "txtPseudo", 30);
        ChangerAlignementTexte(f, "txtPseudo", FL_ALIGN_RIGHT);

        AjouterTexte(f, "lvlTitre", "Niveaux", 0, 200, largeur, 40);
        ChangerCouleurTexte(f, "lvlTitre", FL_WHITE);
        ChangerCouleurFond(f, "lvlTitre", fond);
        ChangerTailleTexte(f, "lvlTitre", 30);
        ChangerAlignementTexte(f, "lvlTitre", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlS", "Starter", 0, 260, largeur, 40);
        ChangerCouleurTexte(f, "lvlS", FL_GREEN);
        ChangerCouleurFond(f, "lvlS", fond);
        ChangerTailleTexte(f, "lvlS", 24);
        ChangerAlignementTexte(f, "lvlS", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlJ", "Junior", 0, 440, largeur, 40);
        ChangerCouleurTexte(f, "lvlJ", FL_DODGERBLUE);
        ChangerCouleurFond(f, "lvlJ", fond);
        ChangerTailleTexte(f, "lvlJ", 24);
        ChangerAlignementTexte(f, "lvlJ", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlE", "Expert", 0, 620, largeur, 40);
        ChangerCouleurTexte(f, "lvlE", FL_RED);
        ChangerCouleurFond(f, "lvlE", fond);
        ChangerTailleTexte(f, "lvlE", 24);
        ChangerAlignementTexte(f, "lvlE", FL_ALIGN_CENTER);

        AjouterTexte(f, "lvlW", "Wizard", 0, 800, largeur, 40);
        ChangerCouleurTexte(f, "lvlW", FL_MAGENTA);
        ChangerCouleurFond(f, "lvlW", fond);
        ChangerTailleTexte(f, "lvlW", 24);
        ChangerAlignementTexte(f, "lvlW", FL_ALIGN_CENTER);


        for i in 1..20 loop
            AjouterBouton(f,
                        "cfg" & integer'image(i)(2..integer'image(i)'last),
                        "",
                        260 + (((i - 1) mod 5)) * 140 ,
                        310 + ((i- 1) / 5) * 180,
                        120,
                        120);
            AjouterImage(f,
                        "img" & integer'image(i)(2..integer'image(i)'last),
                        "img/lvl" & integer'image(i)(2..integer'image(i)'last) & ".xpm",
                        "",
                        260 + (((i - 1) mod 5)) * 140 ,
                        310 + ((i- 1) / 5) * 180,
                        120,
                        120);
        end loop;

        AjouterBouton(f,"boutonQuitter","Quitter", largeur - 155 , 15, 140, 60);
        ChangerCouleurFond(f, "boutonQuitter", FL_WHITE);
        ChangerTailleTexte(f, "boutonQuitter", 20);

        AjouterBouton(f,"boutonAide","?", largeur - 75 , hauteur - 75, 60, 60);
        ChangerCouleurFond(f, "boutonAide", FL_WHITE);
        ChangerTailleTexte(f, "boutonAide", 20);

        AjouterTexte(f, "warningPseudo", "Veuillez rentrer un pseudo", largeur/2 + 75, 50, 280, 30);
        ChangerCouleurTexte(f, "warningPseudo", FL_RED);
        cacherElem (f, "warningPseudo");
        ChangerCouleurFond(f, "warningPseudo", FL_RIGHT_BCOL);

        MontrerFenetre(f);

        getNiveau;
        put_line(natural'image(niveau));
        --pseudo := to_unbounded_string(ConsulterContenu(f, "inputPseudo"));
        exception
            when Constraint_Error => getNiveau;
    end AffichefMenu;

    procedure RefreshfGrille(f : in out TR_Fenetre; grille : TV_Grille; score : in out natural) is
    begin
        for i in grille'range(1) loop
            for y in grille'range(2) loop
                ChangerCouleurFond(f,"bg" & t_lig'image(i)(2..2) & y , FL_INACTIVE);

                if grille(i,y) = vide or grille(i,y) = blanc then
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

            ChangerTexte(f, "scoreText", "score : " & natural'image(score));
        end loop;

    end RefreshfGrille;

    function detectButton (f: in out TR_Fenetre; btnStr: string; grille: in out TV_Grille; coul: in out T_coul; score : in out natural; moves: in out TV_Deplacement; indMoves: in out natural) return unbounded_string is
    
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
            score := score + 1;
            put_line("score : " & natural'image(score));
            MajGrille(grille, coul, T_direction'value(btnStr((btnStr'first+2)..(btnStr'first+3))));
            showMoves(f, grille, coul);
            AfficheGrille(grille);
            RefreshfGrille(f, grille, score);
            if Guerison(grille) then
                return to_unbounded_string("GG");
            else
                addMove(moves, indMoves, (coul, T_direction'value(btnStr((btnStr'first+2)..(btnStr'first+3)))));
            end if;
        else
                if btnStr = "boutonQuitter" then
                    return to_unbounded_string("quit");
                elsif btnStr = "boutonMenu" then
                    return to_unbounded_string("menu");
                elsif btnStr = "boutonReset" then
                    return to_unbounded_string("reset");
                elsif btnStr = "boutonAide" then
                    return to_unbounded_string("aide");
                elsif btnStr = "boutonRetour" then
                    score := score +1;
                    if not removeLastMove(indMoves) then
                        MontrerElem(f, "errorRetour");
                    else
                        MajGrille(grille, moves(indMoves + 1).coul,
                        (case moves(indMoves + 1).dir is
                            when hg => bd,
                            when hd => bg,
                            when bg => hd,
                            when bd => hg));
                        coul := moves(indMoves + 1).coul;
                        showMoves(f, grille, coul);
                        RefreshfGrille(f, grille, score);
                    end if;
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
                if grille(l, c) = vide or grille(l, c) = blanc then
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
        MontrerElem(f, "boutonRetour");
        cacherElem(f, "errorRetour");
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

        AjouterBouton(f, "btnGG", "Retourner au menu", 80, 200, 240 , 60);
        ChangerTailleTexte(f, "btnGG", FL_LARGE_SIZE);

        MontrerFenetre(f);
        while AttendreBouton(f) /= "btnGG" loop
            null;
        end loop;
        CacherFenetre(f);
    end affichefGG;

    procedure AffichefAide is
        f : TR_Fenetre;
        fond: T_Couleur := FL_RIGHT_BCOL;
        largeur: positive := 600;
        hauteur: positive := 625;
    begin
        f := DebutFenetre("Regles", largeur, hauteur);

        AjouterTexte(f, "bg1", "", 0, 0, largeur, hauteur);
        ChangerCouleurFond(f, "bg1", FL_WHITE);

        AjouterTexte(f, "bg2", "", 5, 90, largeur - 10, hauteur - 95);
        ChangerCouleurFond(f, "bg2", fond);

        AjouterTexte(f, "titre", "Regles du jeu",5, 5, largeur - 10, 80);
        ChangerCouleurTexte(f, "titre", FL_WHITE);
        ChangerCouleurFond(f, "titre", fond);
        ChangerTailleTexte(f, "titre", 35);
        ChangerAlignementTexte(f, "titre", FL_ALIGN_CENTER);
        
        AjouterTexte(f, "regles", "Le but du jeu Anti-Virus est de faire sortir le virus", 5, 90, largeur - 10, 50);
        ChangerCouleurFond(f, "regles", fond);
        ChangerCouleurTexte(f, "regles", FL_WHITE);
        ChangerAlignementTexte(f, "regles", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles", 20);

        AjouterTexte(f, "regles2", "(la piece rouge), a l'aide", 5, 140, largeur - 10, 50);
        ChangerCouleurFond(f, "regles2", fond);
        ChangerCouleurTexte(f, "regles2", FL_WHITE);
        ChangerAlignementTexte(f, "regles2", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles2", 20);

        AjouterTexte(f, "regles2.5", "de deplacements des autres pieces.", 5, 190, largeur - 10, 50);
        ChangerCouleurFond(f, "regles2.5", fond);
        ChangerCouleurTexte(f, "regles2.5", FL_WHITE);
        ChangerAlignementTexte(f, "regles2.5", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles2.5", 20);

        AjouterTexte(f, "regles3", "Les pieces se deplacent exclusivement en diagonal", 5, 260, largeur - 10, 50);
        ChangerCouleurFond(f, "regles3", fond);
        ChangerCouleurTexte(f, "regles3", FL_WHITE);
        ChangerAlignementTexte(f, "regles3", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles3", 20);

        AjouterTexte(f, "regles4", "et ne peuvent ni se chevaucher, ni sortir du plateau", 5, 310, largeur - 10, 50);
        ChangerCouleurFond(f, "regles4", fond);
        ChangerCouleurTexte(f, "regles4", FL_WHITE);
        ChangerAlignementTexte(f, "regles4", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles4", 20);

        AjouterTexte(f, "regles5", "Les pieces blanches sont des elements fixes", 5, 380, largeur - 10, 50);
        ChangerCouleurFond(f, "regles5", fond);
        ChangerCouleurTexte(f, "regles5", FL_WHITE);
        ChangerAlignementTexte(f, "regles5", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles5", 20);

        AjouterTexte(f, "regles6", "Il existe 20 configurations de partie differentes", 5, 450, largeur - 10, 50);
        ChangerCouleurFond(f, "regles6", fond);
        ChangerCouleurTexte(f, "regles6", FL_WHITE);
        ChangerAlignementTexte(f, "regles6", FL_ALIGN_CENTER);
        ChangerTailleTexte(f, "regles6", 20);

        AjouterBouton(f, "boutonOk", "J'ai compris", largeur / 2 - 120, 520, 240, 80);
        ChangerTailleTexte(f, "boutonOk", 30);
        ChangerCouleurFond(f, "boutonOk", FL_WHITE);
        ChangerCouleurTexte(f, "boutonOk", FL_BLACK);

        MontrerFenetre(f);
        loop
            exit when AttendreBouton(f)(1..8) = "boutonOk";
        end loop;

        CacherFenetre(f);
    end AffichefAide;

    procedure reset (f: in out p_piece_io.file_type; fgrille: in out TR_Fenetre; grille: in out TV_Grille; pieces: in out TV_Pieces; lvl: in positive; indMoves: in out natural; score : in out natural) is
    begin
    
        score := 0;
        InitPartie(grille, pieces);
        Configurer(f, lvl, grille, pieces);
        RefreshfGrille(fGrille, Grille, score);
        showmoves(fgrille, grille, blanc);
        indMoves := 0;

        cacherElem(fgrille, "colorCase");
        cacherElem(fgrille, "boutonRetour");
    end reset;

    procedure addMove (moves: in out TV_Deplacement; indMoves: in out natural; deplacement: in TR_Deplacement) is
    begin
        moves(indMoves + 1) := deplacement;
        indMoves := indMoves + 1;
    end addMove;

    function removeLastMove (indMoves: in out natural) return boolean is
    begin
        if indMoves = 0 then
            return false;
        else
            indMoves := indMoves - 1;
            return true;
        end if;
    end removeLastMove;
end p_vuegraph;