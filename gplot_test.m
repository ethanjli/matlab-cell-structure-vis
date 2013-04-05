nodes = [0, 0, 0;...
         0.3, 0, 0;...
         0, 0.3, 0;...
         0.3, 0.3, 0.1;...
         0.6, 0.2, 0.4;...
         0.2, 0.6, 0.4;...
         0.5, 0.5, 0.4;...
         1, 0.8, 0.8;...
         0.8, 1, 0.8;...
         0.7, 0.7, 0.8;...
         1, 1, 1];

glycan = sparse(11, 11);
glycan(1,4) = 1; glycan(2, 5) = 1; glycan(3, 6) = 1;
glycan(4, 7) = 1; glycan(5, 8) = 1; glycan(6, 9) = 1;
glycan(7, 10) = 1;
glycan(10, 11) = 1;

peptide = sparse(11, 11);
peptide(1, 2) = 1; peptide(1, 3) = 1;
peptide(4, 2) = 1; peptide(4, 3) = 1;
peptide(7, 5) = 1; peptide(7, 6) = 1;
peptide(10, 8) = 1; peptide(10, 9) = 1;
peptide(11, 8) = 1; peptide(11, 9) = 1;

skeleton = figure;
hold on;
gplot23D(glycan, nodes, 'green', 'LineWidth', 5);
gplot23D(peptide, nodes, 'blue', 'LineWidth', 2);
xlabel('x');
ylabel('y');
zlabel('z');
xlim([0, 1]);
ylim([0, 1]);
zlim([0, 1]);
%saveas(skeleton, 'gplot_test_skeleton', 'fig');

hold off;