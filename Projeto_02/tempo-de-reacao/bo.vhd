library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bo is
	port(
		clk, comece, bot, clear : in std_logic;
		len, lento, inicio 		: out std_logic;
		rtempo 					: out std_logic_vector(11 downto 0)
	);
end bo;

architecture comportamento of bo is
	signal cont_reg : std_logic_vector(14 downto 0);
begin
	rtempo <= (others => '0');

	-- limpa as saídas
	reg_rst : process(clear)
	begin
		if clear then
			len    <= '0';
			lento  <= '0';
			rtempo <= (others => '0');
		end if;
	end process;
	
	-- ativa a lâmpada conectada à saída len
	reg_len : process(comece, clk)
	begin
		if comece then
			if rising_edge(clk) then
				if to_integer(unsigned(cont_reg)) = 25000 then
					len    <= '1';
					inicio <= '1';
				else
					cont_reg <= cont_reg + '1';
				end if;
			end if;
		end if;
	end process;
	
	-- desativa a lâmpada quando o timeout for atingido
	-- ou quando o botão for pressionado
	reg_tempo : process(len, bot, clk)
	begin
		if len
			if rising_edge(clk) then
				if to_integer(unsigned(rtempo)) = 5000 then
					lento <= '1';
					len   <= '0';
				elsif bot = '1' then
					len <= '0';
				else
					rtempo <= rtempo + '1';
				end if;
			end if;
		end if;
	end process;

end comportamento;