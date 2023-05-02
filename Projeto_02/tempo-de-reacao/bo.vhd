library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity bo is
	port(
		clk, comece, bot, clear, init   : in std_logic;
		len, lento, inicio 				: out std_logic;
		rtempo 							: out std_logic_vector(6 downto -5)
	);
end bo;

architecture comportamento of bo is
	signal cont_reg : real;
	constant clock_period : real := 0.0004;
	
begin

	-- conta o número de bordas de subida
	contador : process(clk, clear, comece, init)
	begin
		if clear = '0' then
			if rising_edge(clk) then
				cont_reg <= cont_reg + clock_period;
			end if;
			if falling_edge(comece) then
				cont_reg <= (others => '0');
			end if;
		else
			cont_reg <= (others => '0');
		end if;
	end process;


	-- liga e desliga a lâmpada
	-- conta o tempo de reação
	reg_len : process(init, bot, clk, clear)
	begin
		if clear = '0' then
			if cont_reg >= 10.0 then
				inicio <= '1';
				len <= '1';
			end if;

			if init = '1' then
				if bot = '1' then
					len <= '0';
					rtempo <= std_logic_vector(resize(to_integer(cont_reg) * 0.0004, rtempo'length));
				end if;
				if cont_reg >= 2.0 then
					len <= '0';
					lento <= '1';
					rtempo <= std_logic_vector(to_unsigned(2.0, 12));
				end if;
			end if;
		else
			len 	<= '0';
			lento 	<= '0';
			inicio  <= '0';
			rtempo  <= (others => '0');
		end if;
	end process;

end comportamento;