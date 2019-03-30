--Filnamn: Counter27bit.vhd
--En 27 bitars r�knare som kan r�kna 0 till 134217727 
--Neddelning av frekvensen fr�n oscillatorn med frekvensen 50 MHz
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Counter27bit is
	port(Clk: in std_logic;
	        clkbit23, clkbit24, clkbit25, clkbit26: out std_logic);
end Counter27bit;

architecture beteende of Counter27bit is
	subtype statetype is integer range 0 to 134217727;
	signal state, nextstate:statetype;
	signal Count: std_logic_vector (26 downto 0);

begin 
	process(state)
	begin
		case state is
			when 0 to 134217726 => nextstate <= state + 1;
--			when 134217727 => nextstate <= 0;
			when others => nextstate <= 0;
		end case;
	end process;

	process (Clk)
	begin 
--		if (clk'event and clk = '1') then
		if rising_edge(Clk) then
			state <= nextstate;
		end if;
	end process;
	
	--omvandling av state till 27 bitars vektor
	count <= conv_std_logic_vector (state,27);
	--utbitarna clkbit tilldelas v�rden
	clkbit23 <= Count (23);	
	clkbit24 <= Count (24);
	clkbit25 <= Count (25);
	clkbit26 <= Count (26);
				
end beteende;
