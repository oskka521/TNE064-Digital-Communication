library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sync_mod is
	 Port ( clk         : in   STD_LOGIC;
			  reset       : in   STD_LOGIC;
			  start       : in   STD_LOGIC;
			  y_control   : out  STD_LOGIC_VECTOR (9 downto 0);
			  x_control   : out  STD_LOGIC_VECTOR (9 downto 0);
			  h_s         : out  STD_LOGIC;
			  v_s         : out  STD_LOGIC;
			  video_on	  : out 	STD_LOGIC
			  );
end sync_mod;

architecture Behavioral of sync_mod is

	constant 	HR:		integer:=640;	--Horizontal Resolution
	constant 	HFP:		integer:=16;	--Horizontal Front Porch 
	constant 	HBP:		integer:=48;	--Horizontal Back Porch
	constant 	HRet:		integer:=96;	--Horizontal retrace
	constant 	VR:		integer:=480;	--Vertical Resolution
	constant 	VFP:		integer:=10;	--Vertical Front Porch 
	constant 	VBP:		integer:=33;	--Vertical Back Porch
	constant 	VRet:		integer:=2;		--Vertical Retrace
	
	signal 	counter_horisontel,counter_horisontel_next:  integer range 0 to 799; --för skärm	
	signal 	counter_vertikal,counter_vertikal_next:		integer range 0 to 524; --för skräm
	signal 	counter_mod2,counter_mod2_next: std_logic:='0'; --related to the clock and the startb
	signal 	horisontel_end, vertikal_end:						std_logic:='0'; --säger när nått stop
	signal 	hs_buffer,hs_buffer_next:			std_logic:='0'; -- to the Vga pos
	signal 	vs_buffer,vs_buffer_next:			std_logic:='0'; -- to the Vga pos
	signal	x_counter, x_counter_next:		integer range 0 to 900; --går bara till 639, pixel för bild
	signal 	y_counter, y_counter_next:		integer range 0 to 900; --går bara till 479, pixel för bild
	signal 	video:	std_logic;

	

begin
	--clk register
	process(clk,reset,start)
	begin
		if reset ='1' then
			counter_horisontel<=0;
			counter_vertikal<=0;
			hs_buffer<='0';
			hs_buffer<='0';
			counter_mod2<='0';
		elsif clk'event and clk='1' then
			if start='1' then
				counter_horisontel<=counter_horisontel_next;
				counter_vertikal<=counter_vertikal_next;
				x_counter<=x_counter_next;
				y_counter<=y_counter_next;
				hs_buffer<=hs_buffer_next;
				vs_buffer<=vs_buffer_next;
				counter_mod2<=counter_mod2_next;
			end if;
		end if;
	end process;

   video <= '1' when  (counter_vertikal >= VBP) and (counter_vertikal < VBP + VR) and (counter_horisontel >=HBP) and (counter_horisontel < HBP + HR)else '0'; 
	
   counter_mod2_next<= not counter_mod2;
   horisontel_end<= '1' when counter_horisontel=799 else '0';        
   vertikal_end<= '1' when counter_vertikal=524 else '0';  
	
	-- Horizontal Counter
	process(counter_horisontel,counter_mod2,horisontel_end)
	begin
		counter_horisontel_next <= counter_horisontel;
		if  counter_mod2= '1' then
			if horisontel_end='1' then
				counter_horisontel_next<=0;
			else
				counter_horisontel_next<=counter_horisontel+1;
			end if;
		end if;
	end process;

	-- Vertical Counter
	process(counter_vertikal,counter_mod2,horisontel_end,vertikal_end)
	begin         
		counter_vertikal_next <= counter_vertikal;
		if  counter_mod2= '1' and horisontel_end='1'  then
			if vertikal_end='1' then
				counter_vertikal_next<=0;
			else
				counter_vertikal_next<=counter_vertikal+1;
			end if;
		end if;
	end process;

	--pixel x Counter
	process(x_counter,counter_mod2,horisontel_end,video)
	begin        
		x_counter_next<=x_counter;
		if video = '1' then 
		
			if  counter_mod2= '1' then                             
				if x_counter= 639 then
					x_counter_next<=0;
				else
				x_counter_next<=x_counter + 1;
				end if;
			end if;
			else
			x_counter_next<=0;
		end if;
	end process;

	--pixsel y Counter
	process(y_counter,counter_mod2,horisontel_end,counter_vertikal)
	begin         
		y_counter_next<=y_counter;
		if  counter_mod2= '1' and horisontel_end='1' then 
			if counter_vertikal >32 and counter_vertikal <512  then
				y_counter_next<=y_counter + 1;
			else 
				y_counter_next<=0;                            
			end if;
		end if;
	end process;

	 hs_buffer_next<= '1' when counter_horisontel < 704 else '0'; --(HBP+HGO+HFP) 
	 vs_buffer_next<='1'  when counter_vertikal < 523 else '0'; --(VBP+VGO+VFP)       

	y_control 	<= 	conv_std_logic_vector(y_counter,10); 
	x_control 	<= 	conv_std_logic_vector(x_counter,10); 
	h_s			<= 	hs_buffer; 
	v_s			<= 	vs_buffer;
	video_on		<= 	video;
end Behavioral;

 
