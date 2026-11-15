clear; restoredefaultpath; rehash; close all;
dnameRepo = '~/git/muscnn';
addpath(fullfile(dnameRepo, 'code', 'lea'))
setuplea(struct(AddNsl=false, AddCnn=false))
addpath(fullfile(dnameRepo, 'code', 'matlab'))
TEMPLATE_DIR = '~/git/muscnn/data/templateflow/';
dn = '~/git/seunggookim.github.io/assets/img/blog/';

%%
meshes = sg.mri.readsurfaces('fsaverage', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
meshes = sg.mri.readsurfaces('fsaverage6', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
meshes = sg.mri.readsurfaces('fsaverage5', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsaverage6', Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('onavg-164k', Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsLR', Surface="veryveryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsLR', Surface="veryveryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes, [meshes.Curv])
%%
meshes = sg.mri.readsurfaces('fsaverage', Surface="inflated", TemplateDir=TEMPLATE_DIR, NumSmoothing=1000)
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsaverage6', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes, [meshes.Curv])
%%
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces("cvsavg35inMNI152", Surface="pial", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes, {meshes.Curv})
mniCoords = {meshes(1).Curv, meshes(2).Curv};
mappedValues = sg.mri.resamplesurfaces(mniCoords, 'cvsavg35inMNI152', 'fsaverage6', TemplateDir=TEMPLATE_DIR);
fsavg6Meshes = sg.mri.readsurfaces('fsaverage6', Surface="pial", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(fsavg6Meshes, mappedValues)
%%
mappedValues = sg.mri.resamplesurfaces(mniCoords, 'cvsavg35inMNI152', 'fsLR', TemplateDir=TEMPLATE_DIR);
fslrMeshes = sg.mri.readsurfaces('fsLR', Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(fslrMeshes, mappedValues)
%%
mappedValues = sg.mri.resamplesurfaces(mniCoords, 'cvsavg35inMNI152', 'fsaverage6', TemplateDir=TEMPLATE_DIR);
fsavg6Meshes = sg.mri.readsurfaces('fsaverage6', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(fsavg6Meshes, mappedValues)
%%
mappedValues = sg.mri.resamplesurfaces(mniCoords, 'cvsavg35inMNI152', 'fsaverage5', TemplateDir=TEMPLATE_DIR);
fsavg5Meshes = sg.mri.readsurfaces('fsaverage5', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(fsavg5Meshes, mappedValues)
%%
onavgMeshes = sg.mri.readsurfaces('onavg-164k', Surface="white", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes)
%%
mappedValues = sg.mri.resamplesurfaces(mniCoords, 'cvsavg35inMNI152', 'onavg-164k', TemplateDir=TEMPLATE_DIR);
onavgMeshes = sg.mri.readsurfaces('onavg-164k', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes, mappedValues)
%%
meshes = sg.mri.readsurfaces("cvsavg35inMNI152", Surface="inflated", TemplateDir=TEMPLATE_DIR);
mniCurv = {meshes.Curv};
opts = {'HistFontSize',3, 'ColorbarFontSize',4, 'Layout',"1x2", 'Colormap',brewermap(256, 'PiYG'), ...
  'FigurePosition', [1 1 225 110]};
sg.mri.viewsurfaces(meshes, mniCurv, opts{:}, ColorbarTitle="cvs-avg35-in-mni152:curv", ...
  FnamePng=[dn,'/surf-mni152.png']);

mappedValues = sg.mri.resamplesurfaces(mniCurv, 'cvsavg35inMNI152', 'onavg-164k', TemplateDir=TEMPLATE_DIR);
onavgMeshes = sg.mri.readsurfaces('onavg-164k', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes, mappedValues, opts{:}, ColorbarTitle="mni152-curvature:onavg-164k", ...
  FnamePng=[dn,'/surf-mni152_onavg164k.png']);

mappedValues = sg.mri.resamplesurfaces(mniCurv, 'cvsavg35inMNI152', 'fsaverage', TemplateDir=TEMPLATE_DIR);
onavgMeshes = sg.mri.readsurfaces('fsaverage', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes, mappedValues, opts{:}, ColorbarTitle="mni152-curv:fsvag-164k", ...
  FnamePng=[dn,'/surf-mni152_fsavg164k.png']);

mappedValues = sg.mri.resamplesurfaces(mniCurv, 'cvsavg35inMNI152', 'fsLR', TemplateDir=TEMPLATE_DIR);
onavgMeshes = sg.mri.readsurfaces('fsLR', Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes, mappedValues, opts{:}, ColorbarTitle="mni152-curv:fsLR-32k", ...
  FnamePng=[dn,'/surf-mni152_fslr32k.png']);

mappedValues = sg.mri.resamplesurfaces(mniCurv, 'cvsavg35inMNI152', 'fsaverage6', TemplateDir=TEMPLATE_DIR);
onavgMeshes = sg.mri.readsurfaces('fsaverage6', Surface="inflated", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(onavgMeshes, mappedValues, opts{:}, ColorbarTitle="mni152-curv:fsvag-10k", ...
  FnamePng=[dn,'/surf-mni152_fsavg41k.png']);

%%
fsavg = sg.mri.readsurfaces('fsaverage5', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg-10k',  Surface="midthickness", TemplateDir=TEMPLATE_DIR);
axes = sg.vis.layoutaxes([1 2],[0 0 0 0],[0 0 0 0]);

clf
set(gcf, Position=[1 1 1025 370])
sg.vis.placeaxes(axes, 1)
patch('Faces',fsavg(2).Faces , 'Vertices', fsavg(2).Vertices, FaceColor='w', EdgeColor='k');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 1)
text(.05,.1,'fsavg5-10k:mid-thickness'); axis off

sg.vis.placeaxes(axes, 2)
patch('Faces',onavg(2).Faces , 'Vertices', onavg(2).Vertices, FaceColor='w', EdgeColor='b');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 2)
text(.05,.1,['onavg-10k:mid-thickness']); axis off
exportgraphics(gcf, [dn,'/surf-fsavg-vs-onavg.png'])



%%
computeAreas = @(faces, vertices) vecnorm(cross(vertices(faces(:,2),:) - vertices(faces(:,1),:), vertices(faces(:,3),:) - vertices(faces(:,1),:), 2), 2, 2) / 2;

fsavg = sg.mri.readsurfaces('fsaverage', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
fsavgAreas = computeAreas(fsavg(2).Faces, fsavg(2).Vertices);

onavg = sg.mri.readsurfaces('onavg-164k',  Surface="midthickness", TemplateDir=TEMPLATE_DIR);
onavgAreas = computeAreas(onavg(2).Faces, onavg(2).Vertices);
axes = sg.vis.layoutaxes([1 2],[0 0 0 0],[0 0 0 0]);

fsavg = sg.mri.readsurfaces('fsaverage',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg-164k',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);

clf
set(gcf, Position=[1 1 1025 370])
sg.vis.placeaxes(axes, 1)
h = patch('Faces',fsavg(2).Faces, 'Vertices', fsavg(2).Vertices, FaceVertexCData=fsavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 .5])

sg.vis.placeaxes(axes, 2)
h = patch('Faces',onavg(2).Faces, 'Vertices', onavg(2).Vertices, FaceVertexCData=onavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 .5])

colormap(flipud(brewermap(256,'spectral')))
%%
computeAreas = @(faces, vertices) vecnorm(cross(vertices(faces(:,2),:) - vertices(faces(:,1),:), vertices(faces(:,3),:) - vertices(faces(:,1),:), 2), 2, 2) / 2;

fsavg = sg.mri.readsurfaces('fsaverage5', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
fsavgAreas = computeAreas(fsavg(2).Faces, fsavg(2).Vertices);

onavg = sg.mri.readsurfaces('onavg-10k',  Surface="midthickness", TemplateDir=TEMPLATE_DIR);
onavgAreas = computeAreas(onavg(2).Faces, onavg(2).Vertices);
axes = sg.vis.layoutaxes([1 2],[0 0 0 0],[0 0 0 0]);

fsavg = sg.mri.readsurfaces('fsaverage5',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg-10k',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);

clf
set(gcf, Position=[1 1 1025 370])
sg.vis.placeaxes(axes, 1)
h = patch('Faces',fsavg(2).Faces, 'Vertices', fsavg(2).Vertices, FaceVertexCData=fsavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 8])

sg.vis.placeaxes(axes, 2)
h = patch('Faces',onavg(2).Faces, 'Vertices', onavg(2).Vertices, FaceVertexCData=onavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 8])

colormap(flipud(brewermap(256,'spectral')))
%%
computeAreas = @(faces, vertices) ...
  vecnorm(cross(vertices(faces(:,2),:) - vertices(faces(:,1),:), vertices(faces(:,3),:) - vertices(faces(:,1),:), 2)...
  , 2, 2) / 2;

fsavg = sg.mri.readsurfaces('fsaverage6', Surface="pial", TemplateDir=TEMPLATE_DIR);
fsavgAreas = computeAreas(fsavg(2).Faces, fsavg(2).Vertices);

onavg = sg.mri.readsurfaces('onavg-41k',  Surface="pial", TemplateDir=TEMPLATE_DIR);
onavgAreas = computeAreas(onavg(2).Faces, onavg(2).Vertices);
axes = sg.vis.layoutaxes([1 2],[0 0 0 0],[0 0 0 0]);

fsavg = sg.mri.readsurfaces('fsaverage6',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg-41k',  Surface="veryinflated", TemplateDir=TEMPLATE_DIR);

clf
set(gcf, Position=[1 1 1025 370])
sg.vis.placeaxes(axes, 1)
h = patch('Faces',fsavg(2).Faces, 'Vertices', fsavg(2).Vertices, FaceVertexCData=fsavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 2])

sg.vis.placeaxes(axes, 2)
h = patch('Faces',onavg(2).Faces, 'Vertices', onavg(2).Vertices, FaceVertexCData=onavgAreas, ...
  FaceColor='flat', EdgeColor='none');
axis off image
view(90,0); clim([0 2])

colormap(flipud(brewermap(256,'spectral')))

%%
meshes = sg.mri.readsurfaces('cvsavg35inMNI152-137k', Surface="pial", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsLR', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('fsaverage', Surface="pial", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
meshes = sg.mri.readsurfaces('onavg-41k', Surface="pial", TemplateDir=TEMPLATE_DIR);
sg.mri.viewsurfaces(meshes)
%%
fsavg = sg.mri.readsurfaces('fsavg5', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
fslrsavg = sg.mri.readsurfaces('fsLR-10k', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg-10k',  Surface="midthickness", TemplateDir=TEMPLATE_DIR);
axes = sg.vis.layoutaxes([1 3],[0 0 0 0],[0 0 0 0]);

clf
set(gcf, Position=[1 1 1025 240])
sg.vis.placeaxes(axes, 1)
patch('Faces',fsavg(2).Faces , 'Vertices', fsavg(2).Vertices, FaceColor='w', EdgeColor='k');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 1)
text(.05,.1,'fsavg5-10k:midthck'); axis off

sg.vis.placeaxes(axes, 2)
patch('Faces',fslrsavg(2).Faces , 'Vertices', fslrsavg(2).Vertices, FaceColor='w', EdgeColor='k');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 2)
text(.05,.1,'fs\_LR-10k:midthck'); axis off

sg.vis.placeaxes(axes, 3)
patch('Faces',onavg(2).Faces , 'Vertices', onavg(2).Vertices, FaceColor='w', EdgeColor='k');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 3)
text(.05,.1,['onavg-10k:midthck']); axis off
exportgraphics(gcf, [dn,'/mesh-fsavg-fslr-onavg.png'])

%%
fsavg = sg.mri.readsurfaces('fsavg', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
fslrsavg = sg.mri.readsurfaces('fsLR', Surface="midthickness", TemplateDir=TEMPLATE_DIR);
onavg = sg.mri.readsurfaces('onavg',  Surface="midthickness", TemplateDir=TEMPLATE_DIR);
axes = sg.vis.layoutaxes([1 3],[0 0 0 0],[0 0 0 0]);

clf
set(gcf, Position=[1 1 1025 240])
sg.vis.placeaxes(axes, 1)
patch('Faces',fsavg(2).Faces , 'Vertices', fsavg(2).Vertices, FaceVertexCData=fsavg(2).Vertices(:,1), ...
  FaceColor='interp', EdgeColor='none');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 1)
text(.05,.1,'fsavg5-10k:midthck'); axis off

sg.vis.placeaxes(axes, 2)
patch('Faces',fslrsavg(2).Faces , 'Vertices', fslrsavg(2).Vertices, FaceVertexCData=fslrsavg(2).Vertices(:,1), ...
  FaceColor='interp', EdgeColor='none');
axis off image; view(90,0)
sg.vis.placeaxes(axes, 2)
text(.05,.1,'fs\_LR-32k:midthck'); axis off

sg.vis.placeaxes(axes, 3)
patch('Faces',onavg(2).Faces , 'Vertices', onavg(2).Vertices, FaceVertexCData=onavg(2).Vertices(:,1), ...
  FaceColor='interp', EdgeColor='none');
axis off image; view(90,0);
sg.vis.placeaxes(axes, 3)
text(.05,.1,['onavg-10k:midthck']); axis off

colormap(flipud(brewermap(256,'spectral')))
exportgraphics(gcf, [dn,'/surf-fsavg-fslr-onavg.png'])
