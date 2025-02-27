function get_name()
	return "LARGE NUMBER ADDER"
end

function get_description()
	return { "LARGE NUMBERS ARE GIVEN WITH TWO INPUTS WITH UPPER AND LOWER THREE DIGITS OF THE NUMBER", "WRITE THE SUM OF TWO INPUT NUMBERS TO OUTPUTS AS LARGE NUMBERS" }
end

function get_streams()
	input1 = {{},{}}
	input2 = {{},{}}
	output = {{},{}}
	for i = 1,39 do
		repeat
			n1 = math.random(0, 999999)
			n2 = math.random(0, 999999)
			n3 = n1 + n2
		until n3 < 1000000
		input1[1][i], input1[2][i] = math.floor(n1/1000), n1 % 1000
		input2[1][i], input2[2][i] = math.floor(n2/1000), n2 % 1000
		output[1][i], output[2][i] = math.floor(n3/1000), n3 % 1000
	end
	return {
		{ STREAM_INPUT, "IN.AU", 0, input1[1] },
		{ STREAM_INPUT, "IN.BU", 1, input2[1] },
		{ STREAM_INPUT, "IN.AL", 2, input1[2] },
		{ STREAM_INPUT, "IN.BL", 3, input2[2] },
		{ STREAM_OUTPUT, "OUT.U", 1, output[1] },
		{ STREAM_OUTPUT, "OUT.L", 2, output[2] },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
