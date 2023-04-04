library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;

entity testbench is
end testbench;

architecture test of testbench is
	component four_bit_adder is
	port (
    in_a     : in  std_logic_vector(3 downto 0);  -- input a, 4 bits
    in_b     : in  std_logic_vector(3 downto 0);  -- input b, 4 bits
    result   : out std_logic_vector(4 downto 0);  -- output sum, 4 bits
	 op	 : in std_logic_vector(0 downto 0)
	);
	end component;
	
	signal sign_a, sign_b : std_logic_vector(3 downto 0);
	signal sign_result : std_logic_vector(4 downto 0);
	signal sign_op : std_logic_vector(0 downto 0);
	signal sign_clk : std_logic := '0';
	signal sign_enable_write : std_logic := '1';
	
	
	-- instância de sd e mapeamento porta => sinal
begin
	dut: four_bit_adder  -- device under test (dut)
	port map(
		in_a => sign_a,
		in_b => sign_b,
		op => sign_op,
		result => sign_result
	);
	
	-- processo para ler do arquivo de texto e atribuir aos sinais
	process(sign_clk)
		file F: TEXT open READ_MODE is "C:\Users\pedro\OneDrive\fotos\Pedro\UFPA_EngComp\2023.2\phi\Projetos\1_somador4bits\entradas.txt";
		variable L: LINE;
		variable entrada : integer;
	begin
		if rising_edge(sign_clk) then
			if not endfile(F) then
				-- Lê o arquivo (F) e atribui uma linha a L
				READLINE(F, L);
				-- Lê a linha L e atribui um inteiro à variável entrada
				READ(L, entrada);
				-- atribui o valor da variável entrada convertido para um vetor de bits no sinal sign_a
				sign_a <= std_logic_vector(to_unsigned(entrada, 4));
				
				-- repete o procedimento para o sinal sign_b
				READLINE(F, L);
				READ (L, entrada);
				sign_b <= std_logic_vector(to_unsigned(entrada, 4));
				
				READLINE(F, L);
				READ (L, entrada);
				sign_op <= std_logic_vector(to_unsigned(entrada, 1));
			else 
				sign_enable_write <= '0';
			end if;
		end if;
	end process;
	
	-- processo para escrever em um arquivo de texto
	process(sign_clk)
		file F: TEXT open WRITE_MODE is "C:\Users\pedro\OneDrive\fotos\Pedro\UFPA_EngComp\2023.2\phi\Projetos\1_somador4bits\saida.txt";
		variable L: LINE;
	begin
		if sign_enable_write = '1' then
			if rising_edge(sign_clk) then
				-- escreve em uma linha o valor do sinal sign_mid_result convertido para um inteiro
				WRITE (L, to_integer(unsigned(sign_result)));
				-- escreve no arquivo F a linha L
				WRITELINE (F, L);
			end if;
		end if;
	end process;
	
	sign_clk <= not sign_clk after 5 ns;
end test;