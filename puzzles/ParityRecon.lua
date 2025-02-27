function get_name()
	return "PARITY RECONSTRUCTION"
end

function get_description()
	return {"PARITY OF INPUTS A-D SHOULD BE EVEN",
			"ONE INPUT HAS BEEN CORRUPTED",
			"WRITE THE CORRECTED VALUE TO OUT"}
end

function get_streams()
	input = {{},{},{},{}}
	output = {}
	for i = 1,39 do
		for j = 1,3 do
			input[j][i] = math.random(0, 1)
		end
		input[4][i] = (input[1][i]+input[2][i]+input[3][i])%2
		
		j = math.random(1,4)		
		output[i] = input[j][i]
		input[j][i] = math.random(-9,-1)
	end
	
	
	return {
		{ STREAM_INPUT, "IN.A", 0, input[1] },
		{ STREAM_INPUT, "IN.B", 1, input[2] },
		{ STREAM_INPUT, "IN.C", 2, input[3] },
		{ STREAM_INPUT, "IN.D", 3, input[4] },
		
		{ STREAM_OUTPUT, "OUT", 2, output }
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
