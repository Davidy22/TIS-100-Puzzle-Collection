-- ApertureScience42

function get_name()
	return "FAILED SEQUENCE CONCATENATOR"
end


function get_description()
	return { "READ A SEQUENCE FROM IN.A", "READ A SEQUENCE FROM IN.B", "APPEND THE SECOND SEQUENCE TO THE END OF THE FIRST", "OUTPUT THE RESULT TO OUT" }
end


function get_streams()

	for i = 1,205 do -- RNG manip better test set
		rng = math.random(41,43)
	end
	
	inputa = {}
	inputb = {}
	output = {}
	for i = 1,21 do
		inputa[i] = math.random(1, 42)
		-- rng = math.random(41,43)
		inputb[i] = math.random(1, 42)
	end
	
	inputa[22] = 0
	inputb[22] = 0
	ia = 1
	ib = 1
	ou = 1
	for i = 0,6 do
		-- a = math.random(1, 4)
		inputa[3 * i + math.random(1, 3)] = 0
		-- b = math.random(1, 4)
		inputb[3 * i + math.random(1, 3)] = 0
	end
	
	
	while ia <= 22 do
		if inputa[ia] ~= 0 then
			output[ou] = inputa[ia]
			ia = ia + 1
			ou = ou + 1
		else
			ia = ia + 1
			while true do
				output[ou] = inputb[ib]
				ib = ib + 1
				ou = ou + 1
				if inputb[ib - 1] == 0 then break end
			end
		end
	end
		
	
	return {
		{ STREAM_INPUT, "IN.A", 1, inputa },
		{ STREAM_INPUT, "IN.B", 3, inputb },
		{ STREAM_OUTPUT, "OUT.A", 2, output },
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
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_MEMORY,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end