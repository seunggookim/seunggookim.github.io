clear
% sphere
fun = @(x, y, z) x.^2 + y.^2 + z.^2 - 1;

% 3-torus
% http://metamathological.blogspot.com/2013/01/today-i-learned-how-to-plot-doughnut.html
% fun = @(x, y, z) (x.^2 + (y - 2).^2 - 1) .* ((x - sqrt(3)).^2 + (y + 1).^2 - 1) .* ((x + sqrt(3)).^2 + (y + 1).^2 - 1) - 0.0015*(x.^2 + y.^2 + 7*z.^2).^5;

% 4-torus
%fun = @(x, y, z) ((x - 2).^2 + (y - 2).^2 - 1) .* ((x - 2).^2 + (y + 2).^2 - 1) .* ((x + 2).^2 + (y - 2).^2 - 1) .* ((x + 2).^2 + (y + 2).^2 - 1) - 0.02*(x.^2 + y.^2 + 7*z.^2).^5;

% marching cube:
res = 0.1;
r = 8;
x = -r:res:r;
y = -r:res:r;
z = -r:res:r;
[X, Y, Z] = meshgrid(x, y, z);
marchingSphere = isosurface(x ,y , z, fun(X,Y,Z), 0);

% icosphere:
icoSphere = struct();
[icoSphere.vertices, icoSphere.faces] = icosphere(3);

clf;
set(gcf, Position=[1000 1 510 521])
axes(Position=[0 0.5 0.5 .5])
p = patch(marchingSphere, FaceColor='interp', EdgeColor='none');
p.FaceVertexCData = marchingSphere.vertices(:,3);
view(3); axis image off

axes(Position=[0.5 0.5 0.5 .5])
p = patch(icoSphere, FaceColor='interp', EdgeColor='none');
p.FaceVertexCData = icoSphere.vertices(:,3);
view(3); axis image off

axes(Position=[0 0 0.5 .5])
p = patch(marchingSphere, FaceColor='interp', EdgeColor='k', LineStyle='-');
p.FaceVertexCData = marchingSphere.vertices(:,3);
view(3); axis image off; title('Marching cube', FontSize=20)

axes(Position=[0.5 0 0.5 .5])
p = patch(icoSphere, FaceColor='interp', EdgeColor='k', LineStyle='-');
p.FaceVertexCData = icoSphere.vertices(:,3);
view(3); axis image off; title('Divided icosahedron', FontSize=20)

% colormap(flipud(brewermap(256, 'RdYlBu')))
% colormap(flipud(brewermap(256, 'Spectral')))
colormap(parula)
exportgraphics(gcf, '../../assets/img/blog/surf-fig2.png')



%%
function [vv,ff] = icosphere(varargin)
%ICOSPHERE Generate icosphere.
% Create a unit geodesic sphere created by subdividing a regular
% icosahedron with normalised vertices.
%
%   [V,F] = ICOSPHERE(N) generates to matrices containing vertex and face
%   data so that patch('Faces',F,'Vertices',V) produces a unit icosphere
%   with N subdivisions.
%
%   FV = ICOSPHERE(N) generates an FV structure for using with patch.
%
%   ICOSPHERE(N) and just ICOSPHERE display the icosphere as a patch on the
%   current axes and does not return anything.
%
%   ICOSPHERE uses N = 3.
%
%   ICOSPHERE(AX,...) plots into AX instead of GCA.
%
%   See also SPHERE.
%
%   Based on C# code by Andres Kahler
%   http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html
%
%   Wil O.C. Ward 19/03/2015
%   University of Nottingham, UK
% Parse possible axes input
if nargin > 2
  error('Too many input variables, must be 0, 1 or 2.');
end
[cax,args,nargs] = axescheck(varargin{:});
n = 3; % default number of sub-divisions
if nargs > 0, n = args{1}; end % override based on input
% generate regular unit icosahedron (20 faced polyhedron)
[v,f] = icosahedron(); % size(v) = [12,3]; size(f) = [20,3];
% recursively subdivide triangle faces
for gen = 1:n
  f_ = zeros(size(f,1)*4,3);
  for i = 1:size(f,1) % for each triangle
    tri = f(i,:);
    % calculate mid points (add new points to v)
    [a,v] = getMidPoint(tri(1),tri(2),v);
    [b,v] = getMidPoint(tri(2),tri(3),v);
    [c,v] = getMidPoint(tri(3),tri(1),v);
    % generate new subdivision triangles
    nfc = [tri(1),a,c;
      tri(2),b,a;
      tri(3),c,b;
      a,b,c];
    % replace triangle with subdivision
    idx = 4*(i-1)+1:4*i;
    f_(idx,:) = nfc;
  end
  f = f_; % update
end
% remove duplicate vertices
[v,b,ix] = unique(v,'rows'); clear b % b dummy / compatibility
% reassign faces to trimmed vertex list and remove any duplicate faces
f = unique(ix(f),'rows');
switch(nargout)
  case 0 % no output
    cax = newplot(cax); % draw to given axis (or gca)
    showSphere(cax,f,v);
  case 1 % return fv structure for patch
    vv = struct('Vertices',v,'Faces',f,...
      'VertexNormals',v,'FaceVertexCData',v(:,3));
  case 2 % return vertices and faces
    vv = v; ff = f;
  otherwise
    error('Too many output variables, must be 0, 1 or 2.');
end
end

function [i,v] = getMidPoint(t1,t2,v)
%GETMIDPOINT calculates point between two vertices
%   Calculate new vertex in sub-division and normalise to unit length
%   then find or add it to v and return index
%
%   Wil O.C. Ward 19/03/2015
%   University of Nottingham, UK
% get vertice positions
p1 = v(t1,:); p2 = v(t2,:);
% calculate mid point (on unit sphere)
pm = (p1 + p2) ./ 2;
pm = pm./norm(pm);
% add to vertices list, return index
i = size(v,1) + 1;
v = [v;pm];
end
function [v,f] = icosahedron()
%ICOSAHEDRON creates unit regular icosahedron
%   Returns 12 vertex and 20 face values.
%
%   Wil O.C. Ward 19/03/2015
%   University of Nottingham, UK
t = (1+sqrt(5)) / 2;
% create vertices
v = [-1, t, 0; % v1
  1, t, 0; % v2
  -1,-t, 0; % v3
  1,-t, 0; % v4
  0,-1, t; % v5
  0, 1, t; % v6
  0,-1,-t; % v7
  0, 1,-t; % v8
  t, 0,-1; % v9
  t, 0, 1; % v10
  -t, 0,-1; % v11
  -t, 0, 1];% v12
% normalise vertices to unit size
v = v./norm(v(1,:));
% create faces
f = [ 1,12, 6; % f1
  1, 6, 2; % f2
  1, 2, 8; % f3
  1, 8,11; % f4
  1,11,12; % f5
  2, 6,10; % f6
  6,12, 5; % f7
  12,11, 3; % f8
  11, 8, 7; % f9
  8, 2, 9; % f10
  4,10, 5; % f11
  4, 5, 3; % f12
  4, 3, 7; % f13
  4, 7, 9; % f14
  4, 9,10; % f15
  5,10, 6; % f16
  3, 5,12; % f17
  7, 3,11; % f18
  9, 7, 8; % f19
  10, 9, 2];% f20
end
