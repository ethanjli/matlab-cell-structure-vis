function [Xout,Yout]=gplot23D(Adjacencies,Nodes,LineSpec,varargin)
%GPLOT Plot graph, as in "graph theory".
%   GPLOT(Adjacencies,Nodes) plots the graph specified by Adjacencies and Nodes. A graph, G, is
%   a set of nodes numbered from 1 to n, and a set of connections, or
%   edges, between them.
%
%   In order to plot G, two matrices are needed. The adjacency matrix,
%   Adjacencies, has Adjacencies(i,j) nonzero if and only if node i is connected to node
%   j.  The nodes array, Nodes, is an n-by-2 or n-by-3 matrix with the
%   position for node i in the i-th row, Nodes(i,:,:) = [x(i) y(i) z(i)].
%
%   GPLOT(Adjacencies,Nodes,LineSpec) uses line type and color specified in the
%   string LineSpec. See PLOT for possibilities.
%
%   [X,Y] = GPLOT(Adjacencies,Nodes) returns the NaN-punctuated vectors
%   X and Y without actually generating a plot. These vectors
%   can be used to generate the plot at a later time if desired.
%
%   See also SPY, TREEPLOT.

%   John Gilbert, 1991.
%   Modified 1-21-91, LS; 2-28-92, 6-16-92 CBM.
%   Modified April 2013, EL.
%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 5.12 $  $Date: 2002/04/15 04:13:43 $
%   Revised by G. De Marco, 2006
%   Revised by M. Catherall, 2006

[i, j] = find(Adjacencies);
[~, p] = sort(max(i,j));
i = i(p);
j = j(p);

% Create a long, NaN-separated list of line segments,
% rather than individual segments.
if size(Nodes, 2) < 3
    Nodes(:,3) = 0;
end
X = [Nodes(i,1), Nodes(j,1), NaN(size(i))]';
Y = [Nodes(i,2), Nodes(j,2), NaN(size(i))]';
Z = [Nodes(i,3), Nodes(j,3), NaN(size(i))]';
X = X(:);
Y = Y(:);
Z = Z(:);

% Create the line properties string
if nargout == 0,
    if nargin < 3
        h = plot3(X, Y, Z);
    else
        h = plot3(X, Y, Z, LineSpec);
    end
    view(2), box on
else
    Xout = X;
    Yout = Y;
end

if nargin > 2
    for k = 1:nargin-3
        s = varargin{k};
        try
            if isnumeric(varargin{k+1})
                set(h, s, varargin{k+1});
            else
                set(h, s);
            end
        catch
        end
        
    end
end
