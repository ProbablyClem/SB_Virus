with text_io, p_virus, sequential_io; use text_io, p_virus;
procedure testjeu is

    procedure GetNumConfig(num : out natural) is
    numero : natural;
    begin
        put("Saisissez le numero de configuration : ");
        get(numero);
        if numero not in 1..20 then
            raise EX_NumConfig;
        end if;
        num := numero;
    end GetNumConfig;

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    f : p_piece.io.file_type;

begin
    p_pieces_io.open(f, p_pieces_io.in_file, "Parties");
    InitPartie(grille, pieces);
    GetNumConfig(num);
    Configurer(f, numConfig, grille, pieces);
    
    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, pieces(i));
        end if;
    end loop;

    EXCEPTION
        when EX_NumConfig => 
        put("veuillez rentrer une valeur entre 1 et 20");
        GetNumConfig(numConfig);
end testjeu;