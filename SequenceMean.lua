-- ApertureScience42

function get_name()
	return "SEQUENCE MEAN"
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

-- The function get_layout() should return an array of exactly 12 TILE_* values, which
-- describe the layout and type of tiles found in the puzzle.
--
-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_MEMORY,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end