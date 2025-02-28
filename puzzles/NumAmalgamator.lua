function get_name()
	return "NUMERAL AMALGAMATOR"
end

function get_description()
	return {
		"IN.DI IS A SEQUENCE OF POSITIONS",
		"IN.NU IS A SEQUENCE OF NUMBERS",
		"  EXTRACT FROM IN.NU THE DIGIT",
		"  SPECIFIED BY IN.DI",
		"  REPEAT THREE TIMES AND",
		"  CONCATENATE THOSE NUMERALS",
	}
end

function get_streams()
	my0 = math.random(1, 13)
	my999 = math.random(1, 12)
	if my999 >= my0 then
		my999 = my999 + 1
	end

	inputA = {}
	inputB = {}
	output = {}
	for i = 1, 13 do
		if i == my0 then
			for j = 0, 2 do
				inputA[(3 * i) - j] = math.random(2, 3)
				inputB[(3 * i) - j] = math.floor(math.sqrt(10 * math.random(10, 640)))
				if inputA[(3 * i) - j] == 3 then
					inputB[(3 * i) - j] = inputB[(3 * i) - j] * 10
				else
					inputB[(3 * i) - j] = (math.floor(inputB[(3 * i) - j] / 10) * 100 + (inputB[(3 * i) - j] % 10))
				end
			end
			output[i] = 0
		elseif i == my999 then
			for j = 0, 2 do
				inputA[(3 * i) - j] = math.random(2, 3)
				inputB[(3 * i) - j] = math.floor(math.sqrt(10 * math.random(10, 640)))
				if inputA[(3 * i) - j] == 3 then
					inputB[(3 * i) - j] = inputB[(3 * i) - j] * 10 + 9
				else
					inputB[(3 * i) - j] = (math.floor(inputB[(3 * i) - j] / 10) * 100 + (inputB[(3 * i) - j] % 10) + 90)
				end
			end
			output[i] = 999
		else
			inputA[(3 * i) - 2] = math.random(1, 3)
			inputA[(3 * i) - 1] = math.random(1, 3)
			inputA[(3 * i)] = math.random(1, 3)
			inputB[(3 * i) - 2] = math.floor(math.sqrt(1000 * math.random(10, 640)))
			inputB[(3 * i) - 1] = math.floor(math.sqrt(1000 * math.random(10, 640)))
			inputB[(3 * i)] = math.floor(math.sqrt(1000 * math.random(10, 640)))
			output[i] = 100 * math.floor((inputB[(3 * i) - 2] / math.pow(10, 3 - inputA[(3 * i) - 2])) % 10)
			output[i] = output[i] + 10 * math.floor((inputB[(3 * i) - 1] / math.pow(10, 3 - inputA[(3 * i) - 1])) % 10)
			output[i] = output[i] + math.floor((inputB[(3 * i)] / math.pow(10, 3 - inputA[(3 * i)])) % 10)
		end
	end
	return {
		{ STREAM_INPUT, "IN.DI", 1, inputA },
		{ STREAM_INPUT, "IN.NU", 2, inputB },
		{ STREAM_OUTPUT, "OUT.AM", 2, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_MEMORY, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
