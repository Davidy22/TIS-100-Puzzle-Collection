function get_name()
	return "UNIQUE ELEMENTS"
end

function get_description()
	return { "READ VALUES FROM IN.A",
			 "WRITE 1 THE FIRST TIME EACH NUMBER APPEARS",
			 "OTHERWISE WRITE 0" }
end

function get_streams()
	function unique(s)
		if L[s] == nil
		then L[s] = s
		  return 1
		else return 0
		end
		end
	L = {}
	input = {}
	output = {}
	for i = 1,39 do
		input[i] = math.random(1, 12)
		output[i] = unique(input[i])
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, input },
		{ STREAM_OUTPUT, "OUT.A", 1, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_MEMORY,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_MEMORY, 	TILE_DAMAGED,
	}
end
