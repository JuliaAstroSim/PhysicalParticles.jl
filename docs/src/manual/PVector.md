# PVector

All of the sub-types of `Number` and `Quantity` are supported. In general it works as we expected whereas there are too many possibilities to foresee. Mathematically vector operations, linear algebra, array conversions, neighbor searching, etc. are well documented in corresponding sections.

The vector types are immutable out of performance reason. 

## PVector and PVector2D

### Constructor

It is assumed that 3D vectors are used more often, so we choose `PVector` to represent 3D vectors and provide user-friendly functions to avoid errors in case you missed suffix `2D`:
```@repl pvector
using PhysicalParticles
PVector(1.0, 2.0)
PVector(2.0, 3.0, u"m")
```

The default constructors of `PVector` are still 3d-version:
```@repl pvector
PVector()
PVector(u"m")
```

### Basic Operators

Basic maths are well support by overriding `Base: +, -, *, /`, and array operations are supported by overriding `Base: length, iterate`

```@repl pvector
a = pconvert(ones(3))
b = pconvert(ones(3)) * 2
a + b
a * b
norm(a)
norm(a) == sqrt(3)
normalize(a)
normalize(a) == a / sqrt(3)
cross(a, b)
dot(a,b) == *(a,b)
c = pconvert(ones(3)) * 1.0u"m"
c * a
```

### More types, more possibilities

`T<:Number` gives us a whole world to try out new vector operations. As we mentioned above, the build-in type operation and promotion schemes have guaranteed most of operations would be correct:
```@repl pvector
a = PVector(1.0, 1.0, 1.0) * im
a * PVector(1, 2, 3)
norm(a)
b = PVector(1.0f0, 2.0f0)
b * 2
b * 2.0
PVector(BigFloat)
PVector2D(BigInt, u"m")
```

### LinearAlgebra

`norm`, `normalize`, `dot`, `cross` from `LinearAlgebra` module are overloaded.

However, when it comes to `Quantity`, some wierd things would happen:
```@repl pvector
using Unitful
sqrt(1.0u"km" * 1000.0u"m")
sqrt(upreferred(1.0u"km" * 1000.0u"m"))
1.0u"km" / sqrt(upreferred(1.0u"km" * 1.0u"km"))
```

To avoid this, we have to use `upreferred` in both `norm` and `normalize`:
```julia
@inline norm(p::PVector2D) = sqrt(upreferred(p * p))
@inline normalize(p::PVector2D) = (n = ustrip(norm(p)); return PVector2D(upreferred(p.x/n), upreferred(p.y/n)))

@inline norm(p::PVector) = sqrt(upreferred(p * p))
@inline normalize(p::PVector) = (n = ustrip(norm(p)); return PVector(upreferred(p.x/n), upreferred(p.y/n), upreferred(p.z/n)))
```

### uconvert, ustrip, zero, one

These would be useful when you cannot predict the type of input.

```@repl pvector
p = PVector(2.0, 2.0, 2.0, u"km")
uconvert(u"m", p)
ustrip(u"m", p)
ustrip(p)
one(u"m", p)
one(p)
zero(u"m", p)
zero(p)
```