LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY tri_buffer IS
	PORT (X : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ; --input
		WE: IN STD_LOGIC ; --Write enable
		F: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) ; --output
END tri_buffer;

ARCHITECTURE Behavior OF tri_buffer IS
BEGIN
	F <= (OTHERS => 'Z') WHEN WE = '0' ELSE X ;
END Behavior;