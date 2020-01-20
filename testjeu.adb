with p_esiut, p_virus, sequential_io; use p_esiut, p_virus;
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
    
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;
end testjeu;