package body p_score is

    procedure ChargerScores(f : in out p_score_io.file_type; v : out TV_score) is
        val : TR_score;
        cpt : natural := 0;
    begin
        reset(f, in_file);
        while not end_of_file(f) loop
            read(f, val);
            v(0) := val;
        end loop;
    end ChargerScores;

    procedure AjouterScore(v : in out TV_score; val : in TR_score) is
        cpt, i : natural := 0;
        temp : TR_score;
    begin
        while cpt < v'last and v(i).score < val.score loop
            cpt := cpt+1;
        end loop;

        for i in reverse cpt+1..v'last loop
            temp := v(i);
            v(i):= v(i-1);
        end loop;
        
        v(cpt) := val;
    end AjouterScore;

    procedure SaveFile(v : in TV_score; f : in out p_score_io.file_type) is
    begin
        reset(f, out_file);

        for i in v'range loop
            write(f, v(i));
        end loop; 
    end SaveFile;

    function longueurFile(f : in out p_score_io.file_type) return natural is
        cpt : natural;
        val : TR_score;
    begin
        cpt := 0;
        
        p_score_io.reset(f, p_score_io.in_file);

        while not end_of_file(f) loop
            p_score_io.read(f, val);
            cpt := cpt+1;
        end loop;

        ecrire_ligne(cpt);
        return cpt;

    end longueurFile;

    function Top5(v : in TV_score; niveau : natural) return TV_score is
        cpt : natural := 0;
        i : natural := 0;
        output : TV_score(1..5);
    begin
        while cpt <= 5  and i <= v'last loop
            if v(i).niveau = niveau then
                output(cpt) := v(i);
                cpt := cpt+1;
            end if;
            i := i+1;
        end loop;
        return output;
    end Top5;
    
end p_score;