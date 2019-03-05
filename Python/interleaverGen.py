skeleton_begin = """
library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_Interleaver is
	port (
		clk, reset_async:			in std_logic;
		flag_long:					in std_logic;

		dataBufferIn:			in std_logic_vector(6143 DOWNTO 0);
		dataBufferOut:			out std_logic_vector(6143 DOWNTO 0)
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
	longIndsCheck = [0 for x in range(6144)];
	shortIndsCheck = [0 for x in range(6144)];
	f = open("TurboInterleaver_Interleaver.vhd", "w")
	f.write(skeleton_begin)
	for i in range(6144-1056):
		toWrite = "\tdataBufferOut({0:4}) <= dataBufferIn({1:4}) when (flag_long='1') else '0';\n".format(
			i,
			interleaverIndexF(6144,i))
		longIndsCheck[interleaverIndexF(6144,i)] = 1;
		f.write(toWrite)
	for i in range (6144-1056 , 6144):
		toWrite = "\tdataBufferOut({0:4}) <= dataBufferIn({1:4}) when (flag_long='1') else dataBufferIn({2:4});\n".format(
			i,
			interleaverIndexF(6144,i),
			interleaverIndexF(1056,i-(6144-1056))+(6144-1056))
		longIndsCheck[interleaverIndexF(6144,i)] = 1;
		shortIndsCheck[interleaverIndexF(1056,i-(6144-1056))+(6144-1056)] = 1;
		f.write(toWrite)
	f.write(skeleton_end)

	print(sum(longIndsCheck))
	print(sum(shortIndsCheck[6144-1056:6144]))
	print(max(longIndsCheck))
	print(max(shortIndsCheck))

if __name__ == '__main__':
	main()