library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bc is
	port(
		clk, reset, lento, B, inicio : in std_logic;
		comece, bot, clear, init	  : out  std_logic
	);
end bc;

architecture comportamento of bc is
	type tipo_estado is (S0, S1, S2, S3);
	signal prox_estado, estado : tipo_estado := S0;
begin
	-- Circuito combinacional -> não depende de clock
	logica_proximo_estado : process(estado, inicio)
	begin
		case estado is
			when S0 =>
				prox_estado <= S1;
			when S1 => 
				if inicio = '1' then
					prox_estado <= S2;
				end if;
			when S2 =>
				if lento = '1' or B = '1' then
					prox_estado <= S3;
				end if;
		end case;
	end process;
	
	registrador_estado : process(clk, reset)
	begin
		if reset = '1' then
			estado <= S0;
		elsif rising_edge(clk) then
			estado <= prox_estado;
		end if;
	end process;
	
	-- Circuito combinacional -> não depende de clock
	logica_saida : process(estado)
	begin
		case estado is
			when S0 =>
				comece <= '0';
				bot <= '0';
				clear <= '1';
				init <= '0';
			when S1 =>
				comece <= '1';
				bot <= '0';
				clear <= '0';
				init <= '0';
			when S2 =>
				comece <= '0';
				bot <= B;
				clear <= '0';
				init <= '1';
			when S3 =>
				comece <= '0';
				bot <= '0';
				clear <= '0';
				init <= '0';
		end case;
	end process;
	
end architecture;