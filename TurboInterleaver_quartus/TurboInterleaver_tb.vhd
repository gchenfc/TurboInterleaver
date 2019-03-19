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

	type mem_t is array(0 to 132) of std_logic ;
	signal ram : mem_t;
	attribute ram_init_file : string;
	attribute ram_init_file of ram : signal is "../MATLAB/tests/input0.mif";
	signal ram_out : mem_t;
	attribute ram_init_file_out : string;
	attribute ram_init_file_out of ram_out : signal is "../MATLAB/tests/output_expected0.mif";

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
	end process;

	update: process (clk)
		variable streamBufferIn : boolean := true;
		variable streamBufferOut : boolean := false;
		variable counter :	integer := 0;
	begin
		if (rising_edge(clk)) then
			if (streamBufferIn) then
				if (counter < 1056) then 
					if (counter = 0) then
						look_now_in <= '1';
						dataIn <= '1';
					else
						dataIn <= '0';
					end if;
					counter := counter + 1;
				else
					look_now_in <= '0';
					counter := 0;
					streamBufferIn := false;
					streamBufferOut := true;
				end if;
			elsif (streamBufferOut) then
				look_now_in <= '0';
				if (counter < 1056) then
					report "actual: " & std_logic'image(dataOut) & "\texpected: " & std_logic'image(ram_out(counter));
					counter := counter + 1;
				end if;
			else
				dataIn <= '0';
				look_now_in <= '0';
			end if;
		end if;
	end process;
	flag_long_in <= '0';

	-- Specify Test Vectors
	stim: process is
	begin
		reset_async <= '1';

		wait for 20 ns;

		reset_async <= '0';

		wait for 20 ns;

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