package body p_vuegraph is

    procedure AffichefGrille(f : in out TR_Fenetre; grille : in TV_Grille) is
        largeur, hauteur : natural;
    begin
        largeur := 600;
        hauteur := 500;
        f := DebutFenetre("Virus", largeur, hauteur);
            AjouterBouton(f,"boutonQuitter","Quitter", largeur -80 , 15, 70, 30);
            AjouterBouton(f, "boutonReset", "Recommencer", largeur - 80 - 135, 15, 120, 30);


        MontrerFenetre(f);
        While AttendreBouton(f) /="boutonQuitter" loop
            null;
        end loop;
    end AffichefGrille;

    procedure RefreshfGrille(f : in out TR_Fenetre; grille : TV_Grille; couleurs : in TV_Couleurs) is

    begin
    for i in grille'range(1) loop
        for y in grille'range(2) loop
            if grille(i,y) = vide then
                ChangerEtatBouton(f, t_lig'image(i) & t_col'image(y), arret);
            end if;
        end loop;
    end loop;


    for i in T_lig'range loop
            for y in T_col'range loop
                case Grille(i, y) is
                    when vide =>
                        if (T_lig'pos(i) mod 2) = (T_col'pos(y) mod 2) then
                            ChangerEtatBouton(f, t_lig'image(i) & t_col'image(y), arret);
                        end if;
                    when blanc =>
                        ChangerEtatBouton(f, t_lig'image(i) & t_col'image(y), arret);
                        ChangerCouleurFond(f, t_lig'image(i) & t_col'image(y), FL_WHITE);
                    when others =>
                        ChangerEtatBouton(f, t_lig'image(i) & t_col'image(y), marche);
                        ChangerCouleurFond(f, t_lig'image(i) & t_col'image(y), couleurs(grille(i,y)));
                end case;
            end loop;
        end loop;

    end RefreshfGrille;

end p_vuegraph;