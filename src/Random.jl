# Generate random distributed points and particles

function rand_pvector2d(n::Integer, T::DataType = Float64)
    return [pconvert(rand(T,2)) for i=1:n]
end

function rand_pvector(n::Integer, T::DataType = Float64)
    return [pconvert(rand(T,3)) for i=1:n]
end

function randn_pvector2d(n::Integer, T::DataType = Float64)
    return [pconvert(randn(T,2)) for i=1:n]
end

function randn_pvector(n::Integer, T::DataType = Float64)
    return [pconvert(randn(T,3)) for i=1:n]
end


# With Units

function rand_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(rand(T,2) * u) for i=1:n]
end

function rand_pvector(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(rand(T,3) * u) for i=1:n]
end

function randn_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(randn(T,2) * u) for i=1:n]
end

function randn_pvector(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(randn(T,3) * u) for i=1:n]
end


# Assign arrays

function assign_points(particles::Array{P, N} where P<:AbstractParticle where N, fn::Symbol, points::Array{P, N} where P<:AbstractPoint where N)
    len = length(particles)
    if len != length(points)
        @error "Length does not match!"
    end

    for i in 1:len
        @inbounds setfield!(particles[i], fn, points[i])
    end
end