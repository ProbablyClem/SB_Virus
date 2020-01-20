with text_io;       use text_io;
with sequential_io;
with p_esiut;       use p_esiut;
with p_virus;       use p_virus;
                    use p_virus.p_piece_io;
                    use p_virus.p_dir_io;
                    use p_virus.p_coul_io;
with p_vuetxt;      use p_vuetxt;

procedure av_txt is
    
    f: p_piece_io.file_type;

    conf: natural;
    grille: TV_Grille;
    pieces : TV_Pieces;

    coul: T_CoulP;
    dir: T_direction;

    procedure getNumConf (conf: out natural) is
    begin
        put_line("Quelle configuration souhaitez vous [Entre 1 et 20] :");

        loop
            put("--> "); lire(conf);
        exit when conf in 1..20;
            put_line("Veuillez saisir un nombre entre 1 et 20");
        end loop;
    end getNumConf;

    ----------

    procedure getCoul (coul: out T_coul) is
    begin
        put_line("Quelle pièce souhaitez vous déplacer :");
        
        loop
            put("--> "); lire(coul);
        exit when coul in rouge..jaune;
            if coul = blanc then
                put_line("Les pièces blanches ne peuvent pas bouger");
            end if;
            put_line("Veuillez saisir une couleur valide");
            put_line("{guide}");
        end loop;
    end getCoul;

    ----------

    procedure getDirection (dir: out T_direction) is
    begin
        put_line("Dans quelle direction souhaitez vous aller :");
        put_line("(hg: ↖, hd: ↗, bg: ↙, bd ↘)");

        loop
            put("--> "); lire(dir);
        exit when dir IN bg..hd;
            put_line("Veuillez saisir une direction valide");
            put_line("(hg: ↖, hd: ↗, bg: ↙, bd ↘)");
        end loop;
    end getDirection;

    procedure showAvailable (Pieces: in TV_Pieces) is
    begin
        put_line("Pièces disponibles :");

        for i in Pieces'range loop
            if Pieces(i) then
                put_line(T_coul'image(i));
            end if;
        end loop;
        put_line("------------------------");
    end showAvailable;

begin
    
    open(f, in_file, "Parties");
    InitPartie(grille, pieces);

    getNumConf(conf);

    Configurer(f, conf, grille, pieces);

    while not guerison(grille) loop
        clear;
        showAvailable(Pieces);

        AfficheGrille(grille);

        getCoul(coul);

        if not Possible(grille, coul, hg) and not Possible(grille, coul, hd) and not Possible(grille, coul, bg) and not Possible(grille, coul, bd) then
            put_line("Cette pièce ne peut pas bouger");
            skip_line;
        else
            getDirection(dir);

            if Possible(grille, coul, dir) then
                MajGrille(grille, coul, dir);
            else
                put_line("Ce mouvement est impossible");
                skip_line;
            end if;
        end if;

    end loop;

end av_txt;
