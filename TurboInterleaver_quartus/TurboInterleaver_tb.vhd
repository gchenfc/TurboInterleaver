LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY TurboInterleaver_tb IS

END TurboInterleaver_tb;

ARCHITECTURE test OF TurboInterleaver_tb IS

	COMPONENT TurboInterleaver
		PORT (

			clk, reset_async:			in std_logic;

			dataIn:				in std_logic_vector(7 DOWNTO 0);
			dataInNext: out std_logic;
			dataOut:				out std_logic;
			dataOut2:				out std_logic;
			
			flag_long_in, look_now_in: in std_logic;
			flag_long_out, look_now_out: out std_logic
		);
	END component;

	--component test_input_byte
	--	PORT
	--	(
	--		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	--		clock		: IN STD_LOGIC  := '1';
	--		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	--	);
	--end component;

	SIGNAL clk, reset_async: std_logic;

	signal dataIn:				std_logic_vector(7 DOWNTO 0) := (others => '0');
	signal dataInNext:			std_logic := '0';
	signal dataOut:				std_logic := '0';
	signal dataOut2:				std_logic := '0';
	
	signal flag_long_in, look_now_in: std_logic := '0';
	signal flag_long_out, look_now_out: std_logic := '0';

	signal counter_tmp:		STD_LOGIC_VECTOR (12 DOWNTO 0) := (others => '0');
	signal q_tmp, q_tmpa:		STD_LOGIC_VECTOR (6143 DOWNTO 0) := (others => '0');
	signal q_out:		STD_LOGIC_VECTOR (6143 DOWNTO 0) := (others => '0');
	signal q_out2:		STD_LOGIC_VECTOR (6143 DOWNTO 0) := (others => '0');

	signal counter_output:	STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');

BEGIN

	u1 : TurboInterleaver PORT MAP (
		clk    => clk,
		reset_async    => reset_async,

		dataIn	=>	dataIn,
		dataInNext => dataInNext,
		dataOut	=>	dataOut,
		dataOut2	=>	dataOut2,

		flag_long_in	=>	flag_long_in,
		look_now_in	=>	look_now_in,
		flag_long_out	=>	flag_long_out,
		look_now_out	=>	look_now_out
	);

	--u2 : test_input_byte PORT MAP (
	--	address	 => counter_tmp,
	--	clock	 => clk,
	--	q	 => q_tmp
	--);

	--dataIn <= q_tmp(0);
	q_tmp <= (0 => '1', others => '0');
	q_tmpa <= (1 => '1', others => '0');

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
		variable counter_next :	integer := 0;
		variable counter_out : integer := 0;
		variable parta : boolean := true;
	begin
		if (reset_async='0') then
			if (rising_edge(clk)) then
				counter := counter_next;
				if (streamBufferIn) then
					--if (counter = 0) then
					--	look_now_in <= '1';
					--	if (parta) then
					--		dataIn(7 DOWNTO 0) <= q_tmp(counter+7 DOWNTO counter);
					--	else
					--		dataIn(7 DOWNTO 0) <= q_tmpa(counter+7 DOWNTO counter);
					--	end if;
					--	counter_next := counter + 8;
					if (counter < 6144) then 
						look_now_in <= '1';
						if (dataInNext='1') then
							if (parta) then
								dataIn(7 DOWNTO 0) <= q_tmp(counter+7 DOWNTO counter);
							else
								dataIn(7 DOWNTO 0) <= q_tmpa(counter+7 DOWNTO counter);
							end if;
							counter_next := counter + 8;
						end if;
					else
						--dataIn <= '0';
						look_now_in <= '0';
						counter_next := 0;
						if (parta) then
							parta := false;
						else
							streamBufferIn := false;
							streamBufferOut := true;
						end if;
					end if;
				elsif (streamBufferOut) then
					dataIn <= "00000000";
					look_now_in <= '0';
					if (counter < 6144) then
						q_out(counter) <= dataOut;
						q_out2(counter) <= dataOut2;
						--report "actual: " & std_logic'image(dataOut);
						--report "actual: " & std_logic'image(dataOut) & "\texpected: " & std_logic'image(ram_out(counter));
						counter_next := counter + 1;
					else
						-- do nothing
					end if;
				else
					--dataIn <= '0';
					look_now_in <= '0';
				end if;
				if (look_now_out = '1') then
					counter_out := 0;
				else
					counter_out := counter_out + 1;
				end if;
			end if;
			counter_tmp <= std_logic_vector(to_unsigned(counter,13));
			counter_output <= std_logic_vector(to_unsigned(counter_out,32));
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

		wait for 400000 ns;
		
		assert false
			report "simulation ended"
			severity failure;

		wait;
	end process;

	stop_simulation :process
	begin
		wait for 400000 ns; --run the simulation for this duration
		assert false
			report "simulation ended"
			severity failure;
	end process ;

END test;