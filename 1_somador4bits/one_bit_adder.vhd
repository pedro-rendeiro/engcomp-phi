library ieee;
use ieee.std_logic_1164.all;

entity one_bit_adder is
  port (
    a     : in  std_logic;  -- input a
    b     : in  std_logic;  -- input b
    cin   : in  std_logic;  -- input carry-in
    sum   : out std_logic;  -- output sum
    cout  : out std_logic   -- output carry-out
  );
end entity;

architecture comportamento of one_bit_adder is
begin

   -- Full Adder logic implementation
   sum <= a xor b xor cin;
   cout <= (a and b) or (cin and (a xor b));

end comportamento;
