function get_name()
	return "BI-QUINARY DATA VIEWER"
end

function get_creator()
	return "killerbee13"
end

function get_description()
	return {
		"VISUALIZE VALUES IN PACKED BI-QUINARY CODED DECIMAL",
		"5 DIGITS PER LINE, INCLUDING ALL LEADING ZEROES.",
		"MARK THE 5S COLUMNS WITH A DARK GREY BACKGROUND",
	}
end

function get_streams()
	input = {}
	stream = {}
	output = {
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
		1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,  1, 0,0,0,0,0,
	}
	
	for i = 0,89 do
		stream[i] = math.random(0, 9)
		p = i * 6 + 1
		if stream[i] > 4 then
			output[p] = 3
		end
		output[p + (5 - stream[i]%5)] = 3
	end
	for i = 0,29 do
		input[i+1] = stream[i*3]*100 + stream[i*3+1]*10 + stream[i*3+2]
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, input },
		{ STREAM_IMAGE, "IMAGE", 1, output },
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED, 	TILE_DAMAGED,
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_JOURNAL, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
