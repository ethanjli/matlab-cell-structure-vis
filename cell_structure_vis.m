%% Test data
vertices = [1, 0, 0, 0;...
         2, 0.3, 0, 0;...
         3, 0, 0.3, 0;...
         4, 0.3, 0.3, 0.1;...
         5, 0.6, 0.2, 0.4;...
         6, 0.2, 0.6, 0.4;...
         7, 0.5, 0.5, 0.4;...
         8, 1, 0.8, 0.8;...
         9, 0.8, 1, 0.8;...
         10, 0.7, 0.7, 0.8;...
         11, 1, 1, 1;...
         12, 0, 1, 0;...
         13, 0, 0, 1;...
         14, 0, 1, 1;...
         15, 1, 0, 1;...
         16, 1, 1, 0;...
         17, 1, 0, 0;];
springs = [1, 4, 0, 0.1;
         1, 2, 1, 0.05;
         1, 3, 1, 0.05;
         2, 5, 0, 0.1;
         2, 4, 1, 0.05;
         3, 4, 1, 0.05;
         3, 6, 0, 0.1;
         5, 7, 1, 0.05;
         6, 7, 1, 0.05;
         4, 7, 0, 0.1;
         8, 10, 1, 0.05;
         9, 10, 1, 0.05;
         5, 8, 0, 0.1;
         6, 9, 0, 0.1;
         7, 10, 0, 0.1;
         8, 11, 1, 0.05;
         9, 11, 1, 0.05;
         10, 11, 0, 0.1];
     
%% File reading

%% Parameters used for parsing simulation data
SPRING_TYPE_COLUMN = 3;
GLYCAN_INDICATOR = 0;
PEPTIDE_INDICATOR = 1;

%% Processing of simulation data for display
glycans = springs(springs(:,SPRING_TYPE_COLUMN) == GLYCAN_INDICATOR,:);
peptides = springs(springs(:,SPRING_TYPE_COLUMN) == PEPTIDE_INDICATOR,:);
connected_vertices_indices = unique(springs(:,1:2));
connected_vertices = vertices(ismember(vertices(:,1), connected_vertices_indices),:);
floating_vertices = vertices(~ismember(vertices(:,1), connected_vertices_indices),:);

%% Display of simulation data
display = figure;
hold on;
% Draw vertices
scatter3(connected_vertices(:,2), connected_vertices(:,3), connected_vertices(:,4), 'black', 'fill');
scatter3(floating_vertices(:,2), floating_vertices(:,3), floating_vertices(:,4), 'black');
%{
% Draw springs
gplot23D(glycan, vertices, 'green', 'LineWidth', 5);
gplot23D(peptide, vertices, 'blue', 'LineWidth', 2);
%}
xlabel('x');
ylabel('y');
zlabel('z');
xlim([0, 1]);
ylim([0, 1]);
zlim([0, 1]);
saveas(display, 'cell_structure_vis', 'fig');
hold off;