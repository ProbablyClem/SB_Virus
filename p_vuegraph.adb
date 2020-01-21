with text_io; use text_io;

package body p_vuegraph is

    procedure AffichefGrille(f : in out TR_Fenetre; grille : in TV_Grille) is
        largeur, hauteur : natural;
    begin
        largeur := 700;
        hauteur := 500;
        f := DebutFenetre("Virus", largeur, hauteur);
            AjouterBouton(f, "background", "", 0, 0, largeur-2, hauteur-2);
            AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
            AjouterBouton(f, "boutonReset", "Recommencer", largeur - 80 - 135, 15, 120, 30);
        ChangerCouleurFond(f, "background", FL_RIGHT_BCOL);
        ChangerEtatBouton(f, "background", arret);
        AjouterBouton(f,"boutonFond", "", (largeur - (hauteur - 160)) / 2, 80, hauteur - 160, hauteur - 160);
        ChangerCouleurFond(f, "boutonFond", FL_BLACK);
        ChangerEtatBouton(f, "boutonFond", arret);

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

    procedure AffichefMenu(f : in out TR_Fenetre) is
    largeur : natural := 700;
    hauteur : natural := 500;
    begin
    f := DebutFenetre("Menu", largeur, hauteur);
        AjouterBouton(f, "boutonJouer","Jouer", largeur/2 - 70/2, 50, 70, 30); 
        AjouterChamp(f, "inputPseudo","Pseudo","", largeur/2 - 130/2, 90, 130, 30);
    MontrerFenetre(f);
    While AttendreBouton(f) /="boutonJouer" loop
        null;
    end loop;
    end AffichefMenu;

    procedure RefreshfGrille(f : in out TR_Fenetre; grille : TV_Grille; couleurs : in TV_Couleurs) is
    begin
        for i in grille'range(1) loop
            for y in grille'range(2) loop
                if grille(i,y) = vide then
                    ChangerEtatBouton(f,t_lig'image(i) & y , arret);
                end if;
            end loop;
        end loop;


    for i in T_lig'range loop
            for y in T_col'range loop
                case Grille(i, y) is
                    when vide =>
                        if (T_lig'pos(i) mod 2) = (T_col'pos(y) mod 2) then
                            ChangerEtatBouton(f, "bg" & t_lig'image(i)(1..2) & y, arret);

                        end if;
                    when blanc =>
                        ChangerEtatBouton(f, "bg" & t_lig'image(i)(2..2) & y, arret);
                        ChangerCouleurFond(f, "bg" & t_lig'image(i)(2..2) & y, FL_WHITE);
                    when others =>
                        ChangerEtatBouton(f, "bg" & t_lig'image(i)(2..2) & y, marche);
                        ChangerCouleurFond(f, "bg" & t_lig'image(i)(2..2) & y, couleurs(grille(i,y)));
                end case;
            end loop;
    end RefreshfGrille;

    procedure detectButton (btnStr: string; grille: in TV_Grille) is
    
        c : T_col;
        l : T_lig;

    begin
        put_line("'" & btnStr & "'");

        if btnStr(1..2) = "bg" then
            l := T_lig'value(btnStr(3..3));
            put_line("l =" & T_lig'image(l));
            c := btnStr(4);
            put_line("c =" & T_col'image(c));
            put_line(T_lig'image(l) & T_col'image(c));
            put_line(T_coul'image(grille(l, c)));
            put_line("---");
        else
                if btnStr = "boutonQuitter" then
                    raise Quitter;
                else
                    put_line("pas encore implémenté");
                    return;
                end if;
        
        end if;
    end detectButton;

end p_vuegraph;