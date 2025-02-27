function get_name()
	return "STAR MAPPER"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ A COLOUR FROM IN ", "READ AN X VALUE FROM IN", "READ A Y VALUE FROM IN", "DRAW A POINT OF THAT COLOUR AT THE SPECIFIED LOCATION" }
end

function get_streams()
	input = {}
	output = {}
	colours = { 4, 3, 2, 2, 2, 2, 2, 1, 2, 1, 3, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	
	for i = 1,37,3 do
		input[i] = colours[math.random(1,28)]
		input[i+1] = math.random(0,29)
		input[i+2] = math.random(0,17)
	end
	
	if input[2] == 26 and input[3] == 11 and input[5] == 14 then
		input = {4,18,3,3,19,13,2,23,6,2,13,11,2,17,8,2,18,8,2,19,8,1,22,4,2,16,10,1,17,9,3,1,12,1,26,9,1,28,8}
	end
	
	for i = 1,540 do
		output[i] = 0
	end
	for i = 1,37,3 do
		output[input[i+1] + input[i+2]*30 + 1] = input[i]
	end

	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_IMAGE, "IMAGE", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
	}
end
