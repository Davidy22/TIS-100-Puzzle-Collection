-- The function get_name() should return a single string that is the name of the puzzle.
--
function get_name()
	return "TIC TAC TOE"
end

-- The function get_description() should return an array of strings, where each string is
-- a line of description for the puzzle. The text you return from get_description() will 
-- be automatically formatted and wrapped to fit inside the puzzle information box.
--
function get_description()
	return { " 1 | 2 | 3   IN.X/IN.O - MOVES",
	         "---+---+---  X MOVES FIRST", 
	         " 4 | 5 | 6   0 - GAME ENDED",  
	         "---+---+---  OUT = 1 FOR X WIN",  
	         " 7 | 8 | 9        -1 FOR O WIN",
	         "BY @ZARAWESOME     0 FOR TIE"  }
end

-- The function get_streams() should return an array of streams. Each stream is described
-- by an array with exactly four values: a STREAM_* value, a name, a position, and an array
-- of integer values between -999 and 999 inclusive.
--
-- STREAM_INPUT: An input stream containing up to 39 numerical values.
-- STREAM_OUTPUT: An output stream containing up to 39 numerical values.
-- STREAM_IMAGE: An image output stream, containing exactly 30*18 numerical values between 0
--               and 4, representing the full set of "pixels" for the target image.
--
-- NOTE: Arrays in Lua are implemented as tables (dictionaries) with integer keys that start
--       at 1 by convention. The sample code below creates an input array of 39 random values
--       and an output array that doubles all of the input values.
--
-- NOTE: To generate random values you should use math.random(). However, you SHOULD NOT seed
--       the random number generator with a new seed value, as that is how TIS-100 ensures that
--       the first test run is consistent for all users, and thus something that allows for the
--       comparison of cycle scores.
--
-- NOTE: Position values for streams should be between 0 and 3, which correspond to the far
--       left and far right of the TIS-100 segment grid. Input streams will be automatically
--       placed on the top, while output and image streams will be placed on the bottom.
--
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

-- The function get_layout() should return an array of exactly 12 TILE_* values, which
-- describe the layout and type of tiles found in the puzzle.
--
-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end