byte_to_bit_inst : byte_to_bit PORT MAP (
		clock	 => clock_sig,
		shiftin	 => shiftin_sig,
		q	 => q_sig,
		shiftout	 => shiftout_sig
	);
