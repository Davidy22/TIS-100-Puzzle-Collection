function get_name()
	return "VERTICAL LINES"
end

function get_description()
	return { "READ A COLOR FROM IN", "DRAW A VERTICAL LINE IN THAT COLOR" }
end

function get_streams()
	input = {}
	output = {}
	for i = 1, 30 do
		input[i] = math.random(0, 4)
		for j = 0, 17 do
			output[i + 30 * j] = input[i]
		end
	end
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_IMAGE, "OUT.A", 2, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
