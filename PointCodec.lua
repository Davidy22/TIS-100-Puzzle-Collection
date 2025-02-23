-- ApertureScience42

function get_name()
	return "POINT ENCODER DECODER"
end


function get_description()
	return { "READ AN X AN Y VALUE FROM IN IN.P", "OUTPUT 30 * Y + X TO OUT.E", "READ AN ENCODED NUMBER FROM IN.E", "X = IN.E % 30", "Y = (IN.E - X) / 30", "OUTPUT X AND Y TO OUT.P" }
end

-- STREAM_IMAGE: An image output stream, containing exactly 30*18 numerical values between 0
--               and 4, representing the full set of "pixels" for the target image.
function get_streams()
	inputp = {}
	inpute = {}
	outpute = {}
	outputp = {}
	for i = 1,19 do
		inpute[i] = math.random(0, 539)
		outputp[i*2 - 1] = inpute[i] % 30
		outputp[i*2] = math.floor(inpute[i] / 30)
		outpute[i] = math.random(0, 539)
		inputp[i*2 - 1] = outpute[i] % 30
		inputp[i*2] = math.floor(outpute[i] / 30)
	end

	return {
		{ STREAM_INPUT, "IN.P", 0, inputp },
		{ STREAM_INPUT, "IN.E", 2, inpute },
		{ STREAM_OUTPUT, "OUT.E", 1, outpute },
		{ STREAM_OUTPUT, "OUT.P", 3, outputp },
	}
end

-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end