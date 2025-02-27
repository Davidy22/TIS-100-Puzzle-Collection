-- This problem builds on "COLOUR ENCODER DECODER" and "POINT ENCODER DECODER"

function get_name()
	return "ENCODED STAR MAPPER"
end

function get_creator()
	return "ApertureScience42"
end

function get_description()
	return { "READ AN ENCODED 4 COLOUR VALUE FROM IN FOLLOWED BY 4 ENCODED POINTS FROM IN", "DECODE AND WRITE THE COLOURED POINTS TO OUT" }
end


function get_streams()
	colours = { 4, 3, 2, 2, 2, 2, 2, 1, 2, 1, 3, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	inputC = {}
	inputX = {}
	inputY = {}
	randcheck = {math.random(1,999),math.random(1,999)}
	
	if randcheck[1] == 316 and randcheck[2] == 919 then -- Would like to change to ~= or ~= and randomize the first run
		--         1            2           3           4            5           6            7
		inputC = { 4, 3, 2, 2, 2, 2, 2, 1, 2, 1, 3, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}--, 1, 1, 1}
		inputX = {18,19,23,13,17,18,19,22,16,17, 1,26,28,27, 4,12,11,16,21, 1, 7,10,10,19,25,27, 3,29}--,19,17, 3}
		inputY = { 3,13, 6,11, 8, 8, 8, 4,10, 9,12, 9, 7, 8,13,16,14,17,12, 9, 8, 8,13,10,12,13, 2, 4}--,12,12, 2}
	else
		for i = 1,28 do
			inputC[i] = colours[math.random(1,28)]
			inputX[i] = math.random(0,29)
			inputY[i] = math.random(0,17)
		end
	end
	inputXY = {}
	inputCE = {}
	input = {}
	output = {}
	
	for i = 1,28 do
		inputXY[i] = inputX[i] + inputY[i] * 30
	end
	for i = 1,7 do
		inputCE[i] = 0
		for j = 0,3 do -- High digit first
			inputCE[i] = inputCE[i] + math.pow(5,3-j) * inputC[4*(i-1) + j + 1]
		end

	end
	
	for i = 1,540 do
		output[i] = 0
	end
	for i = 1,28 do
		output[inputXY[i]+1 ] = inputC[i]
	end
	
	input = inputXY -- LUA! no built in way to copy a table?
	for i = 1,7 do
		table.insert(input, i*5-4, inputCE[i])
	end
	

	
	return {
		{ STREAM_INPUT, "IN", 1, input },
		{ STREAM_IMAGE, "IMAGE", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
	}
end
