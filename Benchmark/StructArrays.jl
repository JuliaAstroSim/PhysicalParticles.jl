# Summation

function StructArrayDataGen(N::Int)
    return StructArray(rand(PVector{Float64}, N) * u"m")
end

function SA_sum_sum(a::StructArray)
    return PVector(sum(a.x), sum(a.y), sum(a.z))
end

function SA_sum_manual(a::StructArray)
    out = zero(first(a))
    x = out.x
    y = out.y
    z = out.z
    for i in eachindex(a)
        @inbounds x += a.x[i]
        @inbounds y += a.y[i]
        @inbounds z += a.z[i]
    end
    return PVector(x,y,z)
end

function SA_sum_ThreadsX(a)
    return PVector(ThreadsX.sum(a.x), ThreadsX.sum(a.y), ThreadsX.sum(a.z))
end

function SA_sum_avxt(a)
    out = zero(first(a))
    x = out.x
    y = out.y
    z = out.z
    @avxt for i in eachindex(a)
        x += a.x[i]
        y += a.y[i]
        z += a.z[i]
    end
    return PVector(x,y,z)
end

function SA_sum_avx(a)
    out = zero(first(a))
    x = out.x
    y = out.y
    z = out.z
    @avx for i in eachindex(a)
        x += a.x[i]
        y += a.y[i]
        z += a.z[i]
    end
    return PVector(x,y,z)
end

function SA_sum_sum_simple_avxt(a::StructArray)
    return PVector(
        (@avxt sum(a.x)),
        (@avxt sum(a.y)),
        (@avxt sum(a.z)),
    )
end

function SA_sum_sum_simple_avx(a::StructArray)
    return PVector(
        (@avx sum(a.x)),
        (@avx sum(a.y)),
        (@avx sum(a.z)),
    )
end



# SIMD check
function SA_SIMD_check_single(a)
    out = 0
    for i in eachindex(a)
        out += a.x[i] > 0.5u"m"
    end
    out
end

function SA_SIMD_check_single_inbound(a)
    out = 0
    for i in eachindex(a)
        @inbounds out += a.x[i] > 0.5u"m"
    end
    out
end

function SA_SIMD_check_ThreadsX(a)
    ThreadsX.sum(i>0.5u"m" for i in a.x)
end

function SA_SIMD_check_avxt(a)
    out = 0
    @avxt for i in eachindex(a)
        out += ustrip(a.x[i]) > 0.5
    end
    out
end