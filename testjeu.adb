with p_esiut, p_virus, sequential_io; use p_esiut, p_virus;
procedure testjeu is

    procedure GetNumConfig(num : out natural) is
    numero : natural;
    begin
        ecrire("Saisissez le numero de configuration : ");
        lire(numero);
        if numero not in 1..20 then
            raise EX_NumConfig;
        end if;
        num := numero;
    end GetNumConfig;

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    f : p_piece_io.file_type;

begin
    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);
    GetNumConfig(numConfig);
    Configurer(f, numConfig, grille, pieces);
    
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;

    EXCEPTION
        when EX_NumConfig => 
        ecrire("veuillez rentrer une valeur entre 1 et 20");
        GetNumConfig(numConfig);
end testjeu;