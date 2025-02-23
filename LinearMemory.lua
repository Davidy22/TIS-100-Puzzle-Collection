-- The function get_name() should return a single string that is the name of the puzzle.
--
function get_name()
	return "LINEAR MEMORY UNIT"
end

-- The function get_description() should return an array of strings, where each string is
-- a line of description for the puzzle. The text you return from get_description() will 
-- be automatically formatted and wrapped to fit inside the puzzle information box.
--
function get_description()
	return { "CREATE A 8-VALUE MEMORY UNIT", "A READ COMMAND IS STARTED WITH 1 FOLLOWED BY A INDEX FROM 1 TO 8", "A WRITE COMMAND IS STARTED WITH 2 FOLLOWED BY A INDEX A VALUE TO WRITE" }
end

-- The function get_streams() should return an array of streams. Each stream is described
-- by an array with exactly four values: a STREAM_* value, a name, a position, and an array
-- of integer values between -999 and 999 inclusive.
--
-- STREAM_INPUT: An input stream containing up to 39 numerical values.
-- STREAM_OUTPUT: An output stream containing up to 39 numerical values.
-- STREAM_IMAGE: An image output stream, containing exactly 30*18 numerical values between 0
--               and 4, representing the full set of "pixels" for the target image.
--
-- NOTE: Arrays in Lua are implemented as tables (dictionaries) with integer keys that start
--       at 1 by convention. The sample code below creates an input array of 39 random values
--       and an output array that doubles all of the input values.
--
-- NOTE: To generate random values you should use math.random(). However, you SHOULD NOT seed
--       the random number generator with a new seed value, as that is how TIS-100 ensures that
--       the first test run is consistent for all users, and thus something that allows for the
--       comparison of cycle scores.
--
-- NOTE: Position values for streams should be between 0 and 3, which correspond to the far
--       left and far right of the TIS-100 segment grid. Input streams will be automatically
--       placed on the top, while output and image streams will be placed on the bottom.
--
function get_streams()
	input = {}
	output = {}
	memory = {}
	writen = {}
	counti = 0
	counto = 0
	for i = 1,8 do
		memory[i] = 0
		writen[1] = 0
	end
	repeat
		index = math.random(1, 8)
		value = math.random(100,999)
		rw = math.random(1,2)
		if rw == 1 then
			if writen[index] == 1 then
				input[counti+1], input[counti+2] = rw, index
				output[counto+1] = memory[index]
				counti, counto = counti+2, counto+1
			end
		else
			input[counti+1], input[counti+2], input[counti+3] = rw, index, value
			memory[index] = value
			writen[index] = 1
			counti = counti+3
		end 
	until counti > 36
	return {
		{ STREAM_INPUT, "IN.CMD", 2, input },
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
		TILE_COMPUTE, 	TILE_MEMORY, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_MEMORY,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
