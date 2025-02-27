-- This problem can be either merely difficult or downright mean depending on the length of the input.

-- Length of input reduced to make the puzzle easier. 
-- reduce input length to 32 if you want to eliminate remainder saturation
-- or increase to 39 if you want to force handling of remainder overflow

function get_name()
	return "SIGNAL MEAN"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ A VALUE FROM IN", "CALCULATE THE MEAN OF ALL VALUES READ SO FAR", "WRITE THE MEAN TO OUT" }
end

function get_streams()
	input = {}
	output = {}
	t = 0
	for i = 1,32 do
		x = math.random(1, 999)
		t = t + x
		input[i] = x
		output[i] = math.floor(t / i)
	end
	return {
		{ STREAM_INPUT, "IN", 0, input },
		{ STREAM_OUTPUT, "OUT", 1, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
