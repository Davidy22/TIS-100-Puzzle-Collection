function get_name()
	return "BRAIDING ENTANGLEMENT"
end

function get_creator()
	return "Simon Parent"
end

function get_description()
	return {
		"EACH INPUT HAS EXACTLY 39 VALUES",
		"READ VALUES FROM IN.A AND IN.B",
		"WRITE THE LESSER VALUE TO OUT.Y",
		"WRITE THE GREATER VALUE TO OUT.Z",
	}
end

function get_streams()
	input1 = {}
	input2 = {}
	output1 = {}
	output2 = {}
	for i = 1, 39 do
		input1[i] = math.random(10, 99)
		input2[i] = math.random(10, 99)
		output1[i] = math.min(input1[i], input2[i])
		output2[i] = math.max(input1[i], input2[i])
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, input1 },
		{ STREAM_INPUT, "IN.B", 3, input2 },
		{ STREAM_OUTPUT, "OUT.Y", 0, output1 },
		{ STREAM_OUTPUT, "OUT.Z", 3, output2 },
	}
end
-- stylua: ignore
function get_layout()
    return {
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE,
    }
end
