library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package PulsePckg is

component signal_controller is
  generic (
    train_length           : integer := 7;  -- bit width of the PWM burst train counter
    start_delay_resolution : integer := 6;  -- bit width of the counter used delaying pulse train start
    gate_delay_resolution  : integer := 6   -- bit width of the counter used delaying the gate signal start 
  );
  port (
    n_reset_i     : in   std_logic;                                                -- async reset
    clk_i         : in   std_logic;                                                -- Input clock.
    train_length_i: in   std_logic_vector (train_length - 1 downto 0);             -- how many PWMs in a burst train.
    start_delay_i : in   std_logic_vector (start_delay_resolution - 1 downto 0);   -- Duty-cycle input.
    prime_i       : in   std_logic;                                                -- allow cycle start
    fire_i        : in   std_logic;                                                -- start a cycle
    enable_o      : out  std_logic                                                 -- enable pwm and PULSE
  );
end component;

end package;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity signal_controller is
  generic (
    train_length           : integer := 7;  -- bit width of the PWM burst train counter
    start_delay_resolution : integer := 6;  -- bit width of the counter used delaying pulse train start
    gate_delay_resolution  : integer := 6   -- bit width of the counter used delaying the gate signal start 
  );
  port (
    n_reset_i     : in   std_logic;                                                -- async reset
    clk_i         : in   std_logic;                                                -- Input clock.
    train_length_i: in   std_logic_vector (train_length - 1 downto 0);             -- how many PWMs in a burst train.
    start_delay_i : in   std_logic_vector (start_delay_resolution - 1 downto 0);   -- Duty-cycle input.
    prime_i       : in   std_logic;                                                -- allow cycle start
    fire_i        : in   std_logic;                                                -- start a cycle
    enable_o      : out  std_logic                                                 -- enable pwm and PULSE
  );
end signal_controller;

architecture arch of signal_controller is
  signal train_counter : std_logic_vector (train_length downto 0);
  signal enable_refire: std_logic;
  signal isrunning    : std_logic;

  
begin


  clocked: process(clk_i, n_reset_i)

  begin

    enable_o <= '0';

     -- async reset
    if n_reset_i = '0' then
      train_counter <= (others => '0');
      enable_refire <= '1';
      isrunning <= '0';

    elsif rising_edge(clk_i) then
    
    
    -- ....logic