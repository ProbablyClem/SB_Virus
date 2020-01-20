with text_io; use text_io;
with p_virus; use p_virus;

package body p_vuetest is
    
    procedure AfficheGrille (Grille: in TV_Grille) is
    --{} => {la grille a été affichée selon les spécifications suivantes :
    --      *la sortie est indiquée par la lettre S
    --      *une case inactive ne contient aucun caractère
    --      *une case de couleur vide contient un point
    --      *une case de couleur blanche contient le caractère F (Fixe)
    --      *une case de la couleur d’une pièce mobile contient le chiffre correspondant à la
    --       position de cette couleur dans le type T_Coul}

    begin

        put_line("     A B C D E F G");
        put_line("   S - - - - - - -");

        for i in T_lig'range loop
            put(integer'image(i) & " |");
            for j in T_col'range loop
                begin
                    case Grille(i, j) is
                        when vide =>

                            if (T_lig'pos(i) mod 2) = (T_col'pos(j) mod 2) then
                                put(" .");
                            else
                                put("  ");
                            end if;
                        when blanc =>
                            put(" F");
                        when others =>
                            put(integer'image(T_coul'pos(Grille(i, j))));
                    end case;
                end;
            end loop;
            new_line;
        end loop;

    end AfficheGrille;

end p_vuetest;