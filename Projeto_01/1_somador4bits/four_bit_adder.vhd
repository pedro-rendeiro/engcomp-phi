library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
  port (
    in_a     : in  std_logic_vector(3 downto 0);  -- input a, 4 bits
    in_b     : in  std_logic_vector(3 downto 0);  -- input b, 4 bits
    result   : out std_logic_vector(4 downto 0);  -- output sum, 4 bits
	 op	 : in std_logic_vector(0 downto 0)
  );
end entity;

architecture comportamento of four_bit_adder is
	component one_bit_adder is
	port (
    a     : in  std_logic;  -- input a
    b     : in  std_logic;  -- input b
    cin   : in  std_logic;  -- input carry-in
    sum   : out std_logic;  -- output sum
    cout  : out std_logic   -- output carry-out
  );
	end component;
	
	signal c : std_logic_vector(2 downto 0);  -- carry signals
	signal bxor : std_logic_vector(3 downto 0);
	
begin

	bxor(0) <= in_b(0) xor op(0);

	inst_one_bit_adder0 : one_bit_adder
	port map (
	 a => in_a(0),
	 b => bxor(0),
	 cin => op(0),
	 sum => result(0),
	 cout => c(0)
	);

	bxor(1) <= in_b(1) xor op(0);
  
	inst_one_bit_adder1 : one_bit_adder
	port map (
	 a => in_a(1),
	 b => bxor(1),
	 cin => c(0),
	 sum => result(1),
	 cout => c(1)
	);

	bxor(2) <= in_b(2) xor op(0);
  
	inst_one_bit_adder2 : one_bit_adder
	port map (
	 a => in_a(2),
	 b => bxor(2),
	 cin => c(1),
	 sum => result(2),
	 cout => c(2)
	);

	bxor(3) <= in_b(3) xor op(0);
  
	inst_one_bit_adder3 : one_bit_adder
	port map (
	 a => in_a(3),
	 b => bxor(3),
	 cin => c(2),
	 sum => result(3),
	 cout => result(4)
	);

end comportamento;
