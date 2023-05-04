--library IEEE_PROPOSED;
--use IEEE_PROPOSED.fixed_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;


entity testbench is
end testbench;

architecture tb of testbench is
	component t_reacao is
	port(
		clk, reset, B : in std_logic;
		len, lento	  : out std_logic;
		rtempo 		  : out ufixed(1 downto -10)
	);
	end component;
	
	signal clk : std_logic := '0';
	signal reset : std_logic := '1';
	signal B : std_logic := '0';
	signal len : std_logic;
	signal lento : std_logic;
	signal rtempo : ufixed(1 downto -10);

begin

	dut: t_reacao
	port map(
		clk => clk,
		reset => reset,
		B => B,
		len => len,
		lento => lento,
		rtempo => rtempo
	);

	process(clk)
		variable init : std_logic := '0';
	begin
		if rising_edge(clk) then
			if init = '0' then
				init := '1';
				reset <= '0';
			end if;
		end if;
	end process;

	clk <= not clk after 0.2 ms;
	B <= not B after 10.4 sec;
end tb;