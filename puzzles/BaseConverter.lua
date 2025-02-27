function get_name()
	return "NUMBER BASE CONVERTER"
end


function get_description()
	return { "READ BASE 10 NUMBER FROM IN.A", 
			 "READ BASE FROM IN.B",
			 "CONVERT NUMBER TO PROVIDED BASE",
			 "WRITE CONVERTED NUMBER TO OUT"}
end

function get_streams()
	input_vals = {}
	input_bases = {}
	output = {}

	for i = 1,39 do
		input_bases[i] = math.random(2, 10)
		-- max val below based on highest displayable in this number base
		input_vals[i] = math.random(1, (input_bases[i] ^ 3) - 1)
		
		-- convert random number to provided base
		out_string = ""
		num = input_vals[i]
		base = input_bases[i]
		while num ~= 0 do
			remainder = tostring(num % base)
			num = math.floor(num / base)
			out_string = remainder .. out_string
		end
		output[i] = tonumber(out_string)
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, input_vals },
		{ STREAM_INPUT, "IN.B", 2, input_bases },
		{ STREAM_OUTPUT, "OUT", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
