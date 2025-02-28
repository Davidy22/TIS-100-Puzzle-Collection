function get_name()
	return "UNDECIMAL TWIN ROUNDER"
end

function get_description()
	return {
		"OUTPUT IN.MU ROUNDED TO NEAREST MULTIPLE OF IN.NU TO OUT.M",
		"OUTPUT IN.MU ROUNDED TO NEAREST MULTIPLE OF (11-IN.NU) TO OUT.N",
		"IN CASE OF A TIE, ROUND DOWN",
	}
end

function get_streams()
	inputA = {}
	inputB = {}
	outputA = {}
	outputB = {}
	for i = 1, 39 do
		inputA[i] = math.random(10, 99)
		inputB[i] = math.random(2, 9)
		outputB[i] = math.ceil(inputA[i] / inputB[i] - 0.5) * inputB[i]
		inputB[i] = 11 - inputB[i]
		outputA[i] = math.ceil(inputA[i] / inputB[i] - 0.5) * inputB[i]
	end
	return {
		{ STREAM_INPUT, "IN.MU", 1, inputA },
		{ STREAM_INPUT, "IN.NU", 2, inputB },
		{ STREAM_OUTPUT, "OUT.M", 1, outputA },
		{ STREAM_OUTPUT, "OUT.N", 2, outputB },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
