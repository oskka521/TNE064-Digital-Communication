library ieee;
use ieee.STD_LOGIC_1164.ALL;

entity sync_buff is
	port(
		clk			: in 	STD_LOGIC;
		reset			: in 	STD_LOGIC;
		start			: in 	STD_LOGIC;
		y_control	: out STD_LOGIC_VECTOR(9 downto 0);
		x_control	: out STD_LOGIC_VECTOR(9 downto 0);
		sw				: in 	STD_LOGIC_VECTOR(3 downto 0);
		rgb			: out STD_LOGIC_VECTOR(3 downto 0);
		hsn			: out STD_LOGIC;
		vsn			: out STD_LOGIC
		
	);
end sync_buff;

architecture Behavioral of sync_buff is 
	
	COMPONENT sync_mod
		port(
			clk 			: in 	STD_LOGIC;
			reset 		: in 	STD_LOGIC;
			start 		: in 	STD_LOGIC;
			y_control	: out STD_LOGIC_VECTOR(9 downto 0);
			x_control	: out STD_LOGIC_VECTOR(9 downto 0);
			h_s			: out STD_LOGIC;
			v_s			: out STD_LOGIC;
			video_on		: out STD_LOGIC
		);
	END COMPONENT;
	
	signal sw_next		: STD_LOGIC_VECTOR(3 downto 0);
	signal video 		: STD_LOGIC;
	
	begin
		process(clk)
		begin
			if clk'event and clk = '1' then 
				sw_next <= sw;
			end if;
		end process;
		
		inst_sync_mod: sync_mod PORT MAP(
			clk 			=>		clk,
			reset			=> 	reset,
			start 		=>		start,
			y_control 	=> 	y_control,
			x_control	=> 	x_control,
			h_s 			=> 	hsn,
			v_s			=> 	vsn,
			video_on		=> 	video
		);

		rgb <= "0000" when video = '0' else sw_next;	

end behavioral;