function get_name()
	return "FACTOR COUNTER"
end

function get_creator()
	return "David"
end

function get_description()
	return {
		"READ A VALUE FROM IN.",
		"WRITE NUMBER OF DIVISORS TO OUT.",
	}
end

function count_divisors(n)
	local count = 0
	local sqrt_n = math.sqrt(n)

	for i = 1, sqrt_n do
		if n % i == 0 then
			if i == n / i then
				count = count + 1
			else
				count = count + 2
			end
		end
	end

	return count
end

function get_streams()
	input = {}
	output = {}
	for i = 1, 39 do
		input[i] = math.random(1, 999)
		output[i] = count_divisors(input[i])
	end

	return {
		{ STREAM_INPUT, "IN", 0, input },
		{ STREAM_OUTPUT, "OUT", 3, output },
	}
end

-- stylua: ignore
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_JOURNAL, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
