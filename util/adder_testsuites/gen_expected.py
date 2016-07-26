from Queue import Queue
# generate expected inputs in Python
# read each line of input, write sorted output

# file names
infileName = "input.txt"
outfileName = "expected.txt"

# max number of outputs
maxCount = 47
count = 0

# read infile line-by-line, parsing and writing sorted output
with open(infileName, "r") as infile, open(outfileName, "w") as outfile:
        q = Queue()
        q.put(0)
        q.put(0)
	count = count + 1
	for line in iter(infile):
		#sortedLine = sorted(map(int, line.split()))
		# parse line into list of integers
		intLine = map(int, line.split())
		# compute: add
		added = intLine[0] + intLine[1]
                q.put(added)
		# output
                x = q.get()
                if(x<10):
		    outfile.write("%d %d ->  %d" % (intLine[0], intLine[1], x))
                else:
		    outfile.write("%d %d -> %d" % (intLine[0], intLine[1], x))
		outfile.write("\n")
		if count == maxCount:
			break
		count = count + 1
