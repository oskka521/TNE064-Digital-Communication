library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use IEEE.std_logic_arith.all;

entity moore_4s is
	 
	port(
		clk		 : in	std_logic;
		data_x	: in	std_logic_vector(11 downto 0);
		data_y	: in	std_logic_vector(11 downto 0);
		angle	: in	std_logic_vector(7 downto 0);
		reset	 : in	std_logic;
		x_n   	: out   std_logic_vector(11 downto 0);
      y_n   	: out   std_logic_vector(11 downto 0);
		z_n		: out   std_logic_vector(11 downto 0)
	);
	
end entity;

architecture rtl of moore_4s is

	signal x,y,z :integer range -2048 to 2047;

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3);
	
	-- Register to hold the current state
	signal current_s,next_s: state_type;
	

begin
	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			x  <=(conv_integer(data_x));    -- putting input value datax to register x(0)
			y	<=(conv_integer(data_y));
			z  <=(conv_integer(angle));
			current_s <= s0;
			
		elsif (rising_edge(clk) and reset = '0') then		
			current_s <= next_s;
		end if;
	end process;
	
	-- Output depends solely on the current state
	process (current_s,x,y,z)
	begin
	
		case current_s is
		
			when s0 =>
			if z < 0 THEN        -- stage 1
			x<=x+y;
			y<=y-x;
			z<=z+45;
			next_s <= s1;
			else
			x<=x-y;
			y<=y+x;
			z<=z-45;
			next_s <= s1;
			end if;
			
			when s1 =>	
			if z < 0 THEN        -- stage 2
			x<=x+y/2;
			y<=y-x/2;
			z<=z+26;
			next_s <= s2;
			else
			x<=x-y/2;
			y<=y+x/2;
			z<=z-26;
			next_s <= s2;
			end if;
			
			when s2 =>
			if z < 0 THEN         -- stage 3
			x<=x+y/4;
			y<=y-x/4;
			z<=z+14;
			next_s <= s3;
			else
			x<=x-y/4;
			y<=y+x/4;
			z<=z-14;
			next_s <= s3;
			end if;
			
			when s3 =>
				if z < 0 THEN         -- stage 4
				x<=x+y/8;
				y<=y-x/8;
				z<=z+7;
				next_s <= s0;
				else
				x<=x-y/8;
				y<=y+x/8;
				z<=z-7;
				next_s <= s0;
			end if;
			
		end case;
	end process;
	
	--x_n  <=(conv_std_logic_vector(x,12));    -- putting input value datax to register x(0)
	--y_n	<=y;
	--z_n  <=z;
	-- Logic to determine output
	x_n <=(conv_std_logic_vector(x,12));  -- wire connecting x(5) to output x_n
	y_n <=(conv_std_logic_vector(y,12));  -- wire connecting y(5) to output y_n
	z_n <=(conv_std_logic_vector(z,12));
	
end rtl;
