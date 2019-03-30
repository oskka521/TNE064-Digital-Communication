library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vhdl_binary_counter is
	port(C, CLR : in std_logic;
		  Q: out std_logic_vector(3 downto 0));
end vhdl_binary_counter;

architecture bhv of vhdl_binary_counter is
	signal tmp: std_logic_vector(3 downto 0);
begin
process (C, CLR)
begin
if CLR='1' then
	tmp <= "0000";
elsif (C'event and C='1') then
	if tmp = "1001" then
		tmp <= "0000";
	else
		tmp <= tmp + 1;
	end if;
end if;
end process;
Q <= tmp;
end bhv;
