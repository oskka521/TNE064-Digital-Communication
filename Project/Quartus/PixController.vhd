library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pixelController is
	 Port ( 
			  clk         : in   STD_LOGIC;
			  y_control   : in  STD_LOGIC_VECTOR (9 downto 0);
			  x_control   : in  STD_LOGIC_VECTOR (9 downto 0);
			  SRAM_ADDRESS: out  STD_LOGIC_VECTOR (11 downto 0);
			  SRAM_DATA   : in  STD_LOGIC_VECTOR (15 downto 0);
			  Data   	  : out  STD_LOGIC_VECTOR(3 downto 0);
			  y_controlo  : out  STD_LOGIC_VECTOR (9 downto 0);
			  x_controlo  : out  STD_LOGIC_VECTOR (9 downto 0)
			  
			  );
end pixelController;

architecture Behavioral of pixelController is
	signal x,y	:integer range 0 to 650;
	signal z		:integer;
	signal count :integer :=0;
	signal fakey :STD_LOGIC_VECTOR (9 downto 0);
	signal data_buffer,data_buffer_next:STD_LOGIC_VECTOR(3 downto 0); 
	signal Xbuffer,Xbuffer_next:STD_LOGIC_VECTOR(9 downto 0);
	signal Ybuffer,Ybuffer_next:STD_LOGIC_VECTOR(9 downto 0); 	
	begin
		x <= conv_integer(x_control);
		y <= conv_integer(y_control);
		Xbuffer_next <= x_control;
		Ybuffer_next <= y_control;
		
		
		fakey <= y_control;
		data_buffer <= SRAM_DATA(3 downto 0);
		--data_buffer <= "0101";
		process(fakey)
			begin 
				if y <29 then
					count <= count + 1;
				else
					count <= 0;
				end if;
		end process;
		
		
		process(clk)
			begin
				if clk'event and clk='1' then
					--data_buffer<=data_buffer_next;
					--data_buffer<="1111";
					Xbuffer <=	Xbuffer_next;
					Ybuffer <=	Ybuffer_next;
					if x < 39 then
						z <= x + count;
						--z <= 0;
						--z <= x;
					else
						z <= 6;
					end if;
				end if;
		end process;

	SRAM_ADDRESS <= conv_std_logic_vector(z,12);
	--SRAM_ADDRESS <= "000000000001";
	Data <= data_buffer; 
		x_controlo <= Xbuffer;
		y_controlo <= Ybuffer;
end Behavioral;

 --rgb_next <= PDataBuff when x < 319 and y < 239 else "1010";
