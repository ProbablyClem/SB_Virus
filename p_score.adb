with p_esiut; use p_esiut;

package body p_score is
    
    function fileExist return boolean is
    -- on vérifie si un fichier existe en se basant sur une exception
        f: p_score_io.file_type;
    begin
        open(f, in_file, nomFic);
        reset(f);
        close(f);
        return true;
    exception
        when NAME_ERROR =>
            return false;
    end fileExist;

    procedure createFile is
    -- on créé un fichier pour stocker les scores
        f: p_score_io.file_type;
    begin
        create(f, out_file, nomFic);
        reset(f);
        write(f, (1, "Theo Rozier         ", 1, 0.1));
        close(f);
    end createFile;

    procedure binToVec (V: out TV_Score) is
    -- on récupère le vecteur associé au fichier de score par défaut
        i: positive := 1;
        f: p_score_io.file_type; 
    begin
        open(f, in_file, nomFic);
            loop
                read(f, V(i));
                i := i + 1;
            exit when end_of_file(f);
            end loop;
            ecrire_ligne("--");
        close(f);
    end binToVec;

    procedure vecToBin (V: in TV_Score) is
    -- on écrit dans un fichier le vecteur de score
        f: p_score_io.file_type;
        i: positive := 1; 
    begin
        open(f, out_file, nomFic);

        while V(i).niveau /= 0 loop
            write(f, V(i));
            i := i + 1;
        end loop;

        close(f);
    end vecToBin;

    procedure getHighScore (lvl: in positive; highScore: out TV_Score) is
    -- on récupère un vecteur contenant les 5 meilleurs temps d'un niveau voulu
        V: TV_Score (1..1000);
        i: positive := 1;
        nb : natural := 0;
    begin

        if not fileExist then
            createFile;
        end if;

        binToVec(V);

        while lvl > V(i).niveau and V(i).niveau /= 0 loop
            i := i + 1;
        end loop;

        while lvl = V(i).niveau and nb < 5 loop
            nb := nb + 1;
            highScore(nb) := V(i);
            i := i + 1;
        end loop;

        for j in (nb+1)..5 loop
            highScore(j) := (lvl, "Pas de temps        ", 1, 0.0);
        end loop;
    end getHighScore;

    procedure addScore (lvl: in positive; pseudo: in string; score: in positive; temps: in float) is
    -- pour ajouter un score dans le fichier
        V: TV_Score (1..1000);
        i : positive := 1;
    begin

        if not fileExist then
            createFile;
        end if;

        binToVec(V);

        while lvl > V(i).niveau and V(i).niveau /= 0 loop
            i := i + 1;
        end loop;

        if lvl = V(i).niveau then
            while temps > V(i).temps and lvl = V(i).niveau loop
                i := i + 1;
            end loop;
        end if;

        for j in reverse i..V'last-1 loop
            V(j+1) := V(j);
        end loop;
        V(i) := (lvl, pseudo, score, temps);

        vecToBin(V);
    end addScore;

end p_score;