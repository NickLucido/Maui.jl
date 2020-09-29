# Include gmsh
if Sys.iswindows()
    path = Base.Filesystem.splitpath(@__DIR__)
    include(joinpath(path[1:end-2]..., "Gmsh", "gmsh.jl"))
else
    import Gmsh: gmsh
end

gmsh.initialize()
gmsh.option.setNumber("General.Terminal", 1) # Print to terminal if available

gmsh.model.add("simpleMesh")
# Constants
L  = 1    # Domain length
lc = L/5.0 # Characteristic mesh length
#
# p4 -------------------------------- p3
# |                                   |
# |                                   |
# p1 -------------------------------- p2
#
# Create points
p1 = gmsh.model.geo.addPoint(0,   0, 0, lc)
p2 = gmsh.model.geo.addPoint(2*L, 0, 0, lc)
p3 = gmsh.model.geo.addPoint(2*L, L, 0, lc)
p4 = gmsh.model.geo.addPoint(0,   L, 0, lc)
# Create lines
L1 = gmsh.model.geo.addLine(p1, p2) # Bottom
L2 = gmsh.model.geo.addLine(p2, p3) # Right
L3 = gmsh.model.geo.addLine(p3, p4) # Top
L4 = gmsh.model.geo.addLine(p4, p1) # Left
# We need a curve loop to create the surface
box  = gmsh.model.geo.addCurveLoop([L4, L1, L2, L3])
surf = gmsh.model.geo.addPlaneSurface([box], 1)

# Make physical groups for demonstration:
tbWall = gmsh.model.addPhysicalGroup(1, [L3, L4])# top/bottom walls
domain = gmsh.model.addPhysicalGroup(2, [box])
# Name the physical groups
gmsh.model.setPhysicalName(1, tbWall, "Top/Bottom Walls")
gmsh.model.setPhysicalName(2, domain, "Domain")

# Create the mesh and write to file
gmsh.model.geo.synchronize()
gmsh.model.mesh.generate(2)
gmsh.write("simpleMesh.msh")


gmsh.finalize()
