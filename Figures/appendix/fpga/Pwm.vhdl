--*********************************************************************
-- Module for generating repetitive pulses.
--*********************************************************************

library IEEE;
use IEEE.std_logic_1164.all;

package PulsePckg is

    constant HI   : std_logic := '1';
    constant LO   : std_logic := '0';
    constant ONE  : std_logic := '1';

    component Pwm is
        generic (
            resolution : integer := 6; -- bit width of the counter used for duty cycle
            band_bits : integer := 4   -- bit width of the variable that holds the desired deadband
        );
        port (
            n_reset_i : in  std_logic;          -- async reset
            enable_i : in  std_logic;           -- enable the outputs
            clk_i  : in  std_logic;             -- Input clock.
            duty_i : in  std_logic_vector (resolution - 1 downto 0);      -- Duty-cycle input.
            band_i : in  std_logic_vector (band_bits - 1  downto 0);      -- number of clock-ticks to keep both signals low before rising edge
            pwmA_o  : out std_logic;            -- PWM output.
            pwmB_o  : out std_logic             -- PWM output inverse.
        );
    end component;

end package;

--*********************************************************************
-- PWM module.
--*********************************************************************

library IEEE;
use IEEE.MATH_REAL.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.PulsePckg.all;

entity Pwm is
    generic (
        resolution : integer := 6;
        band_bits : integer := 4
    );
    port (
        n_reset_i : in  std_logic;          -- async reset
        enable_i : in  std_logic;           -- enable the outputs
        clk_i  : in  std_logic;             -- Input clock.
        duty_i : in  std_logic_vector (resolution - 1 downto 0);      -- Duty-cycle input.
        band_i : in  std_logic_vector (band_bits - 1 downto 0);      -- number of clock-ticks to keep both signals low before rising edge
        pwmA_o  : out std_logic;            -- PWM output.
        pwmB_o  : out std_logic             -- PWM output inverse.
    );
end entity;

architecture arch of Pwm is
    signal timer_r       : natural range 0 to 2**duty_i'length-1;
begin

    clocked: process(clk_i)
    begin

        if rising_edge(clk_i) then
            -- sync reset
            if n_reset_i = '0' then
                pwmA_o   <= LO;
                pwmB_o   <= LO;
                timer_r <= 0;
            else

                -- timer
                timer_r <= timer_r + 1;
                pwmA_o   <= LO;
                pwmB_o   <= LO;
                if enable_i = '0' then
                    pwmB_o   <= LO;
                    timer_r <= 0;
                else
                    -- output a
                    if timer_r <= unsigned(duty_i) and timer_r >= unsigned(band_i)  then
                        pwmA_o <= HI;
                    end if;
                    -- output b
                    if timer_r > to_integer(unsigned(band_i)) + to_integer(unsigned(duty_i)) then
                        pwmB_o <= HI;
                    end if;
                end if; -- enable

            end if; -- sync reset
        end if; -- rising_edge
    end process clocked;


end architecture;