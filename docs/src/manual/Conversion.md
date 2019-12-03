# Conversion

## Conversion from Arrays

`pconvert` is smart enough to handle 2D and 3D vectors at same time:
```julia
julia> pconvert([1.0, 2.0])
PVector2D{Float64}(1.0, 2.0)

julia> pconvert([1.0, 2.0, 3.0])
PVector{Float64}(1.0, 2.0, 3.0)

julia> pconvert([1.0, 2.0, 3.0, 4.0])
ERROR: Not supported dimension!


julia> a = pconvert([1.0 3.0; 
                      2.0 4.0])
2-element Array{PVector2D,1}:
 PVector2D{Float64}(1.0, 2.0)
 PVector2D{Float64}(3.0, 4.0)

julia> pconvert([1.0 4.0;
                  2.0 5.0;
                  3.0 6.0])
2-element Array{PVector,1}:
 PVector{Float64}(1.0, 2.0, 3.0)
 PVector{Float64}(4.0, 5.0, 6.0)
```

## Assign from Arrays

`assign_points` takes in three paremeters: `particles`, `symbol` and `points`. Assignment of `:Pos`, `:Vel` and `:Acc` is enough for simulation tasks:
```julia
julia> pu = rand_pvector(3, u"m")
3-element Array{PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}},1}:
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.6477898102542425 m, 0.4373299903072585 m, 0.7049677138795583 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.8651944634833202 m, 0.5480460857713867 m, 0.5620548650425954 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.28164175368241895 m, 0.1673360850328498 m, 0.31321825771349987 m)

julia> p_Ball = [Ball() for i=1:3]
3-element Array{Ball{Int64},1}:
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)

julia> assign_points(p_Ball, :Pos, pu)

julia> p_Ball
3-element Array{Ball{Int64},1}:
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.6477898102542425 m, 0.4373299903072585 m, 0.7049677138795583 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.8651944634833202 m, 0.5480460857713867 m, 0.5620548650425954 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.28164175368241895 m, 0.1673360850328498 m, 0.31321825771349987 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
```