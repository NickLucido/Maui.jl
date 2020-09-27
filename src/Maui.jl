module Maui

# This must be edited to work for unix vs. windows
if Sys.iswindows()
    path = Base.Filesystem.splitpath(@__DIR__)
    include(joinpath(path[1:end-2]..., "gmsh", "gmsh.jl"))
else
    using Gmsh
end

end
