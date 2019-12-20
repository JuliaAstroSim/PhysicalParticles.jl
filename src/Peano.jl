############      Peano-Hilbert       ###########
# Copied from GeometicalPredicates.jl and referred to Gadget2

# number of bits to use per dimension in calculating the peano-key
const peano_2D_bits = 31
const peano_3D_bits = 21

# implementing 3D scaleful Peano-Hilbert indexing
const quadrants_arr = [
  0, 7, 1, 6, 3, 4, 2, 5,
  7, 4, 6, 5, 0, 3, 1, 2,
  4, 3, 5, 2, 7, 0, 6, 1,
  3, 0, 2, 1, 4, 7, 5, 6,
  1, 0, 6, 7, 2, 3, 5, 4,
  0, 3, 7, 4, 1, 2, 6, 5,
  3, 2, 4, 5, 0, 1, 7, 6,
  2, 1, 5, 6, 3, 0, 4, 7,
  6, 1, 7, 0, 5, 2, 4, 3,
  1, 2, 0, 3, 6, 5, 7, 4,
  2, 5, 3, 4, 1, 6, 0, 7,
  5, 6, 4, 7, 2, 1, 3, 0,
  7, 6, 0, 1, 4, 5, 3, 2,
  6, 5, 1, 2, 7, 4, 0, 3,
  5, 4, 2, 3, 6, 7, 1, 0,
  4, 7, 3, 0, 5, 6, 2, 1,
  6, 7, 5, 4, 1, 0, 2, 3,
  7, 0, 4, 3, 6, 1, 5, 2,
  0, 1, 3, 2, 7, 6, 4, 5,
  1, 6, 2, 5, 0, 7, 3, 4,
  2, 3, 1, 0, 5, 4, 6, 7,
  3, 4, 0, 7, 2, 5, 1, 6,
  4, 5, 7, 6, 3, 2, 0, 1,
  5, 2, 6, 1, 4, 3, 7, 0]
quadrants(a::Int64, b::Int64, c::Int64, d::Int64) = (@inbounds x = quadrants_arr[1+a<<3+b<<2+c<<1+d]; x)
rotxmap_table = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 17, 18, 19, 16, 23, 20, 21, 22]
rotymap_table = [1, 2, 3, 0, 16, 17, 18, 19, 11, 8, 9, 10, 22, 23, 20, 21, 14, 15, 12, 13, 4, 5, 6, 7]
rotx_table = [3, 0, 0, 2, 2, 0, 0, 1]
roty_table = [0, 1, 1, 2, 2, 3, 3, 0]
sense_table = [-1, -1, -1, +1, +1, -1, -1, -1]

function peanokey(x::Int64, y::Int64; bits::Int64=peano_2D_bits)
    n = 1 << bits
    s = n >> 1; d = Int128(0)
    while true
        rx = (x & s) > 0
        ry = (y & s) > 0
        d += s * s * xor(3 * rx, ry)
        s = s >> 1
        (s == 0) && break
        if ry == 0
            if rx == 1
                x = n - 1 - x;
                y = n - 1 - y;
            end
            x, y = y, x
        end
    end
    return d
end

function peanokey(x::Int64, y::Int64, z::Int64; bits::Int64=peano_3D_bits)
    n = 1 << bits
    mask = 1 << (bits - 1)
    key = Int128(0)
    rotation = 0
    sense = 1
    for i in 1:bits
        bitx = (x & mask > 0) ? 1 : 0
        bity = (y & mask > 0) ? 1 : 0
        bitz = (z & mask > 0) ? 1 : 0

        quad = quadrants(rotation, bitx, bity, bitz)

        key <<= 3
        key += sense == 1 ? quad : 7-quad

        @inbounds rotx = rotx_table[quad+1]
        @inbounds roty = roty_table[quad+1]
        @inbounds sense *= sense_table[quad+1]

        while rotx > 0
            @inbounds rotation = rotxmap_table[rotation+1]
            rotx -= 1
        end

        while(roty > 0)
            @inbounds rotation = rotymap_table[rotation+1]
            roty -= 1
        end
        mask >>= 1
    end

    return key
end

function peanokey(p::PVector2D{T}, DomainFac::Float64, u::Units = u"kpc", bits::Int64=peano_3D_bits) where T<:Quantity
    peanokey(trunc(Int64, ustrip(Float64, u, p.x) * DomainFac),
             trunc(Int64, ustrip(Float64, u, p.y) * DomainFac), bits = bits)
end

function peanokey(p::PVector{T}, DomainFac::Float64, u::Units = u"kpc", bits::Int64=peano_3D_bits) where T<:Quantity
    peanokey(trunc(Int64, ustrip(Float64, u, p.x) * DomainFac),
             trunc(Int64, ustrip(Float64, u, p.y) * DomainFac),
             trunc(Int64, ustrip(Float64, u, p.z) * DomainFac), bits = bits)
end

# implementing scale-free Hilbert ordering. Real all about it here:
# http://doc.cgal.org/latest/Spatial_sorting/index.html

abstract type AbstractCoordinate end
mutable struct CoordinateX <: AbstractCoordinate end
mutable struct CoordinateY <: AbstractCoordinate end
mutable struct CoordinateZ <: AbstractCoordinate end
const coordinatex = CoordinateX()
const coordinatey = CoordinateY()
const coordinatez = CoordinateZ()
next2d(::CoordinateX) = coordinatey
next2d(::CoordinateY) = coordinatex
next3d(::CoordinateX) = coordinatey
next3d(::CoordinateY) = coordinatez
next3d(::CoordinateZ) = coordinatex
nextnext3d(::CoordinateX) = coordinatez
nextnext3d(::CoordinateY) = coordinatex
nextnext3d(::CoordinateZ) = coordinatey

abstract type AbstractDirection end
mutable struct Forward <: AbstractDirection end
mutable struct Backward <: AbstractDirection end
const forward = Forward()
const backward = Backward()
Base.:!(::Forward) = backward
Base.:!(::Backward) = forward

compare(::Forward, ::CoordinateX, p1::AbstractPoint, p2::AbstractPoint) = getx(p1) < getx(p2)
compare(::Backward, ::CoordinateX, p1::AbstractPoint, p2::AbstractPoint) = getx(p1) > getx(p2)
compare(::Forward, ::CoordinateY, p1::AbstractPoint, p2::AbstractPoint) = gety(p1) < gety(p2)
compare(::Backward, ::CoordinateY, p1::AbstractPoint, p2::AbstractPoint) = gety(p1) > gety(p2)
compare(::Forward, ::CoordinateZ, p1::AbstractPoint, p2::AbstractPoint) = getz(p1) < getz(p2)
compare(::Backward, ::CoordinateZ, p1::AbstractPoint, p2::AbstractPoint) = getz(p1) > getz(p2)

function select!(direction::AbstractDirection, coordinate::AbstractCoordinate, v::Array{T,1}, k::Int, lo::Int, hi::Int) where T<:AbstractPoint
    lo <= k <= hi || error("select index $k is out of range $lo:$hi")
    @inbounds while lo < hi
        if hi-lo == 1
            if compare(direction, coordinate, v[hi], v[lo])
                v[lo], v[hi] = v[hi], v[lo]
            end
            return v[k]
        end
        pivot = v[(lo+hi)>>>1]
        i, j = lo, hi
        while true
            while compare(direction, coordinate, v[i], pivot); i += 1; end
            while compare(direction, coordinate, pivot, v[j]); j -= 1; end
            i <= j || break
            v[i], v[j] = v[j], v[i]
            i += 1; j -= 1
        end
        if k <= j
            hi = j
        elseif i <= k
            lo = i
        else
            return pivot
        end
    end
    return v[lo]
end

function hilbertsort!(directionx::AbstractDirection, directiony::AbstractDirection, coordinate::AbstractCoordinate, a::Array{T,1}, lo::Int64, hi::Int64, lim::Int64=4) where T<:AbstractPoint2D
    hi-lo <= lim && return a

    i2 = (lo+hi)>>>1
    i1 = (lo+i2)>>>1
    i3 = (i2+hi)>>>1

    select!(directionx, coordinate, a, i2, lo, hi)
    select!(directiony, next2d(coordinate), a, i1, lo, i2)
    select!(!directiony, next2d(coordinate), a, i3, i2, hi)

    hilbertsort!(directiony, directionx, next2d(coordinate), a, lo, i1, lim)
    hilbertsort!(directionx, directiony, coordinate, a, i1, i2, lim)
    hilbertsort!(directionx, directiony, coordinate, a, i2, i3, lim)
    hilbertsort!(!directiony, !directionx, next2d(coordinate), a, i3, hi, lim)

    return a
end

function hilbertsort!(directionx::AbstractDirection, directiony::AbstractDirection, directionz::AbstractDirection, coordinate::AbstractCoordinate, a::Array{T,1}, lo::Int64, hi::Int64, lim::Int64=8) where T<:AbstractPoint3D
    hi-lo <= lim && return a

    i4 = (lo+hi)>>>1
    i2 = (lo+i4)>>>1
    i1 = (lo+i2)>>>1
    i3 = (i2+i4)>>>1
    i6 = (i4+hi)>>>1
    i5 = (i4+i6)>>>1
    i7 = (i6+hi)>>>1

    select!(directionx, coordinate, a, i4, lo, hi)
    select!(directiony, next3d(coordinate), a, i2, lo, i4)
    select!(directionz, nextnext3d(coordinate), a, i1, lo, i2)
    select!(!directionz, nextnext3d(coordinate), a, i3, i2, i4)
    select!(!directiony, next3d(coordinate), a, i6, i4, hi)
    select!(directionz, nextnext3d(coordinate), a, i5, i4, i6)
    select!(!directionz, nextnext3d(coordinate), a, i7, i6, hi)

    hilbertsort!( directionz,  directionx,  directiony, nextnext3d(coordinate), a, lo, i1, lim)
    hilbertsort!( directiony,  directionz,  directionx, next3d(coordinate),     a, i1, i2, lim)
    hilbertsort!( directiony,  directionz,  directionx, next3d(coordinate),     a, i2, i3, lim)
    hilbertsort!( directionx, !directiony, !directionz, coordinate,             a, i3, i4, lim)
    hilbertsort!( directionx, !directiony, !directionz, coordinate,             a, i4, i5, lim)
    hilbertsort!(!directiony,  directionz, !directionx, next3d(coordinate),     a, i5, i6, lim)
    hilbertsort!(!directiony,  directionz, !directionx, next3d(coordinate),     a, i6, i7, lim)
    hilbertsort!(!directionz, !directionx,  directiony, nextnext3d(coordinate), a, i7, hi, lim)

    return a
end

hilbertsort!(a::Array{T,1}) where {T<:AbstractPoint2D} = hilbertsort!(backward, backward, coordinatey, a, 1, length(a))
hilbertsort!(a::Array{T,1}, lo::Int64, hi::Int64, lim::Int64) where {T<:AbstractPoint2D} = hilbertsort!(backward, backward, coordinatey, a, lo, hi, lim)
hilbertsort!(a::Array{T,1}) where {T<:AbstractPoint3D} = hilbertsort!(backward, backward, backward, coordinatez, a, 1, length(a))
hilbertsort!(a::Array{T,1}, lo::Int64, hi::Int64, lim::Int64) where {T<:AbstractPoint3D} = hilbertsort!(backward, backward, backward, coordinatey, a, lo, hi, lim)

# multi-scale sort. Read all about it here:
# http://doc.cgal.org/latest/Spatial_sorting/classCGAL_1_1Multiscale__sort.html
function _mssort!(a::Array{T,1}, lim_ms::Int64, lim_hl::Int64, rat::Float64) where T<:AbstractPoint
    hi = length(a)
    lo = 1
    while true
        lo = hi - round(Int, (1-rat)*hi)
        hi-lo <= lim_ms && return a
        hilbertsort!(a, lo, hi, lim_hl)
        hi = lo-1
    end
    return a
end

# Utility methods, setting some different defaults for 2D and 3D. These are exported
mssort!(a::Array{T,1}; lim_ms::Int64=16, lim_hl::Int64=4, rat::Float64=0.25) where {T<:AbstractPoint2D} =
    _mssort!(a, lim_ms, lim_hl, rat)
mssort!(a::Array{T,1}; lim_ms::Int64=64, lim_hl::Int64=8, rat::Float64=0.125) where {T<:AbstractPoint3D} =
    _mssort!(a, lim_ms, lim_hl, rat)
