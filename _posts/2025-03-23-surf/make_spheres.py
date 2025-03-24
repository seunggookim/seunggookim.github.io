import numpy as np
import skimage.measure
import trimesh

def fun(X, Y, Z):
    return X**2 + Y**2 + Z**2 - 1  # Example function defining a sphere

# Marching Cubes
res = 0.1
r = 8
x = np.arange(-r, r + res, res)
y = np.arange(-r, r + res, res)
z = np.arange(-r, r + res, res)
X, Y, Z = np.meshgrid(x, y, z, indexing='ij')
volume = fun(X, Y, Z)
verts, faces, _, _ = skimage.measure.marching_cubes(volume, level=0, spacing=(res, res, res))

# Icosphere
def generate_icosphere(subdivisions=3):
    sphere = trimesh.creation.icosphere(subdivisions=subdivisions)
    return {'vertices': sphere.vertices, 'faces': sphere.faces}

icoSphere = generate_icosphere(3)

