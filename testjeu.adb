with text_io, p_virus; use text_io, p_virus;
procedure testjeu is

    procedure GetNumConfig(num : out natural) is
    begin
        put("Saisissez le numero de configuration : ");
    end GetNumConfig;

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
begin
    InitPartie(grille, pieces);
    
end testjeu;