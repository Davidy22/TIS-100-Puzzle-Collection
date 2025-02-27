function get_name()
	return "SIGNAL TRIANGULATION"
end

function get_description()
	return { "READ A SIDE LENGTH FROM IN.A", "READ A SIDE LENGTH FROM IN.B",
			"CALCULATE HYPOTENUSE OF RIGHT TRIANGLE WITH LEG A, LEG B","ROUND VALUE DOWN AND WRITE TO OUT"}
end

function get_streams()
	input1 = {}
	input2 = {}
	output = {}
	for i = 1,39 do
		input1[i] = math.random(1, 11)
		input2[i] = math.random(1, 11)
		output[i] = math.floor(math.sqrt(input1[i]*input1[i]+input2[i]*input2[i]))
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, input1 },
		{ STREAM_INPUT, "IN.B", 3, input2 },
		{ STREAM_OUTPUT, "OUT.C", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_MEMORY,	TILE_DAMAGED,	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_MEMORY, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
