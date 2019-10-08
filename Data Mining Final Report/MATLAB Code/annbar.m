x=[1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,2.00,2.00,2.00,2.00,2.00,2.00,2.00,2.00,2.00,3.00,3.00,3.00,3.00,3.00,3.00,3.00,3.00,3.00];
y=[1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9];
z=[67.80,67.50,66.84,67.08,67.77,68.24,67.54,67.55,66.52,66.62,68.15,70.81,71.97,71.45,73.02,73.76,73.20,73.86,54.39,54.39,54.39,54.14,62.08,67.23,70.00,69.31,71.65];
idxmax = find(z == max(z));
scatter3(x',y',z','filled')
tri = delaunay(x',y');
scatter(x',y','.')
[r,c] = size(tri);
disp(r)
h = trisurf(tri, x', y', z');
axis vis3d
hold on
%l = light('Position',[-50 -15 29])
%set(gca,'CameraPosition',[208 -50 7687])
%lighting phong
%shading interp
colorbar EastOutside
title('ANN')
xlabel('Hidden Layers')
ylabel('Hidden Nodes')
zlabel('% Accuracy')
plot3(2,7,73.76,'-s','MarkerFaceColor','red','MarkerSize',20)
hold off