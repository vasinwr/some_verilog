#!/usr/bin/env python
# generate expected inputs in Python
# read each line of input, write sorted output

# file names

infileName = "input.txt"
outfileName = "expected.txt"

# max number of outputs
maxCount = 11
count = 0

# read infile line-by-line, parsing and writing sorted output
with open(infileName, "r") as infile, open(outfileName, "w") as outfile:
	count = count + 1
	for line in iter(infile):
		#sortedLine = sorted(map(int, line.split()))
		# parse line into list of integers
		intLine = map(int, line.split())
		# compute: sort
		intLine.sort()
		# output
		outfile.write("%d %d %d %d " % (intLine[0], intLine[1], intLine[2], intLine[3]))
		outfile.write("\n")
		if count == maxCount:
			break
		count = count + 1
