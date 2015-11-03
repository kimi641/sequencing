#!/usr/bin/python
import sys
def main():
	fastaFile = open(sys.argv[1],'r')
	flagment = sys.argv[2]
	#init
	seqName = ""
	seqRead = ""
	bPos	= -1
	pArray	= []
	for line in fastaFile:
		line = line.strip("\n")
		if len(line) == 0:
			continue
		elif line[0] == ">":
			#process last read
			if len(seqName) != 0:
				bPos = seqRead.find(flagment)
			while bPos >= 0:
				pArray.append(bPos + 1)
				bPos = seqRead.find(flagment, bPos + 1)
			if len(pArray) != 0:
				print seqName
				for ele in pArray:
					print ele
			#init
			bPos	= -1
			seqName = line
			seqRead = ""
			pArray = []
		else:
			seqRead += line
	bPos= seqRead.find(flagment)
	while bPos >= 0:
		pArray.append(bPos + 1)
		bPos = seqRead.find(flagment, bPos + 1)
	if len(pArray) != 0:
		print seqName
		for ele in pArray:
			print ele
	fastaFile.close()

if __name__ == "__main__":
	main()
