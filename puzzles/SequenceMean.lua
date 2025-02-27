function get_name()
	return "SEQUENCE MEAN"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ SEQUENCE FROM IN", "WRITE THE MEAN TO OUT" }
end

function get_streams()
	input = {}
	output = {}
	
	for i = 1,38 do
	    input[i] = math.random(1, 999)
	end
	input[39] = 0
	
	
	for i = 0,8 do 
		x = 4 * i + math.random(1,4)
		input[x] = 0
		if i == 5 then input[x + 1] = 0 end -- guarantee empty sequence 
	end
	
	op = 1 -- output pointer
	tot = 0
	count = 0
	for i = 1,39 do
		if input[i] == 0 then
			if count == 0 then -- handle empty sequence
				output[op] = 0
			else
				output[op] = math.floor(tot/count)
			end
			op = op + 1
			tot = 0
			count = 0
		else
			tot = tot + input[i]
			count = count + 1
		end
	end
	
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_OUTPUT, "OUT", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_MEMORY,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
