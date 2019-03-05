LIBRARY ieee;

USE ieee.std_logic_1164.all;

ENTITY TurboInterleaver_tb IS

END TurboInterleaver_tb;

ARCHITECTURE test OF TurboInterleaver_tb IS

	COMPONENT TurboInterleaver
		PORT (

			clk, reset_async:			in std_logic;

			dataIn:				in std_logic;
			dataOut:				out std_logic;
			
			flag_long_in, look_now_in: in std_logic;
			flag_long_out, look_now_out: out std_logic
		);
	END component;

	SIGNAL clk, reset_async: std_logic;

	signal dataIn:				std_logic;
	signal dataOut:				std_logic;
	
	signal flag_long_in, look_now_in: std_logic;
	signal flag_long_out, look_now_out: std_logic;

	type mem_t is array(0 to 132) of unsigned (7 downto 0);
	signal ram : mem_t;
	attribute ram_init_file : string;
	attribute ram_init_file of ram : signal is "../MATLAB/tests/input0.mif";
	signal ram_out : mem_t;
	attribute ram_init_file_out : string;
	attribute ram_init_file_out of ram_out : signal is "../MATLAB/tests/output_expected0.mif";

	variable streamBufferIn : boolean := false;
	variable streamBufferOut : boolean := true;
	variable counter :	integer := 0;

BEGIN

	u1 : TurboInterleaver PORT MAP (
		clk    => clk,
		reset_async    => reset_async,

		dataIn	=>	dataIn,
		dataOut	=>	dataOut,

		flag_long_in	=>	flag_long_in,
		look_now_in	=>	look_now_in,
		flag_long_out	=>	flag_long_out,
		look_now_out	=>	look_now_out
	);

	-- Specify 10 ns clock
	clock: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;

		if (streamBufferIn) then
			if (counter < 1056) then 
				dataIn := ram(counter);
				counter := counter + 1;
			else
				counter := 0;
				streamBufferIn := false;
				streamBufferOut := true;
			end if;
		end if;
		if (streamBufferOut) then
			if (counter < 1056) then
				report "actual: " & integer'image(dataOut) & "\texpected: " & integer'image(ram_out(counter));
				counter := counter + 1;
			end if;
		end if;

	end process;

	-- Specify Test Vectors
	stim: process is
	begin
		reset_async <= '1';
		counter <= '0';

		wait for 20 ns;

		reset_async <= '0';

		wait for 20 ns;
		streamBufferIn := true;

		wait for 100000 ns;
		
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