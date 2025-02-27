function get_name()
	return "BINARY OPERATIONS"
end

function get_creator()
	return "zarawesome"
end

function get_description()
	return { "READ A VALUE FROM IN.A", "READ A VALUE FROM IN.B", "OUT.AND = IN.A & IN.B", "OUT.OR = IN.A | IN.B"}
end

function get_streams()
	inputA = {}
	inputB = {}
	outputA = {}
	outputB = {}
	for i = 1,39 do
		inputA[i] = math.random(1, 255)
		inputB[i] = math.random(1, 255)
		outputA[i] = bit32.band(inputA[i], inputB[i])
		outputB[i] = bit32.bor(inputA[i], inputB[i])
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, inputA },
		{ STREAM_INPUT, "IN.B", 2, inputB },
		{ STREAM_OUTPUT, "OUT.AND", 1, outputA },
		{ STREAM_OUTPUT, "OUT.OR", 2, outputB },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_MEMORY,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_MEMORY, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
