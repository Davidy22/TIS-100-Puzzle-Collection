-- ApertureScience42

function get_name()
	return "SIGNAL END DETECTOR"
end


function get_description()
	return { "COUNT THE INPUTS FROM IN", "OUTPUT THE COUNT TO OUT.C", "THERE IS NO TERMINATION DIGIT" }
end


function get_streams()
	input = {}
	output = {}
	leng = math.random(3, 38)
	
	for i = 1,leng do
		input[i] = math.random(10, 99)
	end
	
	-- Prevent second run with same answer
	if leng == 10 and (input[1] ~= 88 or input[2] ~= 28) then 
		leng = leng + 1
		input[leng] = math.random(10, 99)
	end
	
	output[1] = leng
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_OUTPUT, "OUT.C", 2, output },
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
