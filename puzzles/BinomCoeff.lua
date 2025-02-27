function get_name()
	return "BINOMIAL COEFFICIENT"
end

function get_description()
	return { "READ N AND K", "CALCULATE NUMBER OF WAYS TO CHOOSE K ELEMENTS FROM A SET OF N DISTINCT ELEMENTS", "WRITE NUMBER OF CHOICES TO OUT.C" }
end

function get_streams()
    tests = {{0,0}}
    n_tests = 1
    pascal = {[0]={[0]=1}}
    
    for n = 1, 12 do
        pascal[n] = {[0]=1, [n]=1}
        for k = 1, n - 1 do
            pascal[n][k] = pascal[n-1][k-1] + pascal[n-1][k]
        end
        for k = 0, n do
            n_tests = n_tests + 1
            tests[n_tests] = {n, k}
        end
    end
    
	inputN = {}
    inputK = {}
	output = {}
	for i = 1,39 do
        j = math.random(n_tests)
		inputN[i] = tests[j][1]
		inputK[i] = tests[j][2]
		output[i] = pascal[inputN[i]][inputK[i]]
        
        tests[j] = tests[n_tests]
        n_tests = n_tests - 1
	end
	return {
		{ STREAM_INPUT, "IN.N", 1, inputN },
		{ STREAM_INPUT, "IN.K", 2, inputK },
		{ STREAM_OUTPUT, "OUT.C", 2, output },
	}
end

function get_layout()
	return { 
		TILE_MEMORY, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_MEMORY,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
