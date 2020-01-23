with sequential_io, p_esiut, ada.strings.unbounded; 
use p_esiut, ada.strings.unbounded;

package p_score is

type TR_Score is record
    Pseudo : string(1..25) := (others => ' ');
    niveau : positive;
    score : natural;
end record;

type TV_Score is array(natural range <>) of TR_Score;

package p_score_io is new sequential_io(TR_Score); use p_score_io;

procedure ChargerScores(f : in out p_score_io.file_type; v : out TV_Score);
-- charge les elements du fichier f dans le vecteur v

procedure AjouterScore(v : in out TV_Score; val : in TR_Score);
--{v trié}-- --{rajouter val dans v en restant trié}-- 

procedure SaveFile(v : in TV_Score; f : in out p_score_io.file_type);
-- v enregistré dans le fichier f

function longueurFile(f : in out p_score_io.file_type) return natural;
-- renvoie le nombre d'elements du fichier

function Top5(v : in TV_Score; niveau : natural) return TV_Score;
end p_score;