package body p_virus is
    
    procedure InitPartie(Grille: in out TV_Grille; Pieces: in out TV_Pieces) is
    --{} => {Tous les éléments de Grilleont été initialisés avec la couleur vide
    --      y compris les cases inutilisables
    --      Tous les éléments de Pieces ont été initialisés à false}
    begin
        for i in Grille'range(1) loop
            for y in Grille(i)'range(2) loop
                Grille(y) := Vide;
            end loop;
        end loop;
    end InitPartie;
end p_virus;