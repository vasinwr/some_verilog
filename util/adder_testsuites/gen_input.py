# python script to generate inputs

# bitwidth of data. MUST match hardware!
data_width = 3

# print inputs to stdout
for i in range(0, 2**data_width):
	for j in range(0, 2**data_width):
		print i, "   ", j

