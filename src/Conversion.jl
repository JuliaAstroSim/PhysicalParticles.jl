# Conversions from and to array, conversions between inner types


"""
    pconvert(a::Array{T,1}) where T<:Number

convert two-element array to PVector2D, and three-element array to PVector

## Examples

```jl
julia> pconvert([1.0, 2.0])
PVector2D{Float64}(1.0, 2.0)

julia> pconvert([1.0, 2.0, 3.0])
PVector{Float64}(1.0, 2.0, 3.0)
```
"""
function pconvert(a::Array{T,1}) where T<:Number
    if length(a) == 3
        return PVector(a[1], a[2], a[3])
    elseif length(a) == 2
        return PVector2D(a[1], a[2])
    else
        error(a, "\n       Not supported dimension! Use 2D and 3D vectors")
    end
end

"""
    pconvert(a::Array{T,2}) where T<:Number

convert 2xN Array to Array{PVector2D,1}, 3xN Array to Array{PVector,1}

## Examples

```jl
julia> pconvert([1.0 3.0; 
                 2.0 4.0])
2-element Vector{PVector2D}:
 PVector2D{Float64}(1.0, 2.0)
 PVector2D{Float64}(3.0, 4.0)

julia> pconvert([1.0 4.0;
                 2.0 5.0;
                 3.0 6.0])
2-element Vector{PVector}:
 PVector{Float64}(1.0, 2.0, 3.0)
 PVector{Float64}(4.0, 5.0, 6.0)
```
"""
function pconvert(a::Array{T,2}) where T<:Number
    row, col = size(a)
    if row == 3
        return StructArray{PVector}((a[1,:], a[2,:], a[3,:]))
    elseif row == 2
        return StructArray{PVector2D}((a[1,:], a[2,:]))
    else
        error(a, "\n       Not supported dimension! Use 2D and 3D vectors")
    end
end

# Assign arrays

"""
    assign_particles(particles::Array{P,N} where P<:AbstractParticle, symbol::Symbol, data::Array) where N

Assign the symbol of `particles` with elements in `data` one by one. `particles` and `data` must have equal length.

## Examples
```jl
julia> assign_particles([Ball(uSI) for i=1:3], :Pos, rand_pvector(3, u"m"))
```
"""
function assign_particles(particles::Array{P,N} where P<:AbstractParticle, symbol::Symbol, data::Array) where N
    len = length(particles)
    if len != length(data)
        error("Length of particles (", len, ") and vectors (", length(data), ") does not match!")
    end

    for i in 1:len
        @inbounds particles[i] = setproperty!!(particles[i], symbol, data[i])
    end
end

function assign_particles(particles::StructArray, symbol::Symbol, data::Array)
    len = length(particles)
    if len != length(data)
        error("Length of particles (", len, ") and vectors (", length(data), ") does not match!")
    end

    a = getproperty(particles, symbol)
    for i in 1:len
        @inbounds a[i] = data[i]
    end
end

"""
    assign_particles(particles::Array{P,N} where P<:AbstractParticle, symbol::Symbol, data) where N
    assign_particles(particles::StructArray, symbol::Symbol, data)

Assign the symbol of `particles` to `data` identically.

# Examples
```jl
julia> assign_particles([Ball(uSI) for i=1:3], :Mass, 1.0u"kg")
```
"""
function assign_particles(particles::Array{P,N} where P<:AbstractParticle, symbol::Symbol, data) where N
    for i in eachindex(particles)
        @inbounds particles[i] = setproperty!!(particles[i], symbol, data)
    end
end

function assign_particles(particles::StructArray, symbol::Symbol, data)
    a = getproperty(particles, symbol)
    for i in eachindex(a)
        @inbounds a[i] = data
    end
end