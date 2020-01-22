with p_fenbase, p_vuegraph, p_virus, sequential_io, forms, ada.strings.unbounded, p_esiut; use p_fenbase, p_vuegraph, p_virus, forms, ada.strings.unbounded, p_esiut;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    coul : T_coul := vide;
    pseudo : unbounded_string;
    niveau : positive;
    btnResult : unbounded_string;
    moves : TV_Deplacement (0..1000); -- natural'last raise une STORAGE_ERROR
    indMoves : natural := 0;
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
        btnResult := detectButton(fgrille, AttendreBouton(fgrille), grille, coul, moves, indMoves);
        if btnResult = "quit" then
            exit;
        elsif btnResult = "GG" then
            affichefGG(niveau);
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            AffichefMenu(fmenu, pseudo, niveau);
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            ecrire_ligne(to_string(pseudo));
            RefreshfGrille(fGrille, Grille);
        elsif btnResult = "menu" then
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            AffichefMenu(fmenu, pseudo, niveau);
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            ecrire_ligne(to_string(pseudo));
            RefreshfGrille(fGrille, Grille);
        elsif btnResult = "reset" then
            reset(f, fgrille, grille, pieces, niveau, indMoves);
        elsif btnResult = "aide" then
            affichefAide;
        end if;
    end loop;

    finFenetre(fGrille);
end av_graph;