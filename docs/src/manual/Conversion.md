# Conversion

## Conversion from Arrays

`pconvert` is smart enough to handle 2D and 3D vectors at same time:
```@repl conversion
using PhysicalParticles
pconvert([1.0, 2.0])
pconvert([1.0, 2.0, 3.0])
pconvert([1.0, 2.0, 3.0, 4.0])
a = pconvert([1.0 3.0; 
              2.0 4.0])
pconvert([1.0 4.0;
          2.0 5.0;
          3.0 6.0])

```

## Assign from Arrays

`assign_particles` takes in three paremeters: `particles`, `symbol` and `points`. Assignment of `:Pos`, `:Vel` and `:Acc` is enough for simulation tasks:
```@repl conversion
pu = rand_pvector(3, u"m")
p_Ball = [Ball(uSI) for i=1:3]
assign_particles(p_Ball, :Pos, pu)
p_Ball
```