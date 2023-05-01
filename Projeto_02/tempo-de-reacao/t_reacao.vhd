library ieee;
use ieee.std_logic_1164.all;

entity t_reacao is
	port(
		clk, reset, B : in std_logic;
		rtempo : out std_logic_vector(11 downto 0)
		ab_rd : out std_logic;
		t_reacao_out : out std_logic_vector(31 downto 0)
	);
end t_reacao;

architecture estrutura of t_reacao is
	component bc is
	port(
		clk, reset, lento, B, inicio : in std_logic;
		comece, bot, clear	: out  std_logic;
	);
	end component;
	
	component bo is
	port(
		clk, inicio, clear, bot : in std_logic;
		len, lento : out std_logic;
		rtempo : out std_logic_vector(11 downto 0)
	);
	end component;
	
	signal i_inc, i_clr : std_logic;
	signal soma_clr, soma_ld : std_logic;
	signal sad_reg_ld : std_logic;
	signal i_lt_256 : std_logic;
begin
	data_path : bo
	port map(
		clk => clk,
		a_dados => a_dados, 
		b_dados => b_dados,
		i_inc => i_inc,
		i_clr => i_clr,
		soma_clr => soma_clr,
		soma_ld => soma_ld,
		sad_reg_ld => sad_reg_ld,
		i_lt_256 => i_lt_256,
		bo_out => t_reacao_out
	);
	
	fsm : bc 
	port map(
		clk => clk,
		reset => reset,
		comece => comece,
		i_lt_256 => i_lt_256,
		i_inc => i_inc, 
		i_clr => i_clr,
		soma_clr => soma_clr,
		soma_ld => soma_ld,
		sad_reg_ld => sad_reg_ld,
		ab_rd => ab_rd,
		ab_end => ab_end 
	);
	
	
	
end estrutura;