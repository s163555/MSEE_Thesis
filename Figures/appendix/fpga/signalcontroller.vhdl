library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package PulsePckg is

    component signal_controller is
        generic (
            start_delay_resolution : integer := 6;  -- bit width of the counter used delaying pulse train start
            train_length           : integer := 7;  -- bit width of the PWM burst train counter
            gate_delay_resolution  : integer := 6;  -- bit width of the counter used delaying the gate signal start 
            counter_resolution     : integer := 7   -- big enought o hold the largest of above
        );
        port (
            n_reset_i     : in   std_logic;                                                -- async reset
            clk_i         : in   std_logic;                                                -- Input clock.
            start_delay_i : in   std_logic_vector (start_delay_resolution - 1 downto 0);   -- delay before the pulse train.
            train_length_i: in   std_logic_vector (train_length - 1 downto 0);             -- how many PWMs in a burst train.
            gate_delay_i  : in   std_logic_vector (gate_delay_resolution - 1 downto 0);    -- delay before gate signal.
            prime_i       : in   std_logic;                                                -- allow cycle start
            fire_i        : in   std_logic;                                                -- start a cycle
            prf_o         : out  std_logic;                                                -- PRF
            enable_o      : out  std_logic;                                                -- enable pwm
            pulse_o       : out  std_logic;                                                -- PULSE
            gate_o        : out  std_logic;                                                -- GATE
            leds_o        : out std_logic_vector (3 downto 0)
        );
    end component;

end package;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity signal_controller is
    generic (
        train_length           : integer := 7;  -- bit width of the PWM burst train counter
        start_delay_resolution : integer := 6;  -- bit width of the counter used delaying pulse train start
        gate_delay_resolution  : integer := 6;  -- bit width of the counter used delaying the gate signal start 
        counter_resolution     : integer := 7   -- big enought o hold the largest of above
    );
    port (
        n_reset_i     : in   std_logic;                                                -- async reset
        clk_i         : in   std_logic;                                                -- Input clock.
        start_delay_i : in   std_logic_vector (start_delay_resolution - 1 downto 0);   -- delay before the pulse train.
        train_length_i: in   std_logic_vector (train_length - 1 downto 0);             -- how many PWMs in a burst train.
        gate_delay_i  : in   std_logic_vector (gate_delay_resolution - 1 downto 0);    -- delay before gate signal.
        prime_i       : in   std_logic;                                                -- allow cycle start
        fire_i        : in   std_logic;                                                -- start a cycle
        prf_o         : out  std_logic;                                                -- PRF
        enable_o      : out  std_logic;                                                -- enable pwm
        pulse_o       : out  std_logic;                                                -- PULSE
        gate_o        : out  std_logic;                                                -- GATE
        leds_o        : out std_logic_vector (3 downto 0)
    );
end signal_controller;

architecture arch of signal_controller is
    type states is (ready, delay, pulse, gate_delay, gate, done );
    signal counter : integer range 0 to 2**counter_resolution-1;
    signal state  : states;

begin


    clocked: process(clk_i)

    begin

        if rising_edge(clk_i) then
            -- sync reset
            if n_reset_i = '0' then
                counter <= 0;
                state <= ready;
                -- reset output states
                prf_o <= '1';
                enable_o <= '0';
                pulse_o <= '0';
                gate_o <= '0';
                leds_o <= (others => '0');
            else
                counter <= counter + 1;
                -- default output states
                prf_o <= '1';
                enable_o <= '0';
                pulse_o <= '0';
                gate_o <= '0';
                leds_o <= (others => '0');

                case State is

                    when ready =>  -- start a pulse group as soon as the fire bit is set
                        leds_o <= (0 => '1', others => '0');
                        -- check if the caller has reset the prime bit
                        if prime_i = '0' then
                            -- if yes, start if the fire bit is set.
                            if fire_i = '1' then
                                counter <= 0;
                                state <= delay;
                            end if;
                        end if;

                    when delay =>
                        leds_o <= (0 => '0', 1 => '1', others => '0');
                        prf_o <= '0';
                        if counter >= to_integer(unsigned(start_delay_i)) - 1 then
                            counter <= 0;
                            enable_o <= '1';
                            state <= pulse;
                        end if;

                    when pulse =>
                        leds_o <= (0 => '1', 1 => '1', others => '0');
                        enable_o <= '1';
                        prf_o <= '0';
                        if counter < to_integer(unsigned(train_length_i)) - 1 then  -- let the pulse change sync with last edge of PWM
                            pulse_o <= '1';
                        elsif counter = to_integer(unsigned(train_length_i)) - 1 then
                            pulse_o <= '1';
                            counter <= 0;
                            state <= gate_delay;
                        end if;

                    when gate_delay =>
                        leds_o <= (0 => '0', 1 => '0', 2 => '1', others => '0');
                        if counter >= to_integer(unsigned(gate_delay_i)) - 1 then
                            counter <= 0;
                            state <= gate;
                        end if;

                    when gate =>
                        leds_o <= (0 => '1', 1 => '0', 2 => '1', others => '0');
                        gate_o <= '1';
                        if counter = to_integer(unsigned(train_length_i)) - 1 then
                            counter <= 0;
                            state <= done;  -- todo implement
                        end if;

                    when done =>
                        leds_o <= (0 => '1', 1 => '1', 2 => '1', others => '0');
                        -- check if the caller has reset the fire bit
                        if fire_i = '0' then
                            -- if yes, prime if the prime_bit is set.
                            if prime_i = '1' then
                                counter <= 0;
                                state <= ready;
                            end if;
                        end if;

                end case;

            end if; -- sync reset
        end if; -- rising_edge

    end process clocked;

end architecture;
