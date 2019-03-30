LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;

ENTITY control IS
PORT ( sram_input : IN STD_LOGIC_VECTOR(3 downto 0) ;
		cordic_output : in std_logic_vector(15 downto 0)
		) ;
END control ;


ARCHITECTURE behaviour OF control IS

	subtype vec is integer range -2048 to 2047;
	type arvec is array (0 to 6) of vec;
	signal data : arvec;
	
BEGIN
	PROCESS (sram_input)
	BEGIN
	data(0) <= (conv_integer(sram_input));
	
	cordic_output <= (conv_std_logic_vector(data(0),16));

	END PROCESS ;
END behaviour ;