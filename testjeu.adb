with p_esiut, p_virus, sequential_io; use p_esiut, p_virus;
procedure testjeu is

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    f : p_piece_io.file_type;

    procedure main is
    begin
        ecrire("Saisissez le numero de configuration : ");
        lire(numConfig);
        if numConfig not in 1..20 then
            raise EX_NumConfig;
        end if;

        Configurer(f, numConfig, grille, pieces);
    
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;

    EXCEPTION
        when EX_NumConfig => 
        ecrire_ligne("veuillez rentrer une valeur entre 1 et 20");
        main;
    end main;

    

begin
    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);
    main; 
end testjeu;