library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component t_reacao is
	port(
		clk, reset, B : in std_logic;
		rtempo 		  : out std_logic_vector(11 downto 0)
	);
	end component;
	
	signal clk, B : std_logic := '0';
	signal reset : std_logic := '1';
	signal rtempo : std_logic_vector(11 downto 0);

begin

	dut: t_reacao
	port map(
		clk => clk,
		reset => reset,
		B => B,
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
end tb;