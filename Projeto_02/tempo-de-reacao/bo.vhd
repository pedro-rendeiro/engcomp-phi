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
		clk, bot, clear, init   : in std_logic;
		len, lento, inicio 				: out std_logic;
		rtempo 							: out ufixed(1 downto -10)
	);
end bo;

architecture comportamento of bo is
	signal cont_reg : integer := 0;
	signal aux00 : ufixed(12 downto -1);
	signal aux01 : ufixed(15 downto -2);
	signal aux02 : ufixed(16 downto -15);
	constant div : ufixed( 0 downto -13) := "00000000000001";
	
	
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
		variable aux  : ufixed(1 downto -10);
		variable aux0 : ufixed(12 downto -1);
		variable aux1 : ufixed(15 downto -2);
		variable aux2 : ufixed(16 downto -15);
	begin
		if clear = '0' then
			if cont_reg = 25000 then
				inicio <= '1';
				len <= '1';
			end if;

			if init = '1' then
				if bot = '1' then
					len <= '0';
					lento <= '0';
					
					-- saves number of ticks
					aux0 := to_ufixed(cont_reg - 25000 + 1, 12, -1);
					aux00 <= aux0;
					
					-- multiply number of ticks by 4 => (15 downto -2)
					aux1 := to_ufixed(4, 2, -1) * aux0;
					aux01 <= aux1;

					-- gets time in seconds => (16 downto -15)
					aux2 := aux1 * div;
					aux02 <= aux2;
					
					-- maps aux2 to rtempo
					mapeamento : for i in 1 downto -10 loop
						rtempo(i) <= aux2(i);
					end loop mapeamento;
				end if;
				if cont_reg = 30000 then
					len <= '0';
					lento <= '1';
					rtempo <= to_ufixed(2.0, 1, -10);
				end if;
			end if;
		else
			len 	  <= '0';
			lento   <= '0';
			inicio  <= '0';
			rtempo  <= to_ufixed(0.0, 1, -10);
		end if;
	end process;
	
	

end comportamento;