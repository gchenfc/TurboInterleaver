LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

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
	
	COMPONENT test_input
		PORT ( 
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0):= "00000000";
		clk		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END component;
	
	COMPONENT test_output
		PORT (
		aclr		: IN STD_LOGIC  := '0';
		address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0):= "00000000";
		clk		: IN STD_LOGIC  := '1';
		q_o		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END component; 
	
	
	
	signal clk, reset_async: std_logic;
	signal aclr: std_logic := '0';

	signal dataIn:				std_logic;
	signal dataOut:				std_logic;
	
	signal flag_long_in, look_now_in: std_logic;
	signal flag_long_out, look_now_out: std_logic;
	
--
	signal 	q			: STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal	q_o		: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL address	:  STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
	
	
	--type mem_t is array(0 to 132) of BYTE;
	--type mem_t is array(0 to 132) of std_logic_vector(7 downto 0);
	--signal ram : mem_t;
	
	signal intermed_in, intermed_out: std_logic_vector(7 downto 0);
	
	--attribute ram_init_file : string;
	--attribute ram_init_file of ram : signal is "../MATLAB/tests/input0.mif";
	--signal ram_out : mem_t;
	--attribute ram_init_file_out : string;
	--attribute ram_init_file_out of ram_out : signal is "../MATLAB/tests/output_expected0.mif";

	
	--
--	variable streamBufferIn : boolean := false;
--	variable streamBufferOut : boolean := true;
--	variable counter :	integer := 0;

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
	
	test_input_inst : test_input PORT MAP (
		aclr => aclr,	
		address => address, 
		clk => clk,		
		q => q	
	);
	
	test_output_inst: test_output PORT MAP (
		aclr=>aclr,
		address => address,
		clk => clk,
		q_o => q_o
		);

	-- Specify 10 ns clock
	clock: process
	variable streamBufferIn : boolean := false;
	variable streamBufferOut : boolean := true;
	variable counter :	integer := 0;
	
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		
		address <= std_logic_vector(to_unsigned(counter/8, 8));

		if (streamBufferIn) then
			if (counter < 1056) then 
				--intermed_in <= ram(counter/8);
				dataIn <= q(counter mod 8);
				counter := counter + 1;
			else
				counter := 0;
				streamBufferIn := false;
				streamBufferOut := true;
			end if;
		end if;
		if (streamBufferOut) then
			if (counter < 1056) then
				--intermed_out <= ram_out(counter/8);
				dataOut <= q_o(counter mod 8);
				report "actual: " & std_logic'image(dataOut) & "\texpected: " & std_logic'image(dataOut);
				counter := counter + 1;
			end if;
		end if;

	end process;

	-- Specify Test Vectors
	stim: process is
	begin
		reset_async <= '1';
		--counter := 0;

		wait for 20 ns;

		reset_async <= '0';

		wait for 20 ns;
		--streamBufferIn := true;

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