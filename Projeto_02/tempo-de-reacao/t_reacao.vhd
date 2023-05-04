--library IEEE_PROPOSED;
--use IEEE_PROPOSED.fixed_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

entity t_reacao is
	port(
		clk, reset, B : in std_logic;
		len, lento	  : out std_logic;
		rtempo 		  : out ufixed(2 downto -9)
	);
end t_reacao;

architecture estrutura of t_reacao is
	component bc is
	port(
		clk, reset, lento, B, inicio : in std_logic;
		bot, clear, init	  : out  std_logic
	);
	end component;
	
	component bo is
	port(
		clk, bot, clear, init   : in std_logic;
		len, lento, inicio 				: out std_logic;
		rtempo 							: out ufixed(1 downto -10)
	);
	end component;
	
	signal bot    : std_logic;
	signal clear  : std_logic;
	signal init   : std_logic;
	signal inicio : std_logic;
	signal sign_lento : std_logic;

begin

	lento <= sign_lento;

	fsm : bc 
	port map(
		clk => clk,
		reset => reset,
		lento => sign_lento,
		B => B,
		inicio => inicio,
		bot => bot,
		clear => clear,
		init => init
	);
		
	data_path : bo
	port map(
		clk => clk,
		inicio => inicio,
		clear => clear,
		init => init,
		bot => bot,
		len => len,
		lento => sign_lento,
		rtempo => rtempo
	);
		
end estrutura;