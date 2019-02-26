LIBRARY ieee;

USE ieee.std_logic_1164.all;

 

ENTITY TurboInterleaver_interleaver_tb IS

END TurboInterleaver_interleaver_tb;

 

ARCHITECTURE test OF TurboInterleaver_interleaver_tb IS

 

	COMPONENT TurboInterleaver_Interleaver 
		PORT (

			clk, reset_async:			in std_logic;

			dataBufferIn_short:			in std_logic_vector(1055 DOWNTO 0);
			dataBufferIn_long:			in std_logic_vector(6143 DOWNTO 0);
			dataBufferOut_short:		out std_logic_vector(1055 DOWNTO 0);
			dataBufferOut_long:			out std_logic_vector(6143 DOWNTO 0)
		);
	END component;

	SIGNAL clk, reset_async: std_logic;

	SIGNAL dataBufferIn_short:	 std_logic_vector(1055 DOWNTO 0);
	SIGNAL dataBufferIn_long:	 std_logic_vector(6143 DOWNTO 0);
	SIGNAL dataBufferOut_short:	std_logic_vector(1055 DOWNTO 0);
	SIGNAL dataBufferOut_long:		std_logic_vector(6143 DOWNTO 0);

BEGIN

	u1 : TurboInterleaver_Interleaver PORT MAP (
		  clk    => clk,
		  reset_async    => reset_async,
		  dataBufferIn_short 	=> dataBufferIn_short,
		  dataBufferIn_long 	=> dataBufferIn_long,
		  dataBufferOut_short	=> dataBufferOut_short,
		  dataBufferOut_long 	=> dataBufferOut_long
	);

	-- Initialize all input signals

	clk <= '0';

	reset_async <= '1';

	dataBufferIn_short <=  (0 => '1', others=>'0');
	dataBufferIn_long <=  (0 => '1', others=>'0');

	-- Specify 10 ns clock

	clock: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	-- Specify Test Vectors

	stim: process is
	begin

		reset_async <= '1';

		wait for 20 ns;

		reset_async <= '0';

		wait for 20 ns;

		dataBufferIn_long <= (0 => '1', others=>'0');
		dataBufferIn_short<= (0 => '1', others=>'0');

		wait for 40 ns;

		--dataBufferIn_long (5 DOWNTO 0) <= "000010";
		--dataBufferIn_short(5 DOWNTO 0) <= "000010";

		wait for 40 ns;

		dataBufferIn_long <= (0 => '0', 
							  1 => '1', others=>'0');
		dataBufferIn_short<= (0 => '0', 
							  1 => '1', others=>'0');

		wait for 40 ns;

		--dataBufferIn_long (5 DOWNTO 0) <= "001000";
		--dataBufferIn_short(5 DOWNTO 0) <= "001000";

		wait for 40 ns;

		dataBufferIn_long <= (0 => '0', 
							  1 => '0', 
							  2 => '1', others=>'0');
		dataBufferIn_short<= (0 => '0', 
							  1 => '0', 
							  2 => '1', others=>'0');

		wait for 40 ns;
		
		assert false
			report "simulation ended"
			severity failure;

		wait;
	end process;

	stop_simulation :process
	begin
		wait for 10000 ns; --run the simulation for this duration
		assert false
			report "simulation ended"
			severity failure;
	end process ;

END test;