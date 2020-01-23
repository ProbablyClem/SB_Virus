with p_esiut, p_score, ada.strings.unbounded; use p_esiut, p_score, ada.strings.unbounded;

procedure createHigh is
    f : p_score_io.file_type;
    v : TV_score(1..100);

    procedure Permut(a, b : in out TR_score) is
        temp : TR_score;
    begin
        temp := a;
        a := b;
        b := temp;
    end Permut;

    procedure TriBulles(v : in out TV_score) is
        i : positive := v'first;
        onapermut : boolean := true;
    begin  
        while onapermut loop
            onapermut := false;
            for j in reverse i+1..v'last loop
                if v(j).score < v(j-1).score then  
                    Permut(v(j), v(j-1));
                    onapermut := true;
                end if;
            end loop;
            i := i+1;
        end loop;
    end TriBulles;

begin
    p_score_io.create(f, p_score_io.out_file, "scores.bin");

    for i in v'range loop
            if i mod 5 = 0 then
                v(i) := (("Carlos", others => ' '),(i mod 20) +1,3);
            elsif i mod 5 = 1 then
                v(i) := ("Nathan", (i mod 20) +1, 4);
            elsif i mod 5 = 2 then
                v(i) := ("Nassim", (i mod 20) +1, 5);
            elsif i mod 5 = 3 then
                v(i) := ("Thomas", (i mod 20) +1, 6);
            elsif i mod 5 = 4 then
                v(i) := ("Theo", (i mod 20) +1, 7);
            end if;
    end loop;

    TriBulles(v);

    for i in v'range loop
        ecrire_ligne(v(i).Pseudo & natural'image(v(i).niveau)& natural'image(v(i).score));
    end loop;

    SaveFile(v, f);
    p_score_io.close(f);
end createHigh;