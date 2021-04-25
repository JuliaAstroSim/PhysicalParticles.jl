using Makie
using Unitful, UnitfulAstro
using BenchmarkTools

using PhysicalParticles
using AstroIC

using LoopVectorization
using StructArrays
using ThreadsX
using Base.Threads

using DataFrames
using CSV
using Colors

using BenchmarkPlots


include("StructArrays.jl")



### StructArray

## summation
scene, layout, df = benchmarkplot(
    [
        SA_sum_sum,
        SA_sum_manual,
        SA_sum_ThreadsX,
        SA_sum_avxt,
        SA_sum_avx,
        SA_sum_sum_simple_avxt,
        SA_sum_sum_simple_avx,
    ],
    StructArrayDataGen,
    [10^i for i in 1:8];
    title = "Benchmark on $(Threads.nthreads()) threads",
)
Makie.save("StructArray sum Benchmark.png", scene)
mv("benchmark.csv", "SA_sum_benchmark.csv", force = true)


## SIMD
scene, layout, df = benchmarkplot(
    [
        SA_SIMD_check_single,
        SA_SIMD_check_single_inbound,
        SA_SIMD_check_ThreadsX,
        SA_SIMD_check_avxt,
    ],
    StructArrayDataGen,
    [10^i for i in 1:8];
    title = "Benchmark on $(Threads.nthreads()) threads",
)
Makie.save("StructArray SIMD Benchmark.png", scene)
mv("benchmark.csv", "SA_SIMD_benchmark.csv", force = true)