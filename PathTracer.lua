-- The function get_name() should return a single string that is the name of the puzzle.
--
function get_name()
	return "PATH TRACER"
end

-- The function get_description() should return an array of strings, where each string is
-- a line of description for the puzzle. The text you return from get_description() will 
-- be automatically formatted and wrapped to fit inside the puzzle information box.
--
function get_description()
	return { "READ AN ANGLE IN DEGREES FROM IN",
					 "READ A LENGTH FROM IN",
					 "START AT 0,0, DRAW A LINE SEGMENT AT THAT ANGLE WITH THAT LENGTH",
					 "THE NEXT LINE SEGMENT BEGINS ON THE END OF THE LAST" }
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
	-- Initialize the image grid to all zeros (black):
	::retry::
  image = {}
  for i = 1,30*18 do
    image[i] = 0
  end
  image[1] = 3

	input = {}
	x = 0
	y = 0
	dx = 0
	dy = 1
	num_segments = 0
	num_fails = 0

	while (num_segments < 19) do
		-- Define new segment
		local new_dx
		local new_dy
		if dx == 0 then
			new_dx = math.random(0, 1) * 2 - 1
			new_dy = 0
		else
			new_dx = 0
			new_dy = math.random(0, 1) * 2 - 1
		end
		length = math.random(3, 15)

		-- Check that this segment doesn't overlap or touch past segments too much
		final_x = x + new_dx * length
		if final_x < 0 or final_x >= 30 then
			num_fails = num_fails + 1
			goto continue
		end
		final_y = y + new_dy * length
		if final_y < 0 or final_y >= 18 then
			num_fails = num_fails + 1
			goto continue
		end
		neighbors = 0
		for i = 2, length do
			local new_x = x + new_dx * i
			local new_y = y + new_dy * i
			neighbors = neighbors + idx(image, coor(new_x, new_y))
			neighbors = neighbors + idx(image, coor(new_x - 1, new_y))
			neighbors = neighbors + idx(image, coor(new_x + 1, new_y))
			neighbors = neighbors + idx(image, coor(new_x, new_y - 1))
			neighbors = neighbors + idx(image, coor(new_x, new_y + 1))
		end
		if neighbors / length > 1.5 then
			num_fails = num_fails + 1
			goto continue
		end

		-- Add this segment to input and output
		dx = new_dx
		dy = new_dy
		if dx == 1 and dy == 0
			then input[num_segments * 2 + 1] = 0
		elseif dx == 0 and dy == -1
			then input[num_segments * 2 + 1] = 90
		elseif dx == -1 and dy == 0
			then input[num_segments * 2 + 1] = 180
		elseif dx == 0 and dy == 1
			then input[num_segments * 2 + 1] = 270
		end
		input[num_segments * 2 + 2] = length + 1

		for i = 1,length do
			x = x + dx
			y = y + dy
			image[coor(x, y)] = 3
		end

		num_segments = num_segments + 1
		::continue::
		if num_fails > 100 then
			goto retry
		end
	end
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_IMAGE, "", 2, image },
	}
end

function coor(x, y)
	if x < 0 or x >= 30 or y < 0 or y >= 30 then
		return -1
	end
	return 1 + x + y * 30
end

function idx(array, i)
	if i < 1 or i > #array then
		return 0
	end
	return array[i]
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
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end