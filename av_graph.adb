with p_fenbase, p_vuegraph, p_virus, sequential_io, forms; use p_fenbase, p_vuegraph, p_virus, forms;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    coul : T_coul := vide;
begin


    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    Configurer(f, 1, grille, pieces);
    InitialiserFenetres;
    AffichefMenu(fmenu);
    cacherFenetre(fmenu);
    AffichefGrille(fGrille, grille);
    RefreshfGrille(fGrille, Grille);

    loop
        begin
            detectButton(fgrille, AttendreBouton(fgrille), grille, coul);
        exception
            when Quitter =>
                exit;
        end;    
    end loop;

    finFenetre(fGrille);
end av_graph;