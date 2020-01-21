with p_fenbase, p_vuegraph, p_virus, sequential_io, forms; use p_fenbase, p_vuegraph, p_virus, forms;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    couleurs : TV_Couleurs;
begin

    couleurs := (FL_RED, FL_CYAN, FL_DARKORANGE, FL_DEEPPINK, FL_DARKTOMATO, FL_BLUE, FL_DARKVIOLET, FL_GREEN, FL_YELLOW, FL_WHITE);

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    Configurer(f, 1, grille, pieces);
    InitialiserFenetres;
    AffichefGrille(fGrille, grille);
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;
    RefreshfGrille(fGrille, Grille, couleurs);
    While AttendreBouton(fGrille) /="boutonQuitter" loop
        null;
    end loop;
    finFenetre(fGrille);
end av_graph;