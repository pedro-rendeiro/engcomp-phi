library ieee;
use ieee.std_logic_1164.all;

entity t_reacao is
	port(
		clk, reset, B : in std_logic;
		rtempo 		  : out real
	);
end t_reacao;

architecture estrutura of t_reacao is
	component bc is
	port(
		clk, reset, lento, B, inicio : in std_logic;
		comece, bot, clear, init	  : out  std_logic
	);
	end component;
	
	component bo is
	port(
		clk, inicio, clear, bot, init : in std_logic;
		len, lento 							: out std_logic;
		rtempo 								: out real
	);
	end component;
	
	signal bot    : std_logic;
	signal clear  : std_logic;
	signal init   : std_logic;
	signal comece : std_logic;
	signal inicio : std_logic;
	signal lento  : std_logic;
	signal len	  : std_logic;

begin
	fsm : bc 
	port map(
		clk => clk,
		reset => reset,
		lento => lento,
		B => B,
		inicio => inicio,
		comece => comece,
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
		lento => lento,
		rtempo => rtempo
	);
		
		
end estrutura;