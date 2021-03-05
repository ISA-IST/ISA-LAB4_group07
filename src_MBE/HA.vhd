LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY HA IS
PORT(
		a, b : IN std_logic;
		s, c_out : OUT std_logic);
END HA;

ARCHITECTURE behaviour OF HA IS

BEGIN

	s <= a XOR b;
	c_out <= a AND b;

END behaviour;