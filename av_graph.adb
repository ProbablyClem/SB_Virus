with p_fenbase, p_vuegraph, p_virus, sequential_io; use p_fenbase, p_vuegraph, p_virus;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
begin

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    Configurer(f, 1, grille, pieces);
    InitialiserFenetres;
    AffichefGrille(fGrille, grille);
    finFenetre(fGrille);
end av_graph;