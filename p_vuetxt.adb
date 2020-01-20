with text_io; use text_io;
with p_virus; use p_virus;

package body p_vuetxt is
    
    procedure AfficheGrille (Grille: in TV_Grille) is
    --{} => {la grille a été affichée selon les spécifications suivantes :
    --      *la sortie est indiquée par la lettre S
    --      *une case inactive ne contient aucun caractère
    --      *une case de couleur vide contient un point
    --      *une case de couleur blanche contient le caractère F (Fixe)
    --      *une case de la couleur d’une pièce mobile contient le chiffre correspondant à la
    --       position de cette couleur dans le type T_Coul}

    begin

        put_line("     Plateau de jeu");
        put_line("------------------------");
        new_line;

        put_line("     A B C D E F G");
        put_line("   S - - - - - - - ┐");

        for i in T_lig'range loop
            put(integer'image(i) & " |");
            for j in T_col'range loop
                case Grille(i, j) is
                    when vide =>
                        if (T_lig'pos(i) mod 2) = (T_col'pos(j) mod 2) then
                            put(" ·");
                        else
                            put("  ");
                        end if;
                    --when blanc =>
                    --    put(" F");
                    when others =>
                        --put(integer'image(T_coul'pos(Grille(i, j))));
                        put(ASCII.ESC & "[38;5;" & integer'image(colors(Grille(i,j)))(2..integer'image(colors(Grille(i,j)))'last) & "m" & " ◉" & ASCII.ESC & "[0m");
                end case;
            end loop;
            put_line(" |");
        end loop;

        put_line("   └ - - - - - - - ┘");
        new_line;

    end AfficheGrille;

    procedure clear is
    begin
        put(ASCII.ESC & "[2J");
    end clear;

    procedure sautLigne (x: in positive) is
    begin
        for i in 1..x loop
            new_line;
        end loop;
    end sautLigne;

end p_vuetxt;
