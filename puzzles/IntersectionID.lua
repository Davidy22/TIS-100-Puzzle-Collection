function get_name()
	return "INTERSECTION IDENTIFIER"
end

function get_description()
	return {
		"IDENTIFY WHICH NUMBERS ARE PRESENT IN ALL THREE SEQUENCES",
		"OUTPUT THOSE NUMBERS IN THE ORDER THEY APPEAR IN EACH SEQUENCE",
		"SEQUENCES ARE ZERO TERMINATED",
	}
end

function get_streams()
	-- Start with the desired output order - controlled values will appear in the same order in all 3
	local outLength = math.random(3, 7)
	outOrder = {
		{},
		{},
		{},
	}
	for i = 1, outLength do
		outOrder[1][i] = i
		outOrder[2][i] = i
		outOrder[3][i] = i
	end

	-- Add one falsie for each pair of sequences - it's a little messy I guess
	local falsie12 = math.random(1, outLength + 1)
	table.insert(outOrder[1], falsie12, outLength + 1)
	table.insert(outOrder[2], falsie12, outLength + 1)

	local falsie23 = math.random(1, outLength + 1)
	if falsie23 > falsie12 then
		table.insert(outOrder[2], falsie23 + 1, outLength + 2)
	else
		table.insert(outOrder[2], falsie23, outLength + 2)
	end
	table.insert(outOrder[3], falsie23, outLength + 2)

	local falsie13 = math.random(1, outLength + 1)
	if falsie13 > falsie12 then
		table.insert(outOrder[1], falsie13 + 1, outLength + 3)
	else
		table.insert(outOrder[1], falsie13, outLength + 3)
	end
	if falsie13 > falsie23 then
		table.insert(outOrder[3], falsie13 + 1, outLength + 3)
	else
		table.insert(outOrder[3], falsie13, outLength + 3)
	end
	shuffle(outOrder)

	-- There are outLength + 2 controlled values per seqeunce, and the rest unconrolled.  Pick the indices.
	setup = {
		{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
	}
	outTables = {
		{},
		{},
		{},
	}
	for i = 1, 3 do
		for j = 1, (outLength + 2) do
			index = math.random(1, #setup[i])
			outTables[i][j] = setup[i][index]
			table.remove(setup[i], index)
		end
		table.sort(outTables[i])
	end

	input = {}
	output = {}

	-- The values used in this puzzle.  First 10 (post-shuffle) are reserved for output and falsies.
	numSet = {}
	numSet[1] = math.random(1, 2)
	for i = 2, 50 do
		numSet[i] = numSet[i - 1] + math.random(1, 2)
	end
	shuffle(numSet)

	-- Create output
	for i = 1, outLength do
		output[i] = numSet[i]
	end

	-- Create input
	for i = 0, 2 do
		local m = 1 -- m tracks progress through controlled values

		for j = 1, 12 do
			if j == outTables[i + 1][m] then
				input[13 * i + j] = numSet[outOrder[i + 1][m]]
				m = m + 1
			else
				input[13 * i + j] = numSet[10 + 7 * i + j] --use of 7 here emulates the prior decision to allow start-end overlap
			end
		end
		input[13 * i + 13] = 0
	end

	return {
		{ STREAM_INPUT, "IN.F", 3, input },
		{ STREAM_OUTPUT, "OUT.G", 1, output },
	}
end

function shuffle(tbl)
	local size = #tbl
	for i = size, 1, -1 do
		local rand = math.random(1, size)
		tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
	return tbl
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_MEMORY, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_MEMORY, 	TILE_COMPUTE,
	}
end
