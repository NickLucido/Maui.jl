using Maui
#import gmsh

gmsh.initialize()
gmsh.option.setNumber("General.Terminal", 1) # Print to terminal if available

gmsh.model.add("simpleMesh")
# Constants
L  = 1    # Characteristic domain length
lc = 0.1 # Characteristic mesh length
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

# Make physical groups:
tbWall = gmsh.model.addPhysicalGroup(1, [L3, L4])# top/bottom walls
gmsh.model.addPhysicalGroup(2, [box])

gmsh.model.setPhysicalName(2, 6, "Domain")

gmsh.model.geo.synchronize()

gmsh.model.mesh.generate(2)

gmsh.write("simpleMesh.msh")

gmsh.finalize()
