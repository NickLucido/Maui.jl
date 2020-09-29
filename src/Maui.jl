module Maui

export EulerState
export my_f

# Include files
include("GoverningEquations/GoverningEquations.jl")

# This must be edited to work for unix vs. windows
if Sys.iswindows()
    path = Base.Filesystem.splitpath(@__DIR__)
    include(joinpath(path[1:end-1]..., "gmsh", "gmsh.jl"))
else
    using Gmsh
end

using .GoverningEquations



end # module
