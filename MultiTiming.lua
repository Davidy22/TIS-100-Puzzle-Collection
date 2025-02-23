-- ApertureScience42

-- The output stream is the first 4 points in ENCODED STAR MAPPER

function get_name()
	return "MULTI TIMING"
end


function get_description()
	return { "READ A STREAM FROM IN.A", "WRITE THE LENGTH TO OUT", "WRITE THE TOTAL TO OUT", "DO THE SAME FOR IN.B IN.C AND IN.D" }
end


function get_streams()
	-- inputA = {}
	-- inputB = {}
	-- inputC = {}
	-- inputD = {}
	input = {}
	output = {}
	op = 1 
	
	for j = 1,4 do
		input[j] = {}
		e = math.random(3, 9)
		output[op] = e
		op = op + 1
		t = 0
		for i = 1,e do
			input[j][i] = math.random(10, 99)
			t = t + input[j][i]
		end
		output[op] = t
		op = op + 1
	end
	if output[2] == 266 and output[4] == 239 then -- first run outputs inputs to Star mapper
		input[1] = {17,25,54,12}
		input[2] = {165,138,106}
		input[3] = {94,109}
		input[4] = {298,45}
		output = {4,108,3,409,2,203,2,343}
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, input[1] },
		{ STREAM_INPUT, "IN.B", 1, input[2] },
		{ STREAM_INPUT, "IN.C", 2, input[3] },
		{ STREAM_INPUT, "IN.D", 3, input[4] },
		{ STREAM_OUTPUT, "OUT.A", 2, output },
	}
end

-- The function get_layout() should return an array of exactly 12 TILE_* values, which
-- describe the layout and type of tiles found in the puzzle.
--
-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
	}
end