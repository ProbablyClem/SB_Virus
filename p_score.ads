with sequential_io;

package p_score is
    
    type TR_Score is record
        niveau: positive;
        pseudo: string (1..20);
        score : positive;
        temps: float;
    end record;

    type TV_Score is array (positive range <>) of TR_Score;

    package p_score_io is new sequential_io(TR_Score); use p_score_io;

    nomFic : constant string(1..14) := "data/score.bin";

    function fileExist return boolean;

    procedure createFile;

    procedure binToVec (V: out TV_Score);

    procedure vecToBin (V: in TV_Score);

    procedure getHighScore (lvl: in positive; highScore: out TV_Score);

    procedure addScore (lvl: positive; pseudo: string; score: positive; temps: float);

end p_score;