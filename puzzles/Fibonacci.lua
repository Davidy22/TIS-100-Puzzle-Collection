function get_name()
  return "FIBONACCI SEQUENCE"
end

function get_creator()
  return "Clem Davies"
end

function get_description()
  return { "READ IN INDEX",
           "CALCULATE FIBONACCI NUMBER AT INDEX",
           "OUTPUT NUMBER"}
end

function fib(count)
  if( count == 0 or count == 1 )
  then
    return count
  end
  return fib(count-1) + fib(count-2)
end

function get_streams()
  input = {}
  output = {}
  for i = 0,16 do
    input[i+1] = i
    output[i+1] = fib(i)
  end
  for i = 17,38 do
    n = math.random(0,16)
      input[i+1] = n
      output[i+1] = fib(n)
  end
  return {
    { STREAM_INPUT, "INDEX", 1, input },
    { STREAM_OUTPUT, "OUT", 2, output },
  }
end

function get_layout()
  return {
    TILE_COMPUTE,   TILE_COMPUTE,   TILE_COMPUTE,   TILE_COMPUTE,
    TILE_COMPUTE,   TILE_COMPUTE, TILE_COMPUTE,   TILE_COMPUTE,
    TILE_COMPUTE,   TILE_COMPUTE, TILE_COMPUTE,   TILE_COMPUTE,
  }
end
