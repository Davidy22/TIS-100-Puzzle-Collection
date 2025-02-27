function get_name()
	return "LOGARITHM"
end

function get_description()
	return { "READ VALUES FROM IN.N AND IN.B", "COMPUTE LOG(N) BASE B ROUNDED DOWN", "WRITE TO OUT.LOG" }
end

function get_streams()
	inputn = {}
	inputb = {}
	output = {}
	for i = 1, 39 do
		inputn[i] = math.floor(math.pow(10, 0.5 + 2.5 * math.random()))
		inputb[i] = math.random(2, 10)

		--"computing" log by trial and error  :(
		for j = 1, 11 do
			if math.pow(inputb[i], j) > inputn[i] then
				output[i] = j - 1
				break
			end
		end
	end

	--force a couple to be exact as an edge case
	for i = 1, 3 do
		j = math.random(1, 39)
		inputn[j] = math.pow(inputb[j], output[j])
	end

	return {
		{ STREAM_INPUT, "IN.N", 1, inputn },
		{ STREAM_INPUT, "IN.B", 2, inputb },
		{ STREAM_OUTPUT, "OUT.LOG", 2, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
