with p_esiut; use p_esiut;
with p_score; use p_score; use p_score.p_score_io;

procedure testscore is
    choix: positive;
    lvl: positive;
    pseudo: string (1..20);
    score: positive;
    temps: float;
    HighScore: TV_Score(1..5);
begin
    ecrire_ligne("----- Choix -----");

    ecrire_ligne("Veuillez faire un choix");
    ecrire_ligne("1: Ajout Score");
    ecrire_ligne("2: High Score");
    ecrire("--> "); lire(choix);

    case choix is
        when 1 =>
            ecrire_ligne("----- Ajout Score -----");

            ecrire_ligne("Veuillez saisir un niveau");
            ecrire("--> "); lire(lvl);

            ecrire_ligne("Veuillez saisir un pseudo");
            ecrire("--> "); lire(pseudo);

            ecrire_ligne("Veuillez saisir un score");
            ecrire("--> "); lire(score);

            ecrire_ligne("Veuillez saisir un temps");
            ecrire("--> "); lire(temps);

            addScore(lvl, pseudo, score, temps);

        when 2 =>
            ecrire_ligne("----- High Score -----");
            
            ecrire_ligne("Veuillez saisir un niveau");
            ecrire("--> "); lire(lvl);

            getHighScore(lvl, HighScore);

            for i in 1..5 loop
                lvl := HighScore(i).niveau;
                pseudo := HighScore(i).pseudo;
                score := HighScore(i).score;
                temps := HighScore(i).temps;

                ecrire_ligne(image(lvl) & " | " & pseudo & " |" & image(score) & " |" & image(temps));
            end loop;

        when others =>
            null;
    end case;

end testscore;