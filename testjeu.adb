with p_esiut, p_virus, sequential_io, p_vuetest; use p_esiut, p_virus, p_vuetest;
procedure testjeu is

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    f : p_piece_io.file_type;

    
begin
    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);
    loop
        ecrire("Saisissez le numero de configuration : ");
        lire(numConfig);
    exit when numConfig in 1..20;
        ecrire_ligne("veuillez rentrer une valeur entre 1 et 20");
    end loop;

    Configurer(f, numConfig, grille, pieces);
    p_piece_io.close(f);
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;

    AfficheGrille(Grille);
EXCEPTION
    when p_piece_io.END_ERROR => ecrire("Fichier corompu");
end testjeu;