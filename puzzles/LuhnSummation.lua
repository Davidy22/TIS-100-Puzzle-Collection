function get_name()
	return "Luhn Summation"
end

function get_description()
	return {
		"ADD EVEN DIGITS.",
		"DOUBLE ODD DIGITS, IF DOUBLED IS GREATER THAN 9, SUBTRACT 9",
		"IF SUM MULTIPLE OF 10, WRITE 0, ELSE WRITE (10-UNIT DIGIT) TO CHK",
		"SEQUENCES ARE -1 TERMINATED",
	}
end

function luhn(input, output, check, count)
	-- The first element in this sequence
	local head = #input + 1
	-- The last element in this sequence
	local tail = head + count - 1
	-- Sum of the number
	local sum = 0
	-- If true the number doubled
	local doDouble = true

	-- Generate the sequence
	for i = head, tail do
		-- Generate a number
		local inp = math.random(0, 9)
		-- Insert into the input
		table.insert(input, inp)
		-- Doubling?
		if doDouble then
			inp = inp * 2
			-- Bigger than 9?
			if inp > 9 then
				inp = inp - 9
			end
		end
		-- Add to sum
		sum = sum + inp
		-- Flip doubling flag
		doDouble = not doDouble
	end
	-- Append the sequence terminator
	table.insert(input, -1)

	-- Add the sum, and terminator, to the output
	table.insert(output, sum)
	table.insert(output, -1)

	-- Add check digit
	table.insert(check, (sum * 9 % 10))
	table.insert(check, -1)
end

function get_streams()
	-- Maximum number of items to place into the input
	local MAX_COUNT = 38

	-- Numbers sent to the TIS-100
	input = {}

	-- Summations expected to get back from the TIS-100
	output = {}

	-- Check digits expected to get back from the TIS-100
	check = {}

	-- How many items are in the input
	local count = 0

	while count < MAX_COUNT do
		-- Random sequence length
		local nextLen = math.random(1, 8)

		-- Update count
		count = count + nextLen + 1
		-- Bounds check
		if count > MAX_COUNT then
			-- Too big, reduce sequence length
			nextLen = MAX_COUNT - (count - nextLen - 1)

			-- Set count to max
			count = MAX_COUNT
		end

		-- Add sequences to the input, and luhn sum to output
		luhn(input, output, check, nextLen)
	end

	return {
		{ STREAM_INPUT, "IN.D", 1, input },
		{ STREAM_OUTPUT, "OUT.CHK", 0, check },
		{ STREAM_OUTPUT, "OUT.SUM", 2, output },
	}
end
-- stylua: ignore
function get_layout()
  return { 
    TILE_COMPUTE,   TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    TILE_COMPUTE,   TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
    TILE_COMPUTE,   TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
  }
end
