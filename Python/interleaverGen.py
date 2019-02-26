skeleton_begin = """
library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_Interleaver is
	port (
		clk, reset_async:			in std_logic;

		dataBufferIn_short:			in std_logic_vector(1055 DOWNTO 0);
		dataBufferIn_long:			in std_logic_vector(6143 DOWNTO 0);
		dataBufferOut_short:		out std_logic_vector(1055 DOWNTO 0);
		dataBufferOut_long:			out std_logic_vector(6143 DOWNTO 0)
	);
end TurboInterleaver_Interleaver;

architecture arch1 of TurboInterleaver_Interleaver is

begin

"""
skeleton_end = """

end arch1;
"""

def interleaverIndexF(K,i):
	if K==6144:
		f1 = 263
		f2 = 480
	elif K==1056:
		f1 = 17
		f2 = 66
	else:
		raise ValueError('K value not supported.')
	if ((i>=K) or (i<0)):
		raise ValueError('index i should be positive and less than K')
	return (f1*i+f2*i) % K

def main():
	f = open("TurboInterleaver_Interleaver.vhd", "w")
	f.write(skeleton_begin)
	for K in [1056,6144]:
		for i in range(K):
			toWrite = '\tdataBufferOut_{lflag}({0:4}) <= dataBufferIn_{lflag}({1:4});\n'.format(
				interleaverIndexF(K,i),
				i,
				lflag = "short" if K==1056 else "long")
			f.write(toWrite)
	f.write(skeleton_end)

if __name__ == '__main__':
	main()