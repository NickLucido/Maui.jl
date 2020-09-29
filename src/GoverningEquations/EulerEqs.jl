
struct EulerState{T} <: AbstractState
    ρ::T    # Density
    j::T    # Momentum Density
    E::T    # (Total) Energy Density
end # struct

my_f(x) = 2*x
