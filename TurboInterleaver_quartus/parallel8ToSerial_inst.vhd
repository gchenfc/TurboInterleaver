parallel8ToSerial_inst : parallel8ToSerial PORT MAP (
		aclr	 => aclr_sig,
		clock	 => clock_sig,
		data	 => data_sig,
		load	 => load_sig,
		shiftout	 => shiftout_sig
	);
