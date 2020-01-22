with p_fenbase, p_vuegraph, p_virus, sequential_io, forms; use p_fenbase, p_vuegraph, p_virus, forms;
with p_esiut; use p_esiut;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    coul : T_coul := vide;
    lvl: positive;
begin

    ecrire("Niveau = "); lire(lvl);

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    Configurer(f, lvl, grille, pieces);
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
                null;
            when EX_GG =>
                ecrire("test");
                affichefGG(lvl);
        end;    
    end loop;

    finFenetre(fGrille);
end av_graph;