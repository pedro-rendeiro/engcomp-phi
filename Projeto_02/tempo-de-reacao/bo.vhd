library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bo is
	port(
		clk, comece, bot, clear, init : in std_logic;
		len, lento, inicio 				: out std_logic;
		rtempo 								: out std_logic_vector(11 downto 0);
	);
end bo;

architecture comportamento of bo is
	signal cont_reg : std_logic_vector(14 downto 0);
begin
	rtempo <= (others => '0');

	-- limpa as saídas
	reg_rst : process(clear)
	begin
		if clear = '1' then
			len    <= '0';
			lento  <= '0';
			rtempo <= (others => '0');
		end if;
	end process;
	
	-- ativa a lâmpada conectada à saída len
	reg_len : process(clear, comece, clk)
		variable cont : integer := 0;
	begin
		if clear = '0' then
			if comece = '1' then
				if rising_edge(clk) then
					if cont = 25000 then
						len    <= '1';
						inicio <= '1';
					else
						cont := cont + 1;
					end if;
				end if;
			end if;
		else
			cont := 0;
		end if;
	end process;
	
	-- desativa a lâmpada quando o timeout for atingido
	-- ou quando o botão for pressionado
	reg_tempo : process(init, bot, clk)
		variable cont : real := 0.0;
	begin
		if init = '1' then
			if bot = '1' then
				len <= '0';
				rtempo <= std_logic_vector(0.4 * cont);
			end if;
			if rising_edge(clk) then
				if cont = 5000.0 then
					lento <= '1';
					len   <= '0';
					rtempo <= 0.4 * cont;
				else
					cont := cont + 1.0;
				end if;
			end if;
		end if;
	end process;

end comportamento;