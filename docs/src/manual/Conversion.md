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
 PVector(0.6389443475740613 m, 0.44709006743714474 m, 0.8206187491039008 m)        
 PVector(0.3281027103774252 m, 0.3802229116391327 m, 0.8588849154796518 m)
 PVector(0.6249940272414733 m, 0.19047258781660226 m, 0.6575298981932443 m) 

julia> p_Ball = [Ball() for i=1:3]
3-element Array{Ball{Int64},1}:
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 
0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg      
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 
0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg      
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 
0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg

julia> assign_points(p_Ball, :Pos, pu)

julia> p_Ball
3-element Array{Ball{Int64},1}:
 Ball 0: Pos = PVector(0.6389443475740613 m, 0.44709006743714474 m, 0.8206187491039008 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
 Ball 0: Pos = PVector(0.3281027103774252 m, 0.3802229116391327 m, 0.8588849154796518 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg 
 Ball 0: Pos = PVector(0.6249940272414733 m, 0.19047258781660226 m, 0.6575298981932443 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
```