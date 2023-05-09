library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity invert_top is
    Port ( A : in  STD_LOGIC;
           B : out  STD_LOGIC);
end invert_top;

architecture Behavioral of invert_top is
begin
    -- invert the signal from the push button switch and route it to the LED
    B <= not A;
end Behavioral;