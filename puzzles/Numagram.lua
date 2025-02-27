function get_name()
	return "NUMAGRAM"
end

function get_description()
	return { "READ A NUMBER FROM IN.A AND IN.B", "CHECK WHETHER THE NUMBERS CONTAIN THE SAME DIGITS, NOT NECESSARILY IN THE SAME ORDER", "OUTPUT 1 IF THEY DO, ELSE 0" }
end

function get_streams()
	local input = {}
	local input2 = {}
	local output = {}
	
	for i = 1,39 do
		local num1 = math.random(100, 999)
		local num2 = math.random(100, 999)
		input[i] = num1
		input2[i] = num2
		
		local num1Digits = digits(num1)
		local tries = 0
		local found = false
		while tries < 100 and num2+tries < 1000 do
			local num2Digits = digits(num2+tries)
			if num1Digits[1] == num2Digits[1] and num1Digits[2] == num2Digits[2] and num1Digits[3] == num2Digits[3] then
				input2[i] = num2+tries
				output[i] = 1
				found = true
				break
			end
			tries = tries+7
		end
		
		if not found then
			output[i] = 0
		end
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, input },
		{ STREAM_INPUT, "IN.B", 2, input2 },
		{ STREAM_OUTPUT, "OUT", 2, output },
	}
end

function digits(num)
	local result = {}
	while num > 0 do
		local remainder = math.floor(num/10)
		local lastDigit = num - remainder*10
		table.insert(result, lastDigit)
		num = remainder
	end
	table.sort(result)
	return result
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end