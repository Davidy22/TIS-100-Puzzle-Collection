function get_name()
	return "GAMMA DECODER"
end

function get_description()
	return { "READ VALUE FROM IN", "SQUARE VALUE AND DIVIDE BY 100", "ROUND TO NEAREST INTEGER", "WRITE RESULT TO OUT" }
end

function get_streams()
	input = {}
	output = {}
	for i = 1, 39 do
		input[i] = math.random(0, 100)
	end

	-- ensure we have at least one 0 and 100
	j = math.random(1, 39)
	repeat
		k = math.random(1, 39)
	until k ~= j

	input[j] = 0
	input[k] = 100

	for i = 1, 39 do
		output[i] = math.floor(input[i] ^ 2 / 100 + 0.5)
	end

	return {
		{ STREAM_INPUT, "IN.A", 2, input },
		{ STREAM_OUTPUT, "OUT.A", 2, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
