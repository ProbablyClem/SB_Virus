with p_fenbase, p_vuegraph, p_virus; use p_fenbase, p_vuegraph, p_virus;

procedure av_graph is
    fGrille, fMenu : TR_Fenetre;
    grille : TR_Grille;
begin
    InitialiserFenetres;
    AffichefGrille(fGrille, grille);
    finFenetre(fGrille);
end av_graph;