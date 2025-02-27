function get_name()
	return "GREATEST COMMON DIVISOR"
end

function get_description()
	return {
		"READ A AND B",
		"FIND THE GREATEST NUMBER THAT IS A DIVISOR OF BOTH A AND B",
		"WRITE GREATEST COMMON DIVISOR TO OUT.GCD",
	}
end

function gcd(a, b)
	while b ~= 0 do
		b, a = a % b, b
	end
	return a
end

function get_streams()
	inputA = {}
	inputB = {}
	output = {}
	pos1 = math.random(1, 39)
	for i = 1, 39 do
		d = ({ math.random(1, 7), math.random(8, 23), math.random(24, 63), math.random(64, 511) })[math.random(4)]
		if i == pos1 then
			d = 1
		end
		lim = math.floor(999 / d)
		repeat
			a = math.random(1, lim)
			b = math.random(1, lim)
		until gcd(a, b) == 1 -- About 60% (6 pi^-2) chance of success per iteration, so this will terminate fast.
		inputA[i] = d * a
		inputB[i] = d * b
		output[i] = d
	end
	return {
		{ STREAM_INPUT, "IN.A", 1, inputA },
		{ STREAM_INPUT, "IN.B", 2, inputB },
		{ STREAM_OUTPUT, "OUT.GCD", 2, output },
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
