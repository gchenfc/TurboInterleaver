bytes_to_bits_inst : bytes_to_bits PORT MAP (
		clock	 => clock_sig,
		data	 => data_sig,
		load	 => load_sig,
		shiftout	 => shiftout_sig
	);
