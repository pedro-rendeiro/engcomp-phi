library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component t_reacao
	port(
		clk, rst, comece : in std_logic;
		a_dados, b_dados : in std_logic_vector(7 downto 0);
		ab_end : out std_logic_vector(8 downto 0);
		ab_rd : out std_logic;
		t_reacao_out : out std_logic_vector(31 downto 0)
	);
	end component;
	
	signal clk, comece : std_logic := '0';
	signal rst : std_logic := '1';
	
	signal ab_rd : std_logic;
	signal ab_end : std_logic_vector(8 downto 0);
	signal sads : std_logic_vector(31 downto 0);
	
	constant a_dados : std_logic_vector(7 downto 0) := "00000010";
	constant b_dados : std_logic_vector(7 downto 0) := "00000001";	
	constant w_array : std_logic_vector(0 to 28)
		:= "00010000111001100000111100010";

begin
	
	instancia: sad
	port map(
		clk => clk,
		rst => rst,
		comece => comece,
		a_dados => a_dados,
		b_dados => b_dados,
		ab_rd => ab_rd,
		ab_end => ab_end,
		t_reacao_out => sads
	);
	
	
	clk <= not clk after 0.2 ms;
	rst <= '0' after 1 us;
	comece <= '1' after 1 us;
end tb;