-- The function get_name() should return a single string that is the name of the puzzle.
--
function get_name()
	return "COLLATZ CONJECTURE"
end

-- The function get_description() should return an array of strings, where each string is
-- a line of description for the puzzle. The text you return from get_description() will 
-- be automatically formatted and wrapped to fit inside the puzzle information box.
--
function get_description()
	return { "READ NUMBER N FROM IN.N", "IF N EVEN: STEP TO N / 2", "IF N ODD: STEP TO 3 * N + 1", "REPEAT STEPS UNTIL N = 1", "WRITE NUMBER OF STEPS TO REACH 1", "(INTERMEDIATE N STAY BELOW 1000)" }
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
    ok_numbers = {10, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11, 12, 13, 14, 15, 16, 17, 18, 19,
        20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 32, 33, 34, 35, 36, 37, 38,
        39, 40, 42, 43, 44, 45, 46, 48, 49, 50, 51, 52, 53, 56, 57, 58, 59,
        60, 61, 64, 65, 66, 67, 68, 69, 70, 72, 74, 75, 76, 77, 78, 79, 80,
        81, 84, 85, 86, 87, 88, 89, 90, 92, 93, 96, 98, 99, 100, 101, 102,
        104, 105, 106, 112, 113, 114, 115, 116, 117, 118, 119, 120, 122, 123,
        128, 130, 131, 132, 133, 134, 135, 136, 138, 139, 140, 141, 144, 148,
        149, 150, 152, 153, 154, 156, 157, 158, 160, 162, 163, 168, 170, 172,
        173, 174, 176, 177, 178, 179, 180, 181, 184, 185, 186, 187, 192, 196,
        197, 198, 200, 202, 203, 204, 205, 208, 209, 210, 211, 212, 213, 217,
        224, 226, 228, 229, 230, 232, 234, 236, 237, 238, 240, 241, 244, 245,
        246, 249, 256, 260, 261, 262, 264, 266, 268, 269, 270, 272, 273, 276,
        277, 278, 280, 281, 282, 288, 289, 296, 298, 300, 301, 304, 305, 306,
        308, 309, 312, 314, 316, 317, 320, 321, 324, 325, 326, 336, 340, 344,
        346, 348, 352, 354, 356, 358, 360, 362, 368, 370, 372, 374, 384, 392,
        394, 396, 400, 404, 406, 408, 410, 416, 418, 420, 422, 424, 426, 434,
        448, 452, 456, 458, 460, 464, 468, 472, 474, 476, 480, 482, 488, 490,
        492, 498, 512, 520, 522, 524, 528, 532, 536, 538, 540, 544, 546, 552,
        554, 556, 560, 562, 564, 576, 578, 592, 596, 600, 602, 608, 610, 612,
        616, 618, 624, 628, 632, 634, 640, 642, 648, 650, 652, 672, 680, 688,
        692, 696, 704, 708, 712, 716, 720, 724, 736, 740, 744, 748, 768, 784,
        788, 792, 800, 808, 812, 816, 820, 832, 836, 840, 844, 848, 852, 868,
        896, 904, 912, 916, 920, 928, 936, 944, 948, 952, 960, 964, 976, 980,
        984, 996
    }
    
	input = {}
	output = {}
	for i = 1,39 do
        j = math.random(#ok_numbers)
        n = ok_numbers[j]
		input[i] = n
        answer = 0
        while n >= 2 do
            answer = answer + 1
            if n % 2 == 0 then
                n = n / 2
            else
                n = 3 * n + 1
            end
        end
		output[i] = answer
	end
	return {
		{ STREAM_INPUT, "IN.N", 1, input },
		{ STREAM_OUTPUT, "OUT.STEPS", 1, output },
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