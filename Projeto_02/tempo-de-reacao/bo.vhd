--library IEEE_PROPOSED;
--use IEEE_PROPOSED.fixed_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.fixed_pkg.all;

entity bo is
	port(
		clk, comece, bot, clear, init   : in std_logic;
		len, lento, inicio 				: out std_logic;
		rtempo 							: out ufixed(1 downto -10)
	);
end bo;

architecture comportamento of bo is
	signal cont_reg : integer;
	constant clock_period : real := 0.0004;
	
begin

	-- conta as bordas de subida
	contador : process(clk, clear)
	begin
		if clear = '0' then
			if rising_edge(clk) then
				cont_reg <= cont_reg + 1;
			end if;
		else
			cont_reg <= 0;
		end if;
	end process;


	-- liga e desliga a lâmpada
	-- conta o tempo de reação
	reg_len : process(init, bot, cont_reg, clear)
	begin
		if clear = '0' then
			if cont_reg = 25000 then
				inicio <= '1';
				len <= '1';
			end if;

			if init = '1' then
				if bot = '1' then
					len <= '0';
					rtempo <= to_ufixed(2.0, 1, -10);
				end if;
				if cont_reg = 30000 then
					len <= '0';
					lento <= '1';
					rtempo <= to_ufixed(2.0, 1, -10);
				end if;
			end if;
		else
			len 	<= '0';
			lento 	<= '0';
			inicio  <= '0';
			rtempo  <= to_ufixed(0.0, 1, -10);
		end if;
	end process;

end comportamento;