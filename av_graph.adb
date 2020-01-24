with p_fenbase, p_vuegraph, p_virus, sequential_io, forms, ada.strings.unbounded, p_esiut, ADA.IO_EXCEPTIONS, p_score; use p_fenbase, p_vuegraph, p_virus, forms, ada.strings.unbounded, p_esiut, p_score;

procedure av_graph is
    f : p_piece_io.file_type;
    fGrille, fMenu : TR_Fenetre;
    grille : TV_Grille;
    pieces : TV_Pieces;
    coul : T_coul := vide;
    pseudo : unbounded_string := to_unbounded_string("invite");
    niveau : positive;
    btnResult : unbounded_string;
    score : natural := 0;
    moves : TV_Deplacement (0..1000); -- natural'last raise une STORAGE_ERROR
    indMoves : natural := 0;
    pseudoScore: string (1..20):= "                    ";
begin

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);

    InitialiserFenetres;
    
    AffichefMenu(fmenu, pseudo, niveau);
    cacherFenetre(fmenu);
    Configurer(f, niveau, grille, pieces);
    AffichefGrille(fGrille, grille);
    RefreshfGrille(fGrille, Grille, score);
    Leaderboard(fgrille, niveau);

    loop
        btnResult := detectButton(fgrille, AttendreBouton(fgrille), grille, coul, score, moves, indMoves);
        if btnResult = "quit" then
            score := 0;
        RepriseTimer(fgrille, "timer");

            exit;
        elsif btnResult = "GG" then
            PauseTimer(fgrille, "timer");
            if pseudo /= "invite" then
                pseudoScore := "                    ";
                pseudoScore(1..to_string(pseudo)'last) := to_string(pseudo);
                addScore(niveau, pseudoScore, score, 100000.0 - ConsulterTimer(fgrille, "timer"));
            end if;
            affichefGG(niveau, pseudo, 100000.0 - ConsulterTimer(fgrille, "timer"));
            cacherFenetre(fGrille);
            score := 0;
            indMoves := 0;
            ChangerTempsMinuteur(fgrille, "timer", 100000.0);
            PauseTimer(fgrille, "timer");
            InitPartie(grille, pieces);
            AffichefMenu(fmenu, pseudo, niveau);
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            RefreshfGrille(fGrille, Grille, score);
            Leaderboard(fgrille, niveau);
        elsif btnResult = "menu" then
            score := 0;
            indMoves := 0;
            cacherFenetre(fGrille);
            InitPartie(grille, pieces);
            loop
                AffichefMenu(fmenu, pseudo, niveau);
                cacherFenetre(fmenu);
            exit when niveau /= 666;
            end loop;
            MontrerFenetre(fGrille);
            cacherFenetre(fmenu);     
            Configurer(f, niveau, grille, pieces);
            RefreshfGrille(fGrille, Grille, score);
            Leaderboard(fgrille, niveau);
            ChangerTempsMinuteur(fgrille, "timer", 100000.0);
            PauseTimer(fgrille, "timer");
            for i in 0..3 loop
                CacherElem(fgrille, "mv" & T_direction'image(T_direction'val(i)));
                CacherElem(fgrille, "img" & T_direction'image(T_direction'val(i)));
            end loop;
            CacherElem(fgrille, "colorCase");
            CacherElem(fgrille, "boutonRetour");
            
            
        elsif btnResult = "reset" then
            reset(f, fgrille, grille, pieces, niveau, indMoves, score);
        elsif btnResult = "aide" then
            CacherElem(fGrille, "boutonAide");
            affichefAide;
            MontrerElem(fgrille, "boutonAide");
        end if;
    end loop;

    finFenetre(fGrille);
exception
    when Ex_quitter => null;
end av_graph;