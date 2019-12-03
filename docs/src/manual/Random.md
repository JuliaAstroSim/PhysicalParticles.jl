# Random

Usage of random point generators is straightforward:
```julia
julia> p = rand_pvector(3)
3-element Array{PVector{Float64},1}:
 PVector{Float64}(0.899541890819791, 0.49609709458549345, 0.22817220536717397)
 PVector{Float64}(0.21907343513386301, 0.39110699072427035, 0.3502946880565312)
 PVector{Float64}(0.8107782153679699, 0.20218167820102884, 0.94236923352867)

julia> pu = rand_pvector(3, u"m")
3-element Array{PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}},1}:
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.6477898102542425 m, 0.4373299903072585 m, 0.7049677138795583 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.8651944634833202 m, 0.5480460857713867 m, 0.5620548650425954 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.28164175368241895 m, 0.1673360850328498 m, 0.31321825771349987 m)
```

Here is the list of supported generators:
```julia
rand_pvector(n::Integer)
rand_pvector(n::Integer, T::DataType)
rand_pvector(n::Integer, u::Unitful.Units)
rand_pvector(n::Integer, u::Unitful.Units, T::DataType)

rand_pvector2d(n::Integer)
rand_pvector2d(n::Integer, T::DataType)
rand_pvector2d(n::Integer, u::Unitful.Units)
rand_pvector2d(n::Integer, u::Unitful.Units, T::DataType)
```