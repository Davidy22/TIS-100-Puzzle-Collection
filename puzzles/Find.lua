function get_name()
    return "FIND"
end

function get_creator()
    return "Hersmunch"
end

function get_description()
    return { "SEQUENCES ARE ZERO-TERMINATED",
    "READ A SEQUENCE FROM IN.V",
    "READ VALUE TO FIND FROM IN.X",
    "LOOK UP VALUE IN SEQUENCE",
    "WRITE INDEX OF VALUE TO OUT, OR -1 IF THE VALUE IS NOT FOUND"}
end

function make_random_array(size, min, max)
    array = {}
    for i = 1, size do
        array[i] = math.random(min, max)
    end
    return array
end

function get_streams()
    for i = 1, 5 do
        math.random(0, 42)
    end

    input_v = make_random_array(10, 100, 999)
    input_v[11] = 0
    output = make_random_array(39, 0, 9)
    input_x = {}
    for i = 1, 39 do
        if math.random(0,9) == 0 then
            input_x[i] = math.random(100, 999)
        else
            input_x[i] = input_v[output[i]+1]
        end
        for j = 1, 10 do
            if input_v[j] == input_x[i] then
                output[i] = j-1
                break
            end
            output[i] = -1
        end
    end

    return {
        { STREAM_INPUT, "IN.X", 1, input_x },
        { STREAM_INPUT, "IN.V", 3, input_v },
        { STREAM_OUTPUT, "OUT", 1, output },
    }
end

function get_layout()
    return {
        TILE_JOURNAL, TILE_COMPUTE, TILE_MEMORY, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE,TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE,TILE_MEMORY, TILE_COMPUTE,
    }
end
