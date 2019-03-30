LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY bcd7seg IS
PORT ( bcd_input : IN STD_LOGIC_VECTOR(3 downto 0) ;
		seven_display : OUT STD_LOGIC_VECTOR(0 TO 6) ) ;
END bcd7seg ;
--�   ���
--�  | 0 |
--� 5|   | 1
--�  |   |
--�   ���
--�  | 6 |
--- 4|   | 2
--�  |   |
--�   ���
--�    3
ARCHITECTURE seven_seg OF bcd7seg IS
BEGIN
	PROCESS ( bcd_input )
	BEGIN
		CASE bcd_input IS
			WHEN "0000" =>
				seven_display <= "0000001" ;
			WHEN "0001" =>
				seven_display <= "1001111" ;
			WHEN "0010" =>
				seven_display <= "0010010" ;
			WHEN "0011" =>
				seven_display <= "0000110" ;
			WHEN "0100" =>
				seven_display <= "1001100" ;
			WHEN "0101" =>
				seven_display <= "0100100" ;
			WHEN "0110" =>
				seven_display <= "1100000" ;
			WHEN "0111" =>
				seven_display <= "0001111" ;
			WHEN "1000" =>
				seven_display <= "0000000" ;
			WHEN "1001" =>
				seven_display <= "0001100" ;
			WHEN OTHERS =>
				seven_display <= "1111110" ;
		END CASE ;
	END PROCESS ;
END seven_seg ;