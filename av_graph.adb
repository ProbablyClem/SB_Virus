with p_fenbase, p_vuegraph, p_virus, sequential_io, forms, ada.strings.unbounded, p_esiut, p_score; 
use p_fenbase, p_vuegraph, p_virus, forms, ada.strings.unbounded, p_esiut, p_score;

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
    fScore : p_score_io.file_type;
    tailleVec : natural;
begin

    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    p_score_io.open(fScore, p_score_io.in_file, "scores.bin");
    tailleVec := p_score.longueurFile(fScore);

    p_score_io.reset(fScore, p_score_io.in_file);

    declare 
        vecScores : TV_score(1..tailleVec);
    begin
            ecrire_ligne("here");

        ChargerScores(fScore, vecScores);
        InitPartie(grille, pieces);

        InitialiserFenetres;
        AffichefMenu(fmenu, pseudo, niveau);
        cacherFenetre(fmenu);
        Configurer(f, niveau, grille, pieces);
        ecrire_ligne(to_string(pseudo));
        AffichefGrille(fGrille, grille);
        RefreshfGrille(fGrille, Grille, score,vecScores, niveau);

        loop
            btnResult := detectButton(fgrille, AttendreBouton(fgrille), grille, coul, score,moves, indMoves, niveau, vecScores);
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
                RefreshfGrille(fGrille, Grille, score, vecScores, niveau);
            elsif btnResult = "menu" then
                score := 0;
                cacherFenetre(fGrille);
                InitPartie(grille, pieces);
                AffichefMenu(fmenu, pseudo, niveau);
                MontrerFenetre(fGrille);
                cacherFenetre(fmenu);     
                Configurer(f, niveau, grille, pieces);
                ecrire_ligne(to_string(pseudo));
                RefreshfGrille(fGrille, Grille, score, vecScores, niveau);
            elsif btnResult = "reset" then
                reset(f, fgrille, grille, pieces, niveau, indMoves, score, vecScores);
            elsif btnResult = "aide" then
                affichefAide;
            end if;    
        end loop;

        finFenetre(fGrille);
    end;
    --exception
            --when PROGRAM_ERROR => ecrire_ligne(tailleVec);
end av_graph;