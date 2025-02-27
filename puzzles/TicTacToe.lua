function get_name()
	return "TIC TAC TOE"
end

function get_description()
	return { " 1 | 2 | 3   IN.X/IN.O - MOVES",
	         "---+---+---  X MOVES FIRST", 
	         " 4 | 5 | 6   0 - GAME ENDED",  
	         "---+---+---  OUT = 1 FOR X WIN",  
	         " 7 | 8 | 9        -1 FOR O WIN",
	         "BY @ZARAWESOME     0 FOR TIE"  }
end

function get_streams()
	input = {{}, {}}
	output = {}
	posInput = {1,1}
	posOutput = 1
	pos = math.random(1,9)
	for i = 1,7 do
		board = {}
		win = false
		player = 1
		moves = 0
		repeat
		repeat
			pos = math.random(1,9)
		until board[pos] == nil
		board[pos] = player
		input[player][posInput[player]] = pos
		posInput[player] = posInput[player] + 1
		player = 3 - player
		if board[1] == board[2] and board[2] == board[3] and board[1] != nil then
			win = 3 - (board[1] * 2)
		end
		if board[4] == board[5] and board[5] == board[6] and board[4] != nil then
			win = 3 - (board[4] * 2)
		end
		if board[7] == board[8] and board[8] == board[9] and board[7] != nil then
			win = 3 - (board[7] * 2)
		end
		if board[1] == board[5] and board[5] == board[9] and board[1] != nil then
			win = 3 - (board[1] * 2)
		end
		if board[3] == board[5] and board[5] == board[7] and board[3] != nil then
			win = 3 - (board[3] * 2)
		end
		if board[1] == board[4] and board[4] == board[7] and board[1] != nil then
			win = 3 - (board[1] * 2)
		end
		if board[2] == board[5] and board[5] == board[8] and board[2] != nil then
			win = 3 - (board[2] * 2)
		end
		if board[3] == board[6] and board[6] == board[9] and board[3] != nil then
			win = 3 - (board[3] * 2)
		end
		moves = moves + 1
		if moves >= 9 then
		   win = 0
		end
		until win != false
		output[posOutput] = win
		posOutput = posOutput + 1
		input[1][posInput[1]] = 0
		posInput[1] = posInput[1] + 1
		input[2][posInput[2]] = 0
		posInput[2] = posInput[2] + 1		
	end
	return {
		{ STREAM_INPUT, "IN.X", 0, input[1] },
		{ STREAM_INPUT, "IN.O", 2, input[2] },
		{ STREAM_OUTPUT, "OUT", 1, output }
	}
end

function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end
