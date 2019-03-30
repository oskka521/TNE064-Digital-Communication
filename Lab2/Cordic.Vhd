    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_signed.all;
    use IEEE.std_logic_arith.all;


entity Cordic is
    generic (
        DATA_WIDTH : natural := 16
    ) ;
    port (
        clk   : in    std_logic;
        res   : in    std_logic;
        datax : in    std_logic_vector((data_width - 1) downto 0);
        datay : in    std_logic_vector((data_width - 1) downto 0);
        angle : in    std_logic_vector(15 downto 0);
        x_n   : out   std_logic_vector((data_width - 1) downto 0);
        y_n   : out   std_logic_vector((data_width - 1) downto 0);
		  z_n   : out   std_logic_vector((data_width - 1) downto 0)
    );
end Cordic;

architecture arch of Cordic is
    subtype vec is integer range -2048 to 2047;
    type arvec is array (0 to 6) of vec;
    signal x,y,z : arvec;

begin

process (res,clk)

begin
if res ='0' then            -- reset all registers
x(0) <=0;
x(1) <=0;
x(2) <=0;
x(3) <=0;
x(4) <=0;
x(5) <=0;
x(6) <=0;

y(0) <=0;
y(1) <=0;
y(2) <=0;
y(3) <=0;
y(4) <=0;
y(5) <=0;
y(6) <=0;

z(0) <=0;
z(1) <=0;
z(2) <=0;
z(3) <=0;
z(4) <=0;
z(5) <=0;
z(6) <=0;
else

if clk ='1' and clk'event then
x(0) <=(conv_integer(datax));    -- putting input value datax to register x(0)
y(0) <=(conv_integer(datay));
z(0) <=(conv_integer(angle))*4; -- shift left to get 2 decimals

if z(0) < 0 THEN        -- stage 1
   x(1)<=x(0)+y(0);
   y(1)<=y(0)-x(0);
   z(1)<=z(0)+45*4;
else
    x(1)<=x(0)-y(0);
    y(1)<=y(0)+x(0);
    z(1)<=z(0)-45*4;
end if;

if z(1) < 0 THEN        -- stage 2
    x(2)<=x(1)+y(1)/2;
    y(2)<=y(1)-x(1)/2;
    z(2)<=z(1)+26*4;
else
    x(2)<=x(1)-y(1)/2;
    y(2)<=y(1)+x(1)/2;
    z(2)<=z(1)-26*4;
end if;

if z(2) < 0 THEN         -- stage 3
   x(3)<=x(2)+y(2)/4;
   y(3)<=y(2)-x(2)/4;
   z(3)<=z(2)+14*4;
else
    x(3)<=x(2)-y(2)/4;
    y(3)<=y(2)+x(2)/4;
    z(3)<=z(2)-14*4;
end if;

if z(3) < 0 THEN         -- stage 4
    x(4)<=x(3)+y(3)/8;
    y(4)<=y(3)-x(3)/8;
    z(4)<=z(3)+7*4;
else
    x(4)<=x(3)-y(3)/8;
    y(4)<=y(3)+x(3)/8;
    z(4)<=z(3)-7*4;
end if;

if z(4) < 0 THEN         -- stage 5
    x(5)<=x(4)+y(4)/16;
    y(5)<=y(4)-x(4)/16;
    z(5)<=z(4)+3*4;
else
    x(5)<=x(4)-y(4)/16;
    y(5)<=y(4)+x(4)/16;
    z(5)<=z(4)-3*4;
end if;

if z(5) < 0 THEN         -- stage 6
    x(6)<=x(5)+y(5)/32;
    y(6)<=y(5)-x(5)/32;
    z(6)<=z(5)+1*4;
else
    x(6)<=x(5)-y(5)/32;
    y(6)<=y(5)+x(5)/32;
    z(6)<=z(5)-1*4;
end if;

end if;
end if;
end process;
 x_n <=(conv_std_logic_vector(x(6),16));  -- wire connecting x(5) to output x_n
 y_n <=(conv_std_logic_vector(y(6),16));  -- wire connecting y(5) to output y_n
 z_n <=(conv_std_logic_vector(z(6),16));  -- wire connecting z(5) to output z_n

end arch;

