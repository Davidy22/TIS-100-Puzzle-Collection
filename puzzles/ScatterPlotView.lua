-- This is a recreation of the removed level

function get_name()
	return "SCATTER PLOT VIEWER"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ AN X VALUE FROM IN", " READ A Y VALUE FROM IN", "READ A SPRITE VALUE FROM IN", "IF SPRITE - 1, DRAW A WHITE PLUS", "IF SPRITE - 2, DRAW A RED X"	}
end

function draw(image, x, y, c)
	if x >= 0 and x<30 and y >=0 and y < 18 then
		image[x + y * 30 +1] = c
	end
end

function get_streams()

	input = {10,2,1,17,14,2,5,12,2,27,12,1,26,9,2,19,7,1,26,4,2,24,5,2,8,5,2,1,15,1,28,14,2,21,16,1,11,8,2}
	output = {}
	for i = 1, 540 do
		output[i] = 0
	end
	
	for i = 1,36,3 do
		x = input[i]
		y = input[i+1]
		if input[i + 2] == 1 then
			draw(output, x, y, 3)
			draw(output, x-1, y, 3)
			draw(output, x+1, y, 3)
			draw(output, x, y-1, 3)
			draw(output, x, y+1, 3)
		else
			draw(output, x, y, 4)
			draw(output, x-1, y-1, 4)
			draw(output, x+1, y-1, 4)
			draw(output, x-1, y+1, 4)
			draw(output, x+1, y+1, 4)
		end
	end
	
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_IMAGE, "OUT.A", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
	}
end
