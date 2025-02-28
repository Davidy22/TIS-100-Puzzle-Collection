function get_name()
	return "OUT-OF-RANGE DIGIT VIEWER A"
end

function get_description()
	return { "OUTPUT TO R.DI THE THOUSANDS DIGIT OF R.BA RAISED TO R.EX" }
end

function get_streams()
	inputA = {}
	inputB = {}
	output = {}
	x = math.random(1, 39)
	y = math.random(1, 39)
	while x == y do
		y = math.random(1, 39)
	end
	for i = 1, 39 do
		inputA[i] = math.random(2, 6)
		if i == x then
			inputB[i] = 0
		elseif i == y then
			inputB[i] = 99
		else
			inputB[i] = math.random(0, 99)
		end
		output[i] = thoupow(inputA[i], inputB[i])
	end
	return {
		{ STREAM_INPUT, "R.BA", 0, inputA },
		{ STREAM_INPUT, "R.EX", 1, inputB },
		{ STREAM_OUTPUT, "R.DI", 1, output },
	}
end

function thoupow(b, p)
	if p == 0 then
		return 0
	end
	local power = 1
	for i = 1, p do
		power = (power * b) % 10000
	end
	return math.floor(power / 1000)
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_MEMORY, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
