library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataIn:				in std_logic_vector(7 DOWNTO 0);
		dataInNext: out std_logic;
		dataOut:				out std_logic;
		dataOut2:				out std_logic;
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic
	);
end TurboInterleaver;

architecture arch1 of TurboInterleaver is

	--component TurboInterleaver_StateMachine
	--	PORT (
	--		clock_sig		:	in std_logic;
	--		reset_sig		:	in std_logic;
	--		in_looknow_sig	:	in std_logic;
	--		in_long_sig		:	in std_logic;
	--		debug_out_reset_sig		:	out std_logic;
	--		debug_out_enable_sig		:	out std_logic;
	--		debug_out_perform_sig	:	out std_logic;
	--		out_looknow_sig: 	out std_logic;
	--		out_long_sig	:	out std_logic;
	--		debug_out_q				:	out std_logic_vector (12 downto 0)
	--	);
	--END component;
	
	component TurboInterleaver_Interleaver
		PORT (

			clk, reset_async:			in std_logic;
			flag_long:					in std_logic;

			dataBufferIn:			in std_logic_vector(6143 DOWNTO 0);
			dataBufferOut:			out std_logic_vector(6143 DOWNTO 0)
		);
	END component;
	
	component TurboInterleaver_shiftRegIn
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (6143 DOWNTO 0)
		);
	end component;
	component TurboInterleaver_shiftRegInFlags
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			shiftout		: OUT STD_LOGIC 
		);
	end component;
	component TurboInterleaver_shiftRegOut
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (6143 DOWNTO 0);
			load		: IN STD_LOGIC ;
			q 			: OUT std_logic_vector (6143 DOWNTO 0);
			shiftout		: OUT STD_LOGIC;
			shiftin 	: IN STD_LOGIC
		);
	end component;
	component TurboInterleaver_shiftRegOutFlags
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (5087 DOWNTO 0);
			load		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			shiftout		: OUT STD_LOGIC 
		);
		
	end component;
	
	component byte_to_bit
		PORT
		(
			clock		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			shiftout		: OUT STD_LOGIC 
		);
	end component;
	
	signal bit_output: STD_LOGIC;
	signal byte_output: STD_LOGIC_VECTOR (7 DOWNTO 0); 
	
	---- FSM
	--signal clock_sig		:	std_logic;
	--signal reset_sig		:	std_logic;
	--signal in_looknow_sig	:	std_logic;
	--signal in_long_sig		:	std_logic;
	--signal debug_out_reset_sig		:	std_logic;
	--signal debug_out_enable_sig		:	std_logic;
	--signal debug_out_perform_sig	:	std_logic;
	--signal out_looknow_sig: 	std_logic;
	--signal out_long_sig	:	std_logic;
	--signal debug_out_q				:	std_logic_vector (12 downto 0);
	
	-- shiftRegIn
	signal aclr_shiftRegIn	:	std_logic;
	signal shiftin_shiftRegIn	:	std_logic;
	signal q_shiftRegIn	:	std_logic_vector(6143 DOWNTO 0) := (others => '0');
	-- shiftRegInFlag
	signal aclr_shiftRegInFlag	: std_logic;
	signal shiftin_shiftRegInFlag : std_logic;
	signal shiftout_shiftRegInFlag	: std_logic;
	-- shiftRegInLook
	signal aclr_shiftRegInLook	: std_logic;
	signal shiftin_shiftRegInLook : std_logic;
	signal shiftout_shiftRegInLook	: std_logic;

	-- interleaver
	signal flag_long_interleaver : std_logic;
	signal dataBufferIn : std_logic_vector(6143 DOWNTO 0) := (others => '0');
	signal dataBufferOut : std_logic_vector(6143 DOWNTO 0) := (others => '0');
	signal dataBufferOut2 : std_logic_vector(6143 DOWNTO 0) := (others => '0');

	-- shiftRegOut
	signal aclr_shiftRegOut	: std_logic;
	signal data_shiftRegOut	: std_logic_vector(6143 DOWNTO 0);
	signal load_shiftRegOut	: std_logic;
	signal shiftout_shiftRegOut	: std_logic;
	signal qOut_shiftRegOut 	: std_logic_vector(6143 DOWNTO 0);
	signal qIn_shiftRegOut		: std_logic;
	-- shiftRegOut2
	signal aclr_shiftRegOut2	: std_logic;
	signal data_shiftRegOut2	: std_logic_vector(6143 DOWNTO 0);
	signal load_shiftRegOut2	: std_logic;
	signal shiftout_shiftRegOut2	: std_logic;
	signal qOut_shiftRegOut2 	: std_logic_vector(6143 DOWNTO 0);
	signal qIn_shiftRegOut2		: std_logic;
	-- shiftRegOutFlag
	signal aclr_shiftRegOutFlag	: std_logic;
	signal data_shiftRegOutFlag	: std_logic_vector(5087 DOWNTO 0);
	signal load_shiftRegOutFlag	: std_logic;
	signal shiftin_shiftRegOutFlag : std_logic;
	signal shiftout_shiftRegOutFlag	: std_logic;
	-- shiftRegOutLook
	signal aclr_shiftRegOutLook	: std_logic;
	signal data_shiftRegOutLook	: std_logic_vector(5087 DOWNTO 0);
	signal load_shiftRegOutLook	: std_logic;
	signal shiftin_shiftRegOutLook : std_logic;
	signal shiftout_shiftRegOutLook	: std_logic;
	
begin

	variable counter_byte = '0';

	
	--statemachine_inst: TurboInterleaver_StateMachine PORT MAP (
	--		clock_sig => clk		,
	--		reset_sig => reset_sig		,
	--		in_looknow_sig => in_looknow_sig	,
	--		in_long_sig => in_long_sig		,
	--		debug_out_reset_sig => debug_out_reset_sig		,
	--		debug_out_enable_sig => debug_out_enable_sig		,
	--		debug_out_perform_sig => debug_out_perform_sig	,
	--		out_looknow_sig => out_looknow_sig	,
	--		out_long_sig => out_long_sig	,
	--		debug_out_q => debug_out_q	
	--	);
	
	bit_to_byte_inst: bit_to_byte PORT MAP(
		clock => clk,
		dataIn => shiftIn,
		q => byte_output,
		shift_out=> bit_output
	);

	shiftRegIn_inst: TurboInterleaver_shiftRegIn PORT MAP (
				clock => clk,
				aclr => aclr_shiftRegIn,
				shiftin => shiftin_shiftRegIn,
				q => q_shiftRegIn
		);
	shiftRegInFlag_inst: TurboInterleaver_shiftRegInFlags PORT MAP (
			aclr	 => aclr_shiftRegInFlag,
			clock	 => clk,
			shiftin	 => shiftin_shiftRegInFlag,
			shiftout	 => shiftout_shiftRegInFlag
		);
	shiftRegInLook_inst: TurboInterleaver_shiftRegInFlags PORT MAP (
			aclr	 => aclr_shiftRegInLook,
			clock	 => clk,
			shiftin	 => shiftin_shiftRegInLook,
			shiftout	 => shiftout_shiftRegInLook
		);


	interleaver_inst: TurboInterleaver_Interleaver PORT MAP (
			  clk    => clk,
			  reset_async    => reset_async,
			  flag_long => flag_long_interleaver,
			  dataBufferIn 	=> dataBufferIn,
			  dataBufferOut 	=> dataBufferOut
		);

	shiftRegOut_inst: TurboInterleaver_shiftRegOut PORT MAP (
				clock => clk,
				aclr => aclr_shiftRegOut,
				data => data_shiftRegOut,
				load => load_shiftRegOut,
				shiftout => shiftout_shiftRegOut,
				q 	=> qOut_shiftRegOut,
				shiftin => qIn_shiftRegOut
		);
	shiftRegOut2_inst: TurboInterleaver_shiftRegOut PORT MAP (
				clock => clk,
				aclr => aclr_shiftRegOut2,
				data => data_shiftRegOut2,
				load => load_shiftRegOut2,
				shiftout => shiftout_shiftRegOut2,
				q 	=> qOut_shiftRegOut2,
				shiftin => qIn_shiftRegOut2
		);
	shiftRegOutFlag_inst : TurboInterleaver_shiftRegOutFlags PORT MAP (
			aclr	 => aclr_shiftRegOutFlag,
			clock	 => clk,
			data	 => data_shiftRegOutFlag,
			load	 => load_shiftRegOutFlag,
			shiftin	 => shiftin_shiftRegOutFlag,
			shiftout	 => shiftout_shiftRegOutFlag
		);
	shiftRegOutLook_inst : TurboInterleaver_shiftRegOutFlags PORT MAP (
			aclr	 => aclr_shiftRegOutLook,
			clock	 => clk,
			data	 => data_shiftRegOutLook,
			load	 => load_shiftRegOutLook,
			shiftin	 => shiftin_shiftRegOutLook,
			shiftout	 => shiftout_shiftRegOutLook
		);

	--in_looknow_sig <= look_now_in;
	--in_long_sig <= flag_long_in;
	--look_now_out <= out_looknow_sig;
	--flag_long_out <= out_long_sig;

	shiftin_shiftRegInLook <= look_now_in;
	shiftin_shiftRegInFlag <= flag_long_in;

	qIn_shiftRegOut <= '0';
	qIn_shiftRegOut2 <= '0';

	shiftin_shiftRegIn <= bit_output;

	flag_long_interleaver <= shiftout_shiftRegInFlag;
	byte_process : process (clk, shiftout_shiftRegInLook, q_shiftRegIn)
	begin
		if (clk='1') then
			if (counter_byte>=8) then 
				dataInNext <= '1';
				counter_byte=0;
			else
				dataInNext <= '0';
				counter_byte = counter_byte+ 1;
			end if;
	end process;
	
	-- register input stream on look-now
	regIn : process (clk, shiftout_shiftRegInLook, q_shiftRegIn)
	begin
		if (clk='1') then
			if (shiftout_shiftRegInLook='1') then
				dataBufferIn(6143 DOWNTO 0) <= q_shiftRegIn(6143 DOWNTO 0);
				
			else
				dataBufferIn(6143 DOWNTO 0) <= dataBufferIn(6143 DOWNTO 0);
			end if;
		else
			dataBufferIn(6143 DOWNTO 0) <= dataBufferIn(6143 DOWNTO 0);
		end if;
	end process;
	dataBufferOut2(6143 DOWNTO 0) <= dataBufferIn(6143 DOWNTO 0);

	data_shiftRegOut(6143 DOWNTO 5088) <= dataBufferOut(6143 DOWNTO 5088) when (shiftout_shiftRegInFlag='1') else dataBufferOut(1055 DOWNTO 0);
	data_shiftRegOut2(6143 DOWNTO 5088) <= dataBufferOut2(6143 DOWNTO 5088) when (shiftout_shiftRegInFlag='1') else dataBufferOut2(1055 DOWNTO 0);
	data_shiftRegOut(5087 DOWNTO 0) <= dataBufferOut(5087 DOWNTO 0) when (shiftout_shiftRegInFlag='1') else qOut_shiftRegOut(5088 DOWNTO 1);
	data_shiftRegOut2(5087 DOWNTO 0 ) <= dataBufferOut2(5087 DOWNTO 0) when (shiftout_shiftRegInFlag='1') else qOut_shiftRegOut2(5088 DOWNTO 1);
	load_shiftRegOut <= shiftout_shiftRegInLook;
	load_shiftRegOut2 <= shiftout_shiftRegInLook;

	shiftin_shiftRegOutFlag <= '0';
	shiftin_shiftRegOutLook <= shiftout_shiftRegInLook when (shiftout_shiftRegInFlag='0') else '0';
	data_shiftRegOutFlag <= (0 => '1', others => '0');
	data_shiftRegOutLook <= (0 => '1', others => '0');
	load_shiftRegOutFlag <= '1' when ((shiftout_shiftRegInLook='1') and (shiftout_shiftRegInFlag='1')) else '0';
	load_shiftRegOutLook <= '1' when ((shiftout_shiftRegInLook='1') and (shiftout_shiftRegInFlag='1')) else '0';

	dataOut <= shiftout_shiftRegOut;
	dataOut2 <= shiftout_shiftRegOut2;
	flag_long_out <= shiftout_shiftRegOutFlag;
	look_now_out <= shiftout_shiftRegOutLook;

	--reset_sig <= reset_async;
	aclr_shiftRegIn <= reset_async;
	aclr_shiftRegInFlag <= reset_async;
	aclr_shiftRegInLook <= reset_async;
	aclr_shiftRegOut <= reset_async;
	aclr_shiftRegOut2 <= reset_async;
	aclr_shiftRegOutFlag <= reset_async;
	aclr_shiftRegOutLook <= reset_async;

end arch1;