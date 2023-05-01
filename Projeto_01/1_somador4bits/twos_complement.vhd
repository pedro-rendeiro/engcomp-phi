library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity twos_complement is
  port (
    pre_result : in std_logic_vector(4 downto 0);
    pos_result : out std_logic_vector(4 downto 0);
	 op: in std_logic_vector(0 downto 0)
  );
end entity;

architecture comportamento of twos_complement is

begin
	pos_result(0) <= pre_result(0);
	pos_result(1) <= pre_result(1);
	pos_result(2) <= pre_result(2);
	pos_result(3) <= pre_result(3);
	pos_result(4) <= (not op(0)) and pre_result(4);
end comportamento;
