# Coordinate Transformations
"""
    cylinderial2cartesian(r::Number, θ::Number)

Convert Cylinderial Coordinates to `PVector2D`
"""
cylinderial2cartesian(r::Number, θ::Number) = PVector2D(r * cos(θ), r * sin(θ))

"""
    cylinderial2cartesian(r::Number, θ::Number, z::Number)

Convert Cylinderial Coordinates to `PVector`
"""
cylinderial2cartesian(r::Number, θ::Number, z::Number) = PVector(r * cos(θ), r * sin(θ), z)

"""
    spherical2cartesian(r::Number, θ::Number, ϕ::Number)

Convert Spherical Coordinates to `PVector`
"""
spherical2cartesian(r::Number, θ::Number, ϕ::Number) = PVector(r * sin(θ) * cos(ϕ), r * sin(θ) * sin(ϕ), r * cos(θ))

"""
cartesian2cylinderial(p::PVector2D)

Convert `PVector2D` to Cylinderial Coordinates. Returns Tuple(r, θ)
"""
function cartesian2cylinderial(p::PVector2D)
    r = norm(p)
    if iszero(r)
        return (r, 0.0)
    elseif ustrip(p.x) >= 0
        theta = asin(p.y / r)
    elseif ustrip(p.x) < 0
        theta = -asin(p.y / r) + pi
    end
    return (r, theta)
end

"""
    cartesian2cylinderial(p::PVector)

Convert `PVector` to Cylinderial Coordinates. Returns Tuple(r, θ, z)
"""
function cartesian2cylinderial(p::PVector)
    r = sqrt(p.x^2 + p.y^2)
    if iszero(r)
        return (r, 0.0, p.z)
    elseif ustrip(p.x) >= 0
        theta = asin(p.y / r)
    elseif ustrip(p.x) < 0
        theta = -asin(p.y / r) + pi
    end
    return (r, theta, p.z)
end

"""
    spherical2cylinderial(p::PVector)

Convert `PVector` to Spherical Coordinates. Returns Tuple(r, θ, ϕ)
"""
function spherical2cylinderial(p::PVector)
    r = norm(p)
    θ = acos(p.z / r)
    ϕ = atan(p.y / p.x)
    return r, θ, ϕ
end

function ()
    
end