LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity FSM is
	port(
		clock_sig		:	in std_logic;
		reset_sig		:	in std_logic;
		in_looknow_sig	:	in std_logic;
		in_long_sig		:	in std_logic;
		out_reset_sig		:	out std_logic;
		out_enable_sig		:	out std_logic;
		out_perform_sig	:	out std_logic;
		out_looknow_sig: 	out std_logic;
		out_long_sig	:	out std_logic;
		out_q				:	out std_logic_vector (12 downto 0));
end FSM;

architecture controller of FSM is
	type state_type is
		(s0, s1, s2, s3, s4, s5, s6);
	signal state_reg, state_next	:	state_type;
	signal c_reset_sig, c_enable_sig: std_ulogic := '0';
	signal flag_count_long, flag_count_short: std_ulogic := '0';
	signal c_out_sig	:	std_logic_vector(12 downto 0);
	
	component counter PORT (
		aclr		: IN STD_LOGIC ;
		clk_en		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
	);
	end component;
begin	
	counter_inst	:	counter PORT MAP (
		aclr		=>	c_reset_sig,
		clk_en	=>	c_enable_sig,
		clock		=>	clock_sig,
		q			=>	c_out_sig
	);

	process(clock_sig, reset_sig)
	begin
		if(reset_sig = '1') then
			state_reg <= s0;
		elsif(clock_sig'event and clock_sig = '1') then
			state_reg <= state_next;
		end if;
	end process;
	
	process(state_reg, in_looknow_sig, in_long_sig, flag_count_long, flag_count_short)
	begin
		case state_reg is
			when s0 =>
				if(in_looknow_sig = '1' and in_long_sig = '1') then
					state_next <= s1;
				elsif(in_looknow_sig = '1' and in_long_sig = '0') then
					state_next <= s2;
				else
					state_next <= s0;
				end if;
			when s1 =>
				state_next <= s3;
			when s2 =>
				state_next <= s4;
			when s3 =>
				if(flag_count_long = '1') then
					state_next <= s5;
				else
					state_next <= s3;
				end if;
--				state_next <= s5;
			when s4 =>
				if(flag_count_short = '1') then
					state_next <= s6;
				else
					state_next <= s4;
				end if;
--				state_next <= s6;
			when s5 =>
				if(in_looknow_sig = '1' and in_long_sig = '1') then
					state_next <= s1;
				elsif(in_looknow_sig = '1' and in_long_sig = '0') then
					state_next <= s2;
				else
					state_next <= s0;
				end if;
			when s6 =>
				if(in_looknow_sig = '1' and in_long_sig = '1') then
					state_next <= s1;
				elsif(in_looknow_sig = '1' and in_long_sig = '0') then
					state_next <= s2;
				else
					state_next <= s0;
				end if;
		end case;
	end process;
	
	process(c_out_sig)
	begin
		if(c_out_sig(12 downto 0) = "1011111111110") then -- 6142
--		if(c_out_sig(9 downto 0) = "0000000100") then
			flag_count_long <= '1';
		elsif(c_out_sig(12 downto 0) = "0010000011110") then -- 1054
--		elsif(c_out_sig(9 downto 0) = "0000000010") then
			flag_count_short <= '1';
		else
			flag_count_long <= '0';
			flag_count_short <= '0';
		end if;
	end process;
	
	process(state_reg)
	begin
		case state_reg is
			when s0 =>
				out_looknow_sig <= '0';
				out_long_sig <= '0';
				out_perform_sig <= '0';
				c_reset_sig <= '1';
				c_enable_sig <= '1';
			when s1 =>
				out_looknow_sig <= '0';
				out_long_sig <= '0';
				out_perform_sig <= '0';
				c_reset_sig <= '0';
				c_enable_sig <= '1';
			when s2 =>
				out_looknow_sig <= '0';
				out_long_sig <= '0';
				out_perform_sig <= '0';
				c_reset_sig <= '0';
				c_enable_sig <= '1';
			when s3 =>
				out_looknow_sig <= '0';
				out_long_sig <= '0';
				out_perform_sig <= '0';
				c_reset_sig <= '0';
				c_enable_sig <= '1';
			when s4 =>
				out_looknow_sig <= '0';
				out_long_sig <= '0';
				out_perform_sig <= '0';
				c_reset_sig <= '0';
				c_enable_sig <= '1';
			when s5 =>
				out_looknow_sig <= '1';
				out_long_sig <= '1';
				out_perform_sig <= '1';
				c_reset_sig <= '1';
				c_enable_sig <= '1';
			when s6 =>
				out_looknow_sig <= '1';
				out_long_sig <= '0';
				out_perform_sig <= '1';
				c_reset_sig <= '1';
				c_enable_sig <= '1';
		end case;
	end process;
	
--	process(c_reset_sig, c_enable_sig)
--	begin
	out_reset_sig <= c_reset_sig;
	out_enable_sig <= c_enable_sig;
	out_q <= c_out_sig;
--	end process;

end controller;