module GoverningEquations

# Exports
export EulerState

export my_f
abstract type AbstractState end


# Euler Equations
include("EulerEqs.jl")

end
