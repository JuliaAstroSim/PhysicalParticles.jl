#####  Points and vectors  #####

function min_x(a::Array{T,1}) where T <: AbstractPoint
    min = a[1].x
    for p in a
        if min > p.x
            min = p.x
        end
    end
    return min
end

function min_y(a::Array{T,1}) where T <: AbstractPoint
    min = a[1].y
    for p in a
        if min > p.y
            min = p.y
        end
    end
    return min
end

function min_z(a::Array{T,1}) where T <: AbstractPoint3D
    min = a[1].z
    for p in a
        if min > p.z
            min = p.z
        end
    end
    return min
end

function max_x(a::Array{T,1}) where T <: AbstractPoint
    max = a[1].x
    for p in a
        if max < p.x
            max = p.x
        end
    end
    return max
end

function max_y(a::Array{T,1}) where T <: AbstractPoint
    max = a[1].y
    for p in a
        if max < p.y
            max = p.y
        end
    end
    return max
end

function max_z(a::Array{T,1}) where T <: AbstractPoint3D
    max = a[1].z
    for p in a
        if max < p.z
            max = p.z
        end
    end
    return max
end

function center_x(a::Array{T,1}) where T <: AbstractPoint
    left = min_x(a)
    right = max_x(a)
    return (left + right) / 2.0
end

function center_y(a::Array{T,1}) where T <: AbstractPoint
    left = min_y(a)
    right = max_y(a)
    return (left + right) / 2.0
end

function center_z(a::Array{T,1}) where T <: AbstractPoint3D
    left = min_z(a)
    right = max_z(a)
    return (left + right) / 2.0
end

function center(a::Array{T,1}) where T <: AbstractPoint2D
    x = center_x(a)
    y = center_y(a)
    return typeof(a[1])(x,y)
end

function center(a::Array{T,1}) where T <: AbstractPoint3D
    x = center_x(a)
    y = center_y(a)
    z = center_z(a)
    return typeof(a[1])(x,y,z)
end

#####  Particles  #####

function min_x(a::Array{T,1}) where T <: AbstractParticle
    min = a[1].Pos.x
    for p in a
        if min > p.Pos.x
            min = p.Pos.x
        end
    end
    return min
end

function min_y(a::Array{T,1}) where T <: AbstractParticle
    min = a[1].Pos.y
    for p in a
        if min > p.Pos.y
            min = p.Pos.y
        end
    end
    return min
end

function min_z(a::Array{T,1}) where T <: AbstractParticle3D
    min = a[1].Pos.z
    for p in a
        if min > p.Pos.z
            min = p.Pos.z
        end
    end
    return min
end

function max_x(a::Array{T,1}) where T <: AbstractParticle
    max = a[1].Pos.x
    for p in a
        if max < p.Pos.x
            max = p.Pos.x
        end
    end
    return max
end

function max_y(a::Array{T,1}) where T <: AbstractParticle
    max = a[1].Pos.y
    for p in a
        if max < p.Pos.y
            max = p.Pos.y
        end
    end
    return max
end

function max_z(a::Array{T,1}) where T <: AbstractParticle3D
    max = a[1].Pos.z
    for p in a
        if max < p.Pos.z
            max = p.Pos.z
        end
    end
    return max
end

function center_x(a::Array{T,1}) where T <: AbstractParticle
    left = min_x(a)
    right = max_x(a)
    return (left + right) / 2.0
end

function center_y(a::Array{T,1}) where T <: AbstractParticle
    left = min_y(a)
    right = max_y(a)
    return (left + right) / 2.0
end

function center_z(a::Array{T,1}) where T <: AbstractParticle3D
    left = min_z(a)
    right = max_z(a)
    return (left + right) / 2.0
end

function center(a::Array{T,1}) where T <: AbstractParticle2D
    x = center_x(a)
    y = center_y(a)
    return typeof(a[1].Pos)(x,y)
end

function center(a::Array{T,1}) where T <: AbstractParticle3D
    x = center_x(a)
    y = center_y(a)
    z = center_z(a)
    return typeof(a[1].Pos)(x,y,z)
end