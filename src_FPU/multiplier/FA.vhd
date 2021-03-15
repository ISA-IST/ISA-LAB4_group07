LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FA IS
PORT(
		a, b, c_in : IN std_logic;
		s, c_out : OUT std_logic);
END FA;

ARCHITECTURE behaviour OF FA IS

	SIGNAL z : std_logic; -- SEL of MUX

BEGIN

	z <= a XOR b;
	s <= c_in XOR z;
	
	c_out <= (b AND (NOT(z))) OR (c_in AND z);

END behaviour;