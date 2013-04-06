function cell_structure_vis(vertices_filename, springs_filename)
% cell_structure_vis   Displays the components of a cell wall model
%   cell_structure_vis(vertices_filename, springs_filename) plots the 3D
%   structure given the filenames of the vertices file and springs file
%% Test data
%{
vertices = [0, 0, 0,       1;
            0.3, 0, 0,     2;
            0, 0.3, 0,     3;
            0.3, 0.3, 0.1, 4;
            0.6, 0.2, 0.4, 5;
            0.2, 0.6, 0.4, 6;
            0.5, 0.5, 0.4, 7;
            1, 0.8, 0.8,   8;
            0.8, 1, 0.8,   9;
            0.7, 0.7, 0.8, 10;
            1, 1, 1,       11;
            0, 1, 0,       12;
            0, 0, 1,       13;
            0, 1, 1,       14;
            1, 0, 1,       15;
            1, 1, 0,       16;
            1, 0, 0,       17];
springs = [1, 4,   0, 0.1,  0, 0, 0,       0.3, 0.3, 0.1;
           1, 2,   1, 0.05, 0, 0, 0,       0.3, 0, 0;
           1, 3,   1, 0.05, 0, 0, 0,       0, 0.3, 0;
           2, 5,   0, 0.1,  0.3, 0, 0,     0.6, 0.2, 0.4;
           2, 4,   1, 0.05, 0.3, 0, 0,     0.3, 0.3, 0.1;
           3, 4,   1, 0.05, 0, 0.3, 0,     0.3, 0.3, 0.1;
           3, 6,   0, 0.1,  0, 0.3, 0,     0.2, 0.6, 0.4;
           5, 7,   1, 0.05, 0.6, 0.2, 0.4, 0.5, 0.5, 0.4;
           6, 7,   1, 0.05, 0.2, 0.6, 0.4, 0.5, 0.5, 0.4;
           4, 7,   0, 0.1,  0.3, 0.3, 0.1, 0.5, 0.5, 0.4;
           8, 10,  1, 0.05, 1, 0.8, 0.8,   0.7, 0.7, 0.8;
           9, 10,  1, 0.05, 0.8, 1, 0.8,   0.7, 0.7, 0.8;
           5, 8,   0, 0.1,  0.6, 0.2, 0.4, 1, 0.8, 0.8;
           6, 9,   0, 0.1,  0.2, 0.6, 0.4, 0.8, 1, 0.8;
           7, 10,  0, 0.1,  0.5, 0.5, 0.4, 0.7, 0.7, 0.8;
           8, 11,  1, 0.05, 1, 0.8, 0.8,   1, 1, 1;
           9, 11,  1, 0.05, 0.8, 1, 0.8,   1, 1, 1;
           10, 11, 0, 0.1,  0.7, 0.7, 0.8, 1, 1, 1];
%}
     
%% File reading
vertices = dlmread(vertices_filename);
springs_file = fopen(springs_filename);
springs = cell2mat(textscan(springs_file, '%*c %f %f %*c %f %*s %f %f %*s %*d %*d %*d %*s %f %f %f %*s %f %f %f %*c %*f %*f %*f')); % only accepts data of the springs1.file sample file's format
fclose(springs_file);
%% Column numbers used for parsing simulation data
VERTEX_COLS = struct('X', 1, 'Y', 2, 'Z', 3, 'ID', 4);
SPRING_COLS = struct('VERTEX1', 1, 'VERTEX2', 2, 'TYPE', 3,...
                     'VERTEX1X', 6, 'VERTEX1Y', 7, 'VERTEX1Z', 8,...
                     'VERTEX2X', 9, 'VERTEX2Y', 10, 'VERTEX2Z', 11);
SPRING_TYPES = struct('GLYCAN', 0, 'PEPTIDE', 1);

%% Processing of simulation data for display
% Split springs into glycans and peptides
is_glycan = springs(:,SPRING_COLS.TYPE) == SPRING_TYPES.GLYCAN;
is_peptide = springs(:,SPRING_COLS.TYPE) == SPRING_TYPES.PEPTIDE;
glycans = springs(is_glycan,:);
peptides = springs(is_peptide,:);
% Generate lists of line segments for plotting
glycans_gaps = NaN(size(glycans, 1), 1);
peptides_gaps = NaN(size(peptides, 1), 1);
glycans_x = [glycans(:,[SPRING_COLS.VERTEX1X, SPRING_COLS.VERTEX2X]), glycans_gaps]';
glycans_y = [glycans(:,[SPRING_COLS.VERTEX1Y, SPRING_COLS.VERTEX2Y]), glycans_gaps]';
glycans_z = [glycans(:,[SPRING_COLS.VERTEX1Z, SPRING_COLS.VERTEX2Z]), glycans_gaps]';
peptides_x = [peptides(:,[SPRING_COLS.VERTEX1X, SPRING_COLS.VERTEX2X]), peptides_gaps]';
peptides_y = [peptides(:,[SPRING_COLS.VERTEX1Y, SPRING_COLS.VERTEX2Y]), peptides_gaps]';
peptides_z = [peptides(:,[SPRING_COLS.VERTEX1Z, SPRING_COLS.VERTEX2Z]), peptides_gaps]';
glycans_gapped = [glycans_x(:), glycans_y(:), glycans_z(:)];
peptides_gapped = [peptides_x(:), peptides_y(:), peptides_z(:)];

%% Display of simulation data
display = figure;
hold on;
% Draw vertices
scatter3(vertices(:,VERTEX_COLS.X), vertices(:,VERTEX_COLS.Y), vertices(:,VERTEX_COLS.Z),...
    '.k');
% Draw springs
plot3(glycans_gapped(:,1), glycans_gapped(:,2), glycans_gapped(:,3), 'green');
plot3(peptides_gapped(:,1), peptides_gapped(:,2), peptides_gapped(:,3), 'blue');
% Annotate display
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
view([15, 45]);
camroll(-90);
saveas(display, 'cell_structure_vis', 'fig');
hold off;

end