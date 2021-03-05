LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.numeric_std.all;

ENTITY MBE_mult IS
PORT ( 
	A : IN STD_LOGIC_VECTOR(31 downto 0);
	B : IN STD_LOGIC_VECTOR(31 downto 0);
	M : OUT STD_LOGIC_VECTOR(63 downto 0)
);
END MBE_mult;

ARCHITECTURE arch OF MBE_mult IS

	COMPONENT dadda_tree IS
	PORT ( 
		pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9,
		pp10, pp11, pp12, pp13, pp14, pp15: IN STD_LOGIC_VECTOR(32 downto 0);
		pp16: IN STD_LOGIC_VECTOR(31 downto 0);
		s: IN STD_LOGIC_VECTOR(15 downto 0);
		s_n: IN STD_LOGIC_VECTOR(15 downto 0);
		addend1_out, addend2_out: OUT STD_LOGIC_VECTOR(62 downto 0);
		M_lsb: OUT STD_LOGIC
	);
	END COMPONENT;
	
	COMPONENT MBE_encoder IS
	PORT( 	
			-- b_2j+1, b_2j, b_2j-1
			b2, b1, b0: IN STD_LOGIC;
			A: IN STD_LOGIC_VECTOR(31 downto 0);
			pp: OUT STD_LOGIC_VECTOR(32 downto 0)
	);
	END COMPONENT;
	
	-- signals for dadda_tree
	SIGNAL pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9: STD_LOGIC_VECTOR(32 downto 0);
	SIGNAL pp10, pp11, pp12, pp13, pp14, pp15, pp16_tmp: STD_LOGIC_VECTOR(32 downto 0);
	SIGNAL pp16: STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL s: STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL s_n: STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL addend1_out, addend2_out: STD_LOGIC_VECTOR(62 downto 0);
	SIGNAL M_lsb: STD_LOGIC;
	
	
	SIGNAL M_msbs: STD_LOGIC_VECTOR(62 downto 0);
	SIGNAL M_msbs_tmp: UNSIGNED(62 downto 0);

BEGIN

	pp0_enc: MBE_encoder PORT MAP(b2 => B(1), b1 => B(0), b0 => '0', A => A, pp => pp0);
	s(0) <= B(1);
	s_n(0) <= NOT(s(0));
	
	pp1_enc: MBE_encoder PORT MAP(b2 => B(3), b1 => B(2), b0 => B(1), A => A, pp => pp1);
	s(1) <= B(3);
	s_n(1) <= NOT(s(1));
	
	pp2_enc: MBE_encoder PORT MAP(b2 => B(5), b1 => B(4), b0 => B(3), A => A, pp => pp2);
	s(2) <= B(5);
	s_n(2) <= NOT(s(2));
	
	pp3_enc: MBE_encoder PORT MAP(b2 => B(7), b1 => B(6), b0 => B(5), A => A, pp => pp3);
	s(3) <= B(7);
	s_n(3) <= NOT(s(3));
	
	pp4_enc: MBE_encoder PORT MAP(b2 => B(9), b1 => B(8), b0 => B(7), A => A, pp => pp4);
	s(4) <= B(9);
	s_n(4) <= NOT(s(4));
	
	pp5_enc: MBE_encoder PORT MAP(b2 => B(11), b1 => B(10), b0 => B(9), A => A, pp => pp5);
	s(5) <= B(11);
	s_n(5) <= NOT(s(5));
	
	pp6_enc: MBE_encoder PORT MAP(b2 => B(13), b1 => B(12), b0 => B(11), A => A, pp => pp6);
	s(6) <= B(13);
	s_n(6) <= NOT(s(6));
	
	pp7_enc: MBE_encoder PORT MAP(b2 => B(15), b1 => B(14), b0 => B(13), A => A, pp => pp7);
	s(7) <= B(15);
	s_n(7) <= NOT(s(7));
	
	pp8_enc: MBE_encoder PORT MAP(b2 => B(17), b1 => B(16), b0 => B(15), A => A, pp => pp8);
	s(8) <= B(17);
	s_n(8) <= NOT(s(8));
	
	pp9_enc: MBE_encoder PORT MAP(b2 => B(19), b1 => B(18), b0 => B(17), A => A, pp => pp9);
	s(9) <= B(19);
	s_n(9) <= NOT(s(9));
	
	pp10_enc: MBE_encoder PORT MAP(b2 => B(21), b1 => B(20), b0 => B(19), A => A, pp => pp10);
	s(10) <= B(21);
	s_n(10) <= NOT(s(10));
	
	pp11_enc: MBE_encoder PORT MAP(b2 => B(23), b1 => B(22), b0 => B(21), A => A, pp => pp11);
	s(11) <= B(23);
	s_n(11) <= NOT(s(11));
	
	pp12_enc: MBE_encoder PORT MAP(b2 => B(25), b1 => B(24), b0 => B(23), A => A, pp => pp12);
	s(12) <= B(25);
	s_n(12) <= NOT(s(12));
	
	pp13_enc: MBE_encoder PORT MAP(b2 => B(27), b1 => B(26), b0 => B(25), A => A, pp => pp13);
	s(13) <= B(27);
	s_n(13) <= NOT(s(13));
	
	pp14_enc: MBE_encoder PORT MAP(b2 => B(29), b1 => B(28), b0 => B(27), A => A, pp => pp14);
	s(14) <= B(29);
	s_n(14) <= NOT(s(14));
	
	pp15_enc: MBE_encoder PORT MAP(b2 => B(31), b1 => B(30), b0 => B(29), A => A, pp => pp15);
	s(15) <= B(31);
	s_n(15) <= NOT(s(15));
	
	pp16_enc: MBE_encoder PORT MAP(b2 => '0', b1 => '0', b0 => B(31), A => A, pp => pp16_tmp);
	pp16 <= pp16_tmp(31 downto 0);

	
	adder_tree: dadda_tree PORT MAP (pp0 => pp0, pp1 => pp1, pp2 => pp2, pp3 => pp3, pp4 => pp4, pp5 => pp5, pp6 => pp6,
			pp7 => pp7, pp8 => pp8, pp9 => pp9, pp10 => pp10, pp11 => pp11, pp12 => pp12,
			pp13 => pp13, pp14 => pp14, pp15 => pp15, pp16 => pp16, s => s, s_n => s_n, addend1_out => addend1_out, addend2_out => addend2_out, M_lsb => M_lsb);
			
	-- beh adder
	M_msbs_tmp <= unsigned(addend1_out) + unsigned(addend2_out);
	M_msbs <= std_logic_vector(M_msbs_tmp);
	
	-- final product
	M <= M_msbs & M_lsb;
	

END arch;
