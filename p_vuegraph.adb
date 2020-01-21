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

end p_vuegraph;