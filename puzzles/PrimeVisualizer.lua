function get_name()
	return "PRIME VISUALIZER"
end

function get_description()
	return { "LET THE PIXEL AT (X, Y) HAVE VALUE 30*Y + X", 
	         "COLOR ALL PIXELS WITH PRIME VALUE BLACK",
	         "ALL OTHER PIXELS SHOULD BE RED" }
end

function get_streams()
    MAX = 30*18
    
    -- Sieve of Eratosthenes
    p = {}
    for i = 1, MAX do
    	p[i] = true
    end
    
    p[0] = false
    p[1] = false
    
    for i = 2, MAX do
    	if p[i] then
    		for j = 2, MAX do
    		    if i * j > MAX then break end
    			p[i*j] = false
    		end
    	end
    end

    -- Output
	output = {}
	for i = 1, MAX do
		if i == 1 then -- need to special case 0, 'cause 1-indexing :(
			output[i] = 4
		elseif p[i-1] then
			output[i] = 0
		else
			output[i] = 4
		end
	end
	return {
		{ STREAM_IMAGE, "IMAGE", 2, output },
	}
end

function get_layout()
	return { 
		TILE_DAMAGED, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,
		TILE_DAMAGED, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_DAMAGED,	
	}
end
