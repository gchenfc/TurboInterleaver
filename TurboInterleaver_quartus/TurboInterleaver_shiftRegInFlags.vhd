-- megafunction wizard: %LPM_SHIFTREG%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_SHIFTREG 

-- ============================================================
-- File Name: TurboInterleaver_shiftRegInFlags.vhd
-- Megafunction Name(s):
-- 			LPM_SHIFTREG
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 16.1.0 Build 196 10/24/2016 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2016  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel MegaCore Function License Agreement, or other 
--applicable license agreement, including, without limitation, 
--that your use is for the sole purpose of programming logic 
--devices manufactured by Intel and sold by Intel or its 
--authorized distributors.  Please refer to the applicable 
--agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY TurboInterleaver_shiftRegInFlags IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC ;
		shiftout		: OUT STD_LOGIC 
	);
END TurboInterleaver_shiftRegInFlags;


ARCHITECTURE SYN OF turbointerleaver_shiftreginflags IS

	SIGNAL sub_wire0	: STD_LOGIC ;



	COMPONENT lpm_shiftreg
	GENERIC (
		lpm_direction		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			shiftin	: IN STD_LOGIC ;
			shiftout	: OUT STD_LOGIC 
	);
	END COMPONENT;

BEGIN
	shiftout    <= sub_wire0;

	LPM_SHIFTREG_component : LPM_SHIFTREG
	GENERIC MAP (
		lpm_direction => "RIGHT",
		lpm_type => "LPM_SHIFTREG",
		lpm_width => 6144
	)
	PORT MAP (
		aclr => aclr,
		clock => clock,
		shiftin => shiftin,
		shiftout => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ACLR NUMERIC "1"
-- Retrieval info: PRIVATE: ALOAD NUMERIC "0"
-- Retrieval info: PRIVATE: ASET NUMERIC "0"
-- Retrieval info: PRIVATE: ASET_ALL1 NUMERIC "1"
-- Retrieval info: PRIVATE: CLK_EN NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
-- Retrieval info: PRIVATE: LeftShift NUMERIC "0"
-- Retrieval info: PRIVATE: ParallelDataInput NUMERIC "0"
-- Retrieval info: PRIVATE: Q_OUT NUMERIC "0"
-- Retrieval info: PRIVATE: SCLR NUMERIC "0"
-- Retrieval info: PRIVATE: SLOAD NUMERIC "0"
-- Retrieval info: PRIVATE: SSET NUMERIC "0"
-- Retrieval info: PRIVATE: SSET_ALL1 NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SerialShiftInput NUMERIC "1"
-- Retrieval info: PRIVATE: SerialShiftOutput NUMERIC "1"
-- Retrieval info: PRIVATE: nBit NUMERIC "6144"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_DIRECTION STRING "RIGHT"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_SHIFTREG"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "6144"
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL "aclr"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
-- Retrieval info: USED_PORT: shiftin 0 0 0 0 INPUT NODEFVAL "shiftin"
-- Retrieval info: USED_PORT: shiftout 0 0 0 0 OUTPUT NODEFVAL "shiftout"
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @shiftin 0 0 0 0 shiftin 0 0 0 0
-- Retrieval info: CONNECT: shiftout 0 0 0 0 @shiftout 0 0 0 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL TurboInterleaver_shiftRegInFlags.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL TurboInterleaver_shiftRegInFlags.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL TurboInterleaver_shiftRegInFlags.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL TurboInterleaver_shiftRegInFlags.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL TurboInterleaver_shiftRegInFlags_inst.vhd TRUE
-- Retrieval info: LIB_FILE: lpm
