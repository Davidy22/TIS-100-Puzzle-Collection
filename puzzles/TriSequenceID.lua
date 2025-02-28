function get_name()
	return "TRI-SEQUENCE IDENTIFIER"
end

function get_description()
	return {
		"FOR EACH SUBSEQUENCE, DETERMINE WHICH FOLLOWING SEQUENCE IT BELONGS TO. OUTPUT THE NEXT VALUE",
		"1, 2,  4,   8, 1, 2,  4,   8, ...",
		"1, 4, 16,  64, 1, 4, 16,  64, ...",
		"1, 8, 64, 512, 1, 8, 64, 512, ...",
	}
end

function get_streams()
	Loop = { { 1, 2, 4, 8 }, { 1, 4, 16, 64 }, { 1, 8, 64, 512 } }

	input = {}
	output = {}
	i = 1
	j = 1
	while i < 39 do
		a = math.random(1, 3)
		b = math.random(-1, 2)
		c = 3 * math.random(1, 2) - math.random(0, 1)
		d = math.min(39 - i - 3, c)
		if c > d then
			d = d + 3
		end

		for k = 1, d do
			input[i + k - 1] = Loop[a][(b + k) % 4 + 1]
		end

		input[i + d] = 0
		output[j] = Loop[a][(b + d + 1) % 4 + 1]
		j = j + 1
		i = i + d + 1
	end
	return {
		{ STREAM_INPUT, "N.ETA", 2, input },
		{ STREAM_OUTPUT, "N.RHO", 1, output },
	}
end
-- stylua: ignore
function get_layout()
	return { 
		TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_MEMORY, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_DAMAGED, 	TILE_DAMAGED,
	}
end
