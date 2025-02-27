function get_name()
	return "9,5 LFSR"
end

function get_creator()
	return "ApertureScience42"
end

function get_description() -- I don't know how to better explain a Linear Feedback Shift Register in the space available
	return { "READ A 9 BIT SEED NUMBER FROM IN", 
			"OUTPUT HIGH BIT XOR MIDDLE BIT",
			"SHIFT BITS LEFT AND THE OUTPUT",
			"   1  1  0  1  0  1  1  0  1", -- This bit pattern matches the first run value 429
			"  /  /  /  /  /  /  /  /  /",
			"X< 1< 0< 1< 0< 1< 1< 0< 1< 1"}
end

function get_streams()
	input = {}
	output = {}
	seed = math.random(1,511)
	if seed == 233 then seed = 429 end -- 429 first run long runs of 0s and 1s and alternating 0s and 1s should trigger most edge cases
	input[1] = seed
	x = input[1]
	
	
	for i = 1,39 do
		if ( math.floor(x/256) ~= 0 or math.floor((x%32)/16) ~= 0 ) and not ( math.floor(x/256) ~= 0 and math.floor((x%32)/16) ~= 0 ) then
			x = (x%256)*2 + 1
			output[i] = 1
		else
			x = (x%256)*2
			output[i] = 0
		end
	end
		
	
	return {
		{ STREAM_INPUT, "IN.A", 1, input },
		{ STREAM_OUTPUT, "OUT.A", 2, output },
	}
end

function get_layout()
	return { 
		TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
