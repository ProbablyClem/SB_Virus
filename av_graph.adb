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
    niveau : natural;
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
        begin
            detectButton(fgrille, AttendreBouton(fgrille), grille, coul);
        exception
            when ex_Quitter =>
                exit;
            when EX_GG =>
                affichefGG(lvl);
                exit;
        end;    
    end loop;

    finFenetre(fGrille);
end av_graph;