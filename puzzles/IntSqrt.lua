function get_name()
	return "INTEGER SQUARE ROOT"
end

function get_description()
	return { "READ A VALUE FROM IN.N", "CALCULATE SQUARE ROOT ROUNDED DOWN", "WRITE TO OUT.ISQRT" }
end

function get_streams()
	input = {}
	output = {}
	for i = 1,39 do
		input[i] = math.random(0, 999)
		output[i] = math.floor(math.sqrt(input[i]))
	end
	return {
		{ STREAM_INPUT, "IN.N", 1, input },
		{ STREAM_OUTPUT, "OUT.ISQRT", 1, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
