# m = match(r"^PVector\((-?\d+\.\d+) .*?, (-?\d+\.\d+) .*?, (-?\d+\.\d+) (.*?)\)", "PVector(1.23 m s^-1, 2.1 m s^-1, 3.4 m s^-1)")
# m = match(r"^PVector{([A-Za-z0-9]+)}\((-?\d+\.\d+), (-?\d+\.\d+), (-?\d+\.\d+)\)", "PVector{Float64}(1.23, 2.1, 3.4)")

"""
    function parse(::Type{PVector}, s::AbstractString; kw...)
    function parse(::Type{PVector2D}, s::AbstractString; kw...)

Parse a string to `PVector` and `PVector2D`. Unitful basic types are supported, for example, unitful Float32, unitless ComplexF64.
However, parsing unitful complex numbers is not supported, considering the too many possibilities.

## Examples
```julia
julia> parse(PVector, "PVector{Float32}(1.0f0, 2.0f0, 3.0f0)")
PVector{Float32}(1.0f0, 2.0f0, 3.0f0)

julia> parse(PVector2D, "PVector2D(1.0 m s^-1, 2.0 m s^-1)")
PVector2D(1.0 m s^-1, 2.0 m s^-1)

julia> parse(PVector2D, "PVector2D{ComplexF64}(0.0f0 + 1.0f0im, 0.0f0 + 2.0f0im)") == PVector2D(1.0f0im, 2.0f0im)
true

julia> parse(PVector2D, "PVector2D{ComplexF64}(0.0f0 + 1.0f0im, 0.0f0 + 2.0f0im)")
PVector2D{ComplexF32}(0.0f0 + 1.0f0im, 0.0f0 + 2.0f0im)

julia> parse(PVector2D, "PVector2D{ComplexF64}(1.0im, 2.0im)")
PVector2D{ComplexF64}(0.0 + 1.0im, 0.0 + 2.0im)
```
"""
function parse(::Type{PVector}, s::AbstractString; kw...)
    # Unitless 3D
    m = match(r"^PVector{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        #! Development notice:
        #! 1. Base.parse cannot be used to Float32
        #! 2. Meta.parse return an Expr for expressions like "1.0im"
        #! eval(Meta.parse(...)) would solve the problem
        x = eval(Meta.parse(captures[2]))
        y = eval(Meta.parse(captures[3]))
        z = eval(Meta.parse(captures[4]))
        return PVector(x, y, z)
    end

    # Complex 3D
    m = match(r"^PVector{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+), ([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+), ([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        x = eval(Meta.parse(captures[2]))
        y = eval(Meta.parse(captures[3]))
        z = eval(Meta.parse(captures[4]))
        return PVector(x, y, z)
    end

    # Unitful 3D
    m = match(r"^PVector\(([\-\+\.A-Za-z0-9\-\+]+) [\-\+\.A-Za-z0-9\-\+\^\ ]+, ([\-\+\.A-Za-z0-9\-\+]+) [\-\+\.A-Za-z0-9\-\+\^\ ]+, ([\-\+\.A-Za-z0-9\-\+]+) ([\-\+\.A-Za-z0-9\-\+\^\ ]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        x = Meta.parse(captures[1])
        y = Meta.parse(captures[2])
        z = Meta.parse(captures[3])
        u = uparse(join(split(captures[4], " "), "*"))
        return PVector(x*u, y*u, z*u)
    end

    return nothing
end

#=
m = match(r"^([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+)", "0.0 + 1.0im")
s = "PVector2D(0.0 m s^-1, 0.0 m s^-1)"
s = "PVector2D(0.0 m, 0.0 m)"
=#

function parse(::Type{PVector2D}, s::AbstractString; kw...)
    # Unitless 2D
    m = match(r"^PVector2D{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9\-\+]+), ([\-\+\.A-Za-z0-9\-\+]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        #! Development notice:
        #! 1. Base.parse cannot be used to Float32
        #! 2. Meta.parse return an Expr for expressions like "1.0im"
        #! eval(Meta.parse(...)) would solve the problem
        x = eval(Meta.parse(captures[2]))
        y = eval(Meta.parse(captures[3]))
        return PVector2D(x, y)
    end

    # Complex 2D
    m = match(r"^PVector2D{([A-Za-z0-9]+)}\(([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+), ([\-\+\.A-Za-z0-9 \-\+ \-\+\.A-Za-z0-9]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        x = eval(Meta.parse(string(captures[2])))
        y = eval(Meta.parse(string(captures[3])))
        return PVector2D(x, y)
    end

    # Unitful 2D
    m = match(r"^PVector2D\(([\-\+\.A-Za-z0-9\-\+]+) [\-\+\.A-Za-z0-9\-\+\^\ ]+, ([\-\+\.A-Za-z0-9\-\+]+) ([\-\+\.A-Za-z0-9\-\+\^\ ]+)\)", s)
    if !isnothing(m)
        captures = m.captures
        x = Meta.parse(captures[1])
        y = Meta.parse(captures[2])
        u = uparse(join(split(captures[3], " "), "*"))
        return PVector2D(x*u, y*u)
    end

    return nothing
end