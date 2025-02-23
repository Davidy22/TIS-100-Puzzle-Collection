-- ApertureScience42

function get_name()
	return "COLOUR ENCODER DECODER"
end


function get_description()
	return { "READ 4 QUINTAL DIGITS FROM IN.P", "ENCODE THEM INTO A SINGLE VALUE, THE FIRST BEING THE HIGH DIGIT", "WRITE THE VALUE TO OUT.E", "READ AN ENCODED VALUE FROM IN.E", "WRITE QUINTAL DIGITS TO OUT.P" }
end


function get_streams()
	inputP = {}
	inputE = {}
	outputP = {}
	outputE = {}
	for i = 1,36 do
		inputP[i] = math.random(1, 4)
		outputP[i] = math.random(1, 4)
	end
	outputP[1] = 4
	outputP[2] = 4
	outputP[3] = 4
	outputP[4] = 4
	
	for i = 1,9 do
		inputE[i] = 0
		outputE[i] = 0
		for j = 0,3 do -- High digit first
			inputE[i] = inputE[i] + math.pow(5,3-j) * outputP[4*(i-1) + j + 1]
			outputE[i] = outputE[i] + math.pow(5,3-j) * inputP[4*(i-1) + j + 1]
		end
		-- for j = 0,3 do -- Low digit first
			-- inputE[i] = inputE[i] + math.pow(5,j) * outputP[4*(i-1) + j + 1]
			-- outputE[i] = outputE[i] + math.pow(5,j) * inputP[4*(i-1) + j + 1]
		-- end
	end
		
	return {
		{ STREAM_INPUT, "IN.P", 1, inputP },
		{ STREAM_INPUT, "IN.E", 2, inputE },
		{ STREAM_OUTPUT, "OUT.P", 2, outputP },
		{ STREAM_OUTPUT, "OUT.E", 1, outputE },
	}
end

-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end