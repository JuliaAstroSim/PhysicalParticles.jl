# m = match(r"^PVector\((-?\d+\.\d+) .*?, (-?\d+\.\d+) .*?, (-?\d+\.\d+) (.*?)\)", "PVector(1.23 m s^-1, 2.1 m s^-1, 3.4 m s^-1)")
# m = match(r"^PVector{([A-Za-z0-9]+)}\((-?\d+\.\d+), (-?\d+\.\d+), (-?\d+\.\d+)\)", "PVector{Float64}(1.23, 2.1, 3.4)")

function parse(::Type{PVector}, s::AbstractString; kw...)
    # Unitless 3D
    m = match(r"^PVector{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        #t = eval(Meta.parse(captures[1]))
        x = Meta.parse(captures[2])
        y = Meta.parse(captures[3])
        z = Meta.parse(captures[4])
        return PVector(x, y, z)
    end

    # Unitful 3D #TODO
    m = match(r"^PVector\((-?\d+\.\d+) .*?, (-?\d+\.\d+) .*?, (-?\d+\.\d+) (.*?)\)", s)
    if !isnothing(m)

    end

    return nothing
end

function parse(::Type{PVector2D}, s::AbstractString; kw...)
    # Unitless 2D
    m = match(r"^PVector2D{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        #t = eval(Meta.parse(captures[1]))
        x = Meta.parse(captures[2])
        y = Meta.parse(captures[3])
        return PVector2D(x, y)
    end

    # Unitful 2D #TODO

    return nothing
end