library ieee;
use ieee.std_logic_1164.all;
   use IEEE.numeric_std.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataIn:				in std_logic_vector(7 DOWNTO 0);
		dataInNext: 		out std_logic := '0';
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

	component bytes_to_bits
		PORT
		(
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			load		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			shiftout		: OUT STD_LOGIC 
		);
	end component;
	
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
	component delay1
		PORT
		(
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

	-- byte to bit serial
	signal load_dataIn: 	std_logic;
	signal byte_dataIn:		std_logic_vector(7 DOWNTO 0);
	signal bit_dataIn: 		STD_LOGIC;
	signal byte_flagIn:		std_logic_vector(7 DOWNTO 0) := "00000000";
	signal bit_flagIn:		std_logic;
	signal byte_lookIn:		std_logic_vector(7 DOWNTO 0) := "00000000";
	signal bit_lookIn:		std_logic;

	-- shiftRegIn
	signal aclr_shiftRegIn	:	std_logic;
	signal shiftin_shiftRegIn	:	std_logic;
	signal q_shiftRegIn	:	std_logic_vector(6143 DOWNTO 0) := (others => '0');
	-- shiftRegInFlag
	signal aclr_shiftRegInFlag	: std_logic;
	signal shiftin_shiftRegInFlag : std_logic := '0';
	signal shiftout_shiftRegInFlag	: std_logic;
	-- shiftRegInLook
	signal aclr_shiftRegInLook	: std_logic;
	signal shiftin_shiftRegInLook : std_logic := '0';
	signal shiftout_shiftRegInLook	: std_logic;

	-- interleaver
	signal flag_long_interleaver : std_logic;
	signal dataBufferIn_interleaver : std_logic_vector(6143 DOWNTO 0) := (others => '0');
	signal dataBufferOut_interleaver : std_logic_vector(6143 DOWNTO 0) := (others => '0');
	signal dataBufferOut2_interleaver : std_logic_vector(6143 DOWNTO 0) := (others => '0');

	-- transfer computation
	signal lookNow_prev_shiftRegOutLook	: std_logic := '0';

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
	
	signal counter_byte: UNSIGNED(7 DOWNTO 0) := "00000110";
	
begin



	
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
	
	bytes_to_bits_inst : bytes_to_bits PORT MAP (
			clock	 => clk,
			data	 => byte_dataIn,
			load	 => load_dataIn,
			shiftin  	=> '1',
			shiftout	 => bit_dataIn
		);
	bytes_to_bits_Look_inst : bytes_to_bits PORT MAP (
			clock	 => clk,
			data	 => byte_lookIn,
			load	 => load_dataIn,
			shiftin  	=> '0',
			shiftout	 => bit_lookIn
		);
	bytes_to_bits_Flag_inst : bytes_to_bits PORT MAP (
			clock	 => clk,
			data	 => byte_flagIn,
			load	 => load_dataIn,
			shiftin  	=> '0',
			shiftout	 => bit_flagIn
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
			dataBufferIn 	=> dataBufferIn_interleaver,
			dataBufferOut => dataBufferOut_interleaver
		);

	lookNowDelay1_inst : delay1 PORT MAP (
			clock	 => clk,
			shiftin	 => shiftout_shiftRegInLook,
			shiftout	 => lookNow_prev_shiftRegOutLook
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

	-- counter for byte to bit module
	byte_process : process (clk, counter_byte)
	begin
		if (clk'event and clk='1') then
			if (counter_byte ="00000110") then 
				if (look_now_in='1') then
					dataInNext <= '1';
					load_dataIn <= '0';
					counter_byte <= counter_byte + "00000001";
				end if;
			elsif (counter_byte="00000111") then
				dataInNext <= '0';
				load_dataIn <= '1';
				counter_byte <= "00000000";
			else
				dataInNext <= '0';
				load_dataIn <= '0';
				counter_byte <= counter_byte + "00000001";
			end if;
		end if;
	end process;
	byte_dataIn <= dataIn;
	byte_lookIn <= (others => look_now_in);
	byte_flagIn <= (others => flag_long_in);

	shiftin_shiftRegIn <= bit_dataIn;
	shiftin_shiftRegInLook <= bit_lookIn;
	shiftin_shiftRegInFlag <= bit_flagIn;

	flag_long_interleaver <= shiftout_shiftRegInFlag;
	
	-- register input stream on look-now
	dataBufferIn_interleaver(6143 DOWNTO 0) <= q_shiftRegIn(6143 DOWNTO 0);
	dataBufferOut2_interleaver(6143 DOWNTO 0) <= dataBufferIn_interleaver(6143 DOWNTO 0);

	qIn_shiftRegOut <= '0';
	qIn_shiftRegOut2 <= '0';
	data_shiftRegOut(6143 DOWNTO 5088) <= dataBufferOut_interleaver(6143 DOWNTO 5088) when (shiftout_shiftRegInFlag='1') else dataBufferOut_interleaver(1055 DOWNTO 0);
	data_shiftRegOut2(6143 DOWNTO 5088) <= dataBufferOut2_interleaver(6143 DOWNTO 5088) when (shiftout_shiftRegInFlag='1') else dataBufferOut2_interleaver(1055 DOWNTO 0);
	data_shiftRegOut(5087 DOWNTO 0) <= dataBufferOut_interleaver(5087 DOWNTO 0) when (shiftout_shiftRegInFlag='1') else qOut_shiftRegOut(5088 DOWNTO 1);
	data_shiftRegOut2(5087 DOWNTO 0 ) <= dataBufferOut2_interleaver(5087 DOWNTO 0) when (shiftout_shiftRegInFlag='1') else qOut_shiftRegOut2(5088 DOWNTO 1);
	load_shiftRegOut 	<= '1' when (lookNow_prev_shiftRegOutLook='0' and shiftout_shiftRegInLook='1') else '0';
	load_shiftRegOut2 	<= '1' when (lookNow_prev_shiftRegOutLook='0' and shiftout_shiftRegInLook='1') else '0';

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