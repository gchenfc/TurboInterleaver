TurboInterleaver_shiftRegOutFlags_inst : TurboInterleaver_shiftRegOutFlags PORT MAP (
		aclr	 => aclr_sig,
		clock	 => clock_sig,
		data	 => data_sig,
		load	 => load_sig,
		shiftin	 => shiftin_sig,
		shiftout	 => shiftout_sig
	);
