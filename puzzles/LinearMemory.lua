function get_name()
	return "LINEAR MEMORY UNIT"
end

function get_description()
	return { "CREATE A 8-VALUE MEMORY UNIT", "A READ COMMAND IS STARTED WITH 1 FOLLOWED BY A INDEX FROM 1 TO 8", "A WRITE COMMAND IS STARTED WITH 2 FOLLOWED BY A INDEX A VALUE TO WRITE" }
end

function get_streams()
	input = {}
	output = {}
	memory = {}
	writen = {}
	counti = 0
	counto = 0
	for i = 1,8 do
		memory[i] = 0
		writen[1] = 0
	end
	repeat
		index = math.random(1, 8)
		value = math.random(100,999)
		rw = math.random(1,2)
		if rw == 1 then
			if writen[index] == 1 then
				input[counti+1], input[counti+2] = rw, index
				output[counto+1] = memory[index]
				counti, counto = counti+2, counto+1
			end
		else
			input[counti+1], input[counti+2], input[counti+3] = rw, index, value
			memory[index] = value
			writen[index] = 1
			counti = counti+3
		end 
	until counti > 36
	return {
		{ STREAM_INPUT, "IN.CMD", 2, input },
		{ STREAM_OUTPUT, "OUT", 2, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_MEMORY, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_MEMORY,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
