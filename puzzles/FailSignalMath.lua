function get_name()
	return "FAILED SIGNAL ARITHMETIC"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ VALUES FROM IN.A AND IN.B", "COMPUTE THE SUM AND PRODUCT OF THE TWO NUMBERS", "WRITE THE SUB TO OUT.S", "WRITE THE PRODUCT TO OUT.P" }
end

function get_streams()
	input = {}
	input2 = {}
	outputs = {}
	outputp = {}
	for i = 1,39 do
		input[i] = math.random(0, 32)
		input2[i] = math.random(0, 31)
		outputs[i] = input[i] + input2[i]
		outputp[i] = input[i] * input2[i]
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, input },
		{ STREAM_INPUT, "IN.B", 2, input2 },
		{ STREAM_OUTPUT, "OUT.S", 0, outputs },
		{ STREAM_OUTPUT, "OUT.P", 2, outputp }
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_MEMORY, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_DAMAGED, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
