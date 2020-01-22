with p_fenbase, p_vuegraph, p_virus, sequential_io, forms, ada.strings.unbounded, p_esiut; use p_fenbase, p_vuegraph, p_virus, forms, ada.strings.unbounded, p_esiut;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    coul : T_coul := vide;
    couleurs : TV_Couleurs;
    pseudo : unbounded_string;
    niveau : positive;
    btnResult : unbounded_string;
begin
    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    InitialiserFenetres;
    AffichefMenu(fmenu, pseudo, niveau);
    cacherFenetre(fmenu);
    Configurer(f, niveau, grille, pieces);
    ecrire_ligne(to_string(pseudo));
    AffichefGrille(fGrille, grille);
    RefreshfGrille(fGrille, Grille);

    loop
        btnResult := detectButton(fgrille, AttendreBouton(fgrille), grille, coul);
        if btnResult = "quit" then
            exit;
        elsif btnResult = "GG" then
            affichefGG(niveau);
            exit;
        elsif btnResult = "menu" then
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            AffichefMenu(fmenu, pseudo, niveau);
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            ecrire_ligne(to_string(pseudo));
            RefreshfGrille(fGrille, Grille);
        end if;    
    end loop;

    finFenetre(fGrille);
end av_graph;