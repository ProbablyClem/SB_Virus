with sequential_io;

package p_score is
    
    type TR_Score is record
        niveau: positive;
        pseudo: string (1..20);
        score : positive;
        temps: float;
    end record;

    type TV_Score is array (positive range TV_Score) of TR_Score;

    package p_score_io is new sequential_io(TV_Score); use p_score_io;

    nomFic : constant string(1..14) := "data/score.bin";

    function fileExist return boolean is
    -- on vérifie si un fichier existe en se basant sur une exception
        f: p_score_io.file_type;
    begin
        open(f, in_file, nomFic);
        close(f);
        return true;
    exception
        when others =>
            return false;
    end fileExist;

    procedure createFile is
    -- on créé un fichier pour stocker les scores
        f: p_score_io.file_type;
    begin
        create(f, out_file, nomFic);
        close(f);
    end createFile

    procedure fileToVec (V: out TV_Score) is
    -- on récupère le vecteur associé au fichier de score par défaut
        i: positive := 1;
        score: TR_Score;
        f: in p_score_io.file_type; 
    begin
        open(f, in_file, nomFic);
        while not end_of_file(f) loop
            read(f, V(i));
            i := i + 1;
        end loop;
        close(f);
    end fileToVec

    procedure getHighScore (lvl: in positive; highScore: out TV_Score) is
    -- on récupère un vecteur contenant les 5 meilleurs temps d'un niveau voulu
        V: TV_Score;
        i: positive := 1;
    begin

        if not fileExist then
            createFile;
        end if;

        fileToVec(V);
        while lvl > V(i).niveau and i <= V'last loop
            i := i + 1;
        end loop;

        if lvl < V(i) then
            highScore := ();
        else
            
        end if;
    end getScore;

end p_score;