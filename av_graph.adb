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
    score : natural := 0;
    moves : TV_Deplacement (0..1000); -- natural'last raise une STORAGE_ERROR
    indMoves : natural := 0;
begin

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);
    loop
        InitialiserFenetres;
        AffichefMenu(fmenu, pseudo, niveau);
        if niveau /= 666 then
            cacherFenetre(fmenu);
            Configurer(f, niveau, grille, pieces);
            ecrire_ligne(to_string(pseudo));
            AffichefGrille(fGrille, grille);
            RefreshfGrille(fGrille, Grille, score);
        end if;
    exit when niveau /= 666;
    end loop;
    loop
        btnResult := detectButton(fgrille, AttendreBouton(fgrille), grille, coul, score, moves, indMoves);
        if btnResult = "quit" then
            score := 0;
            exit;
        elsif btnResult = "GG" then
            score := 0;
            affichefGG(niveau);
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            AffichefMenu(fmenu, pseudo, niveau);
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            ecrire_ligne(to_string(pseudo));
            RefreshfGrille(fGrille, Grille, score);
        elsif btnResult = "menu" then
            score := 0;
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            ecrire_ligne("test1");
            loop
                AffichefMenu(fmenu, pseudo, niveau);
                ecrire_ligne("test2");
                if niveau /= 666 then
                    ecrire_ligne("test3");
                    MontrerFenetre(fGrille);
                    Configurer(f, niveau, grille, pieces);
                    ecrire_ligne(to_string(pseudo));
                    RefreshfGrille(fGrille, Grille, score);
                end if;
                cacherFenetre(fmenu);
                ecrire_ligne("test44");
            exit when niveau /= 666;
            end loop;
        elsif btnResult = "reset" then
            reset(f, fgrille, grille, pieces, niveau, indMoves, score);
        elsif btnResult = "aide" then
            affichefAide;
        end if;
    end loop;

    finFenetre(fGrille);
end av_graph;