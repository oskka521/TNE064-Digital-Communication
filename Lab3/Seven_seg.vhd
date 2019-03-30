LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY bcd7seg IS
PORT ( bcd_input : IN STD_LOGIC_VECTOR(1 downto 0) ;
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
			WHEN "00" =>
				seven_display <= "0000001" ;
			WHEN "01" =>
				seven_display <= "1001111" ;
			WHEN "10" =>
				seven_display <= "0010010" ;
		END CASE ;
	END PROCESS ;
END seven_seg ;