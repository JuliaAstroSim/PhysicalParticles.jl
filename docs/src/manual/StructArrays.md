# StructArrays

`StructArray` provides a more efficient way to iterate on a field of particles:
```@repl guide
using PhysicalParticles
using StructArrays

sArray = [Star() for i in 1:5]
sStruct = StructArray(sArray)

sStruct.Mass[1] = 1000.0  # Easier to set properties, and even faster!

assign_particles(sStruct, :Pos, randn_pvector(5))

mean(sStruct.Pos)
```