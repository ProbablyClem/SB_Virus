with p_esiut, p_virus, sequential_io, p_vuetxt; use p_esiut, p_virus, p_vuetxt;
procedure testjeu is

    grille : TV_Grille;
    pieces : TV_Pieces;
    numConfig : natural;
    f : p_piece_io.file_type;
    coul : T_CoulP;

    procedure getNumConfig(num : in out natural) is
    begin
        loop
            ecrire("Saisissez le numero de configuration : ");
            lire(num);
        exit when num in 1..20;
            ecrire_ligne("veuillez rentrer une valeur entre 1 et 20");
        end loop;
    end getNumConfig;

    procedure getCouleurTour(coul : in out T_CoulP) is
    begin    
        ecrire("Saisissez la couleur de la piece a deplacer : ");
        p_coul_io.lire(coul);
        if pieces(coul) = false then
            ecrire_ligne("Cette piece n'existe pas !");
            getCouleurTour(coul);
        elsif coul = blanc
            then ecrire_ligne("Les pieces blanches ne peuvent pas etre deplacées");
            getCouleurTour(coul);
        end if;
    end getCouleurTour;
    
begin
    p_piece_io.open(f, p_piece_io.in_file, "Parties");
    InitPartie(grille, pieces);
    getNumConfig(numConfig);

    Configurer(f, numConfig, grille, pieces);

    for i in T_CoulP loop
        if pieces(i) = true then
            PosPiece(grille, i);
        end if;
    end loop;
    
    AfficheGrille(Grille);

    getCouleurTour(coul); --recupere la couleur de la piece a deplacer pour le tour

    for i in T_Direction'range loop
        if Possible(grille, coul, i) = true then
            MajGrille(grille, coul, i);
            PosPiece(grille, coul);
            AfficheGrille(Grille);
            InitPartie(grille, pieces);
            Configurer(f, numConfig, grille, pieces);
            
        end if;
    end loop;

    p_piece_io.close(f);
EXCEPTION
    when p_piece_io.END_ERROR => ecrire("Fichier corompu");
end testjeu;