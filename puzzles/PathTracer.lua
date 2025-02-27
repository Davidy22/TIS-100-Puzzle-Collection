function get_name()
	return "PATH TRACER"
end

function get_description()
	return { "READ AN ANGLE IN DEGREES FROM IN",
					 "READ A LENGTH FROM IN",
					 "START AT 0,0, DRAW A LINE SEGMENT AT THAT ANGLE WITH THAT LENGTH",
					 "THE NEXT LINE SEGMENT BEGINS ON THE END OF THE LAST" }
end

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

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
