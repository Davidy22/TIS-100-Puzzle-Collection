function get_name()
	return "8 INDEX CLASH"
end

function get_description()
	return {
		"OUTPUT VALUE FROM IN.N IF GREATER THAN INDEX TIMES 8",
		"OUTPUT VALUE FROM IN.M IF LESS THAN INDEX TIMES 8",
	}
end

function get_streams()
	local inputA = {}
	local inputB = {}
	local output = {}
	local count = 0
	local variable = 0

	for i = 1, 39 do
		count = i * 8
		variable = math.random(1, 3)

		if (variable == 1 and i > 2) or (variable == 2 and i > 37) then
			inputA[i] = 8 * math.random(1, i - 1)
			inputB[i] = 8 * math.random(0, (inputA[i] / 8) - 1)
		elseif (variable == 2 and i < 38) or (variable == 1 and i < 3) then
			inputA[i] = 8 * math.random(i + 2, 40)
			inputB[i] = 8 * math.random(i + 1, (inputA[i] / 8) - 1)
		else
			inputA[i] = 8 * math.random(i + 1, 40)
			inputB[i] = 8 * math.random(0, i - 1)
		end

		if count > inputA[i] then
			output[i] = inputA[i]
		elseif count < inputB[i] then
			output[i] = inputB[i]
		else
			output[i] = 0
		end
	end
	return {
		{ STREAM_INPUT, "IN.N", 1, inputB },
		{ STREAM_INPUT, "IN.M", 2, inputA },
		{ STREAM_OUTPUT, "OUT.O", 2, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_DAMAGED, 	TILE_DAMAGED,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
