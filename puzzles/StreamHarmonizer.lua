function get_name()
	return "STREAM HARMONIZER"
end

function get_description()
	return { "READ INTEGERS A, B, C FROM IN.A, IN.B, IN.C", 
	         "OUTPUT 1 IF C = A*X + B*Y FOR SOME INTEGERS X AND Y",
	         "OUTPUT 0 OTHERWISE" }
end

function get_streams()
	A = {}
	B = {}
	C = {}
	OUT = {}
	for i = 1,39 do
		A[i] = math.random(0, 99)
		B[i] = math.random(0, 99)
		
		-- Make some cases where GCD > 1 and OUT = 1
		g = gcd(A[i], B[i])
		if g > 1 and math.random(0, 1) == 0 then
			C[i] = math.min(A[i], B[i]) + math.random(-9, 9) * g
	    else
	    	C[i] = math.random(-99, 99)
	    end
		OUT[i] = getOutput(A[i], B[i], C[i])
	end
	return {
		{ STREAM_INPUT, "IN.A", 0, A },
		{ STREAM_INPUT, "IN.B", 1, B },
		{ STREAM_INPUT, "IN.C", 3, C },
		{ STREAM_OUTPUT, "OUT", 2, OUT },
	}
end


function getOutput(a, b, c)
  g = gcd(a, b)
  
  if (a - c) % g == 0 then
    return 1
  else
    return 0
  end
end

function gcd(a, b)
  if b == 0 then
    return a
  else
    return gcd(b, a%b)
  end
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
