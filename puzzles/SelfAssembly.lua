function get_name()
	return "AUTOMATIC SELF-ASSEMBLY"
end

function get_description()
	return { "READ 15 COMMANDS FROM CMD", 
			"REPLICATE T-21 NODE EXECUTION", 
			"0=NOP; 101=MOV ACC OUT;", 
			"110=MOV IN ACC; 111=MOV IN OUT;", 
			"200=SWP; 300=SAV;", 
			"410=ADD IN; 510=SUB IN; 600=NEG",
			}
end

function get_streams()
	commands = {}
	input = {}
	output = {}
	for i = 1,14 do
		commands[i] = assign_command()
	end
	commands[15] = 101	--force ACC to output as final command
	assign_input_output(input, output, commands)
	return {
		{ STREAM_INPUT, "CMD", 1, commands},
		{ STREAM_INPUT, "IN", 3, input},
		{ STREAM_OUTPUT, "OUT", 3, output},
	}
end

-- The function assign_input_output() should return nothing. 
-- This function needs the input, output, and command arrays.
-- It will calculate the maximum size either input or output can be based on commands, 
-- then assign random numbers to input from -99 to 99.
function assign_input_output(input, output, commands)
	acc = 0
	bak = 0
	incount = 0
	outcount = 0
	while incount < 39 and outcount < 39 do
		for i = 1, 15 do
			if incount >= 39 or outcount >= 39 then
				return	
			end
			if commands[i] == 101 then			--mov acc, out
				table.insert(output, acc)
				outcount = outcount + 1
			elseif commands[i] == 110 then		--mov in, acc
				inval = math.random(-99,99)
				acc = inval
				table.insert(input, inval)
				incount = incount + 1
			elseif commands[i] == 111 then		--mov in, out
				inval = math.random(-99,99)
				table.insert(output, inval)
				table.insert(input, inval)
				incount = incount + 1
				outcount = outcount + 1
			elseif commands[i] == 200 then		--swp
				tmp = acc
				acc = bak
				bak = tmp
			elseif commands[i] == 300 then		--sav
				bak = acc
			elseif commands[i] == 410 then		--add in
				maxnegative = -99
				maxpositive = 99
				if acc > 0 then
					maxpositive = 99-acc
				else
					maxnegative = -99-acc
				end
				inval = math.random(maxnegative,maxpositive)
				acc = acc + inval
				table.insert(input, inval)
				incount = incount + 1
			elseif commands[i] == 510 then		--sub in
				maxnegative = -99
				maxpositive = 99
				if acc < 0 then
					maxpositive = 99+acc
				else
					maxnegative = -99+acc
				end
				inval = math.random(maxnegative,maxpositive)
				acc = acc - inval
				table.insert(input, inval)
				incount = incount + 1
			elseif commands[i] == 600 then		--neg
				acc = acc * -1
			end
		end
	end
end

-- The function assign_command() should return a 3-digit number representing the command value
-- 000=NOP, 101=MOV ACC OUT, 110=MOV IN ACC, 111=MOV IN OUT, 200=SWP, 300=SAV 
-- 410=ADD IN, 510=SUB IN, 600=NEG
function assign_command()
	command = math.random(0,6)
	secondbit = 0
	thirdbit = 0
	if command == 0 or command == 3 then	-- Lower chance of 0, 3
		if math.random(0,1) == 0 then
			command = math.random(1,6)
		end
	end
	if command == 1 then			--randomize ACC
		switch = math.random(1,3)
		if switch == 1 then
			thirdbit = 1
		elseif switch == 2 then
			secondbit = 1
		else
			secondbit = 1
			thirdbit = 1
		end
	elseif command == 4 then		--make sure SUB and ADD use IN
		secondbit = 1
	elseif command == 5 then
		secondbit = 1
	end
	command = command*100 + secondbit*10 + thirdbit*1
	return command
end

function get_layout()
	return { 
		TILE_MEMORY, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_MEMORY, 	TILE_DAMAGED,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
