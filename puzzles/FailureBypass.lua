function get_name()
	return "FAILURE BYPASS"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ A VALUE FROM IN.A AND WRITE THE VALUE TO OUT.A", "READ A VALUE FROM IN.B AND WRITE THE VALUE TO OUT.B" }
end

function get_streams()
	input = {}
	input2 = {}
	for i = 1,39 do
		input[i] = math.random(10, 99)
		input2[i] = math.random(10, 99)
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, input },
		{ STREAM_INPUT, "IN.B", 2, input2 },
		{ STREAM_OUTPUT, "OUT.A", 1, input },
		{ STREAM_OUTPUT, "OUT.B", 2, input2 }
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_MEMORY, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_DAMAGED, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
