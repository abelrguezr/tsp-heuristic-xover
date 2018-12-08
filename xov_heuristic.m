% Crossover with local heuristics for TSP
% as described in the paper by Vahdati1 et al. 
% "A New Approach to Solve Traveling Salesman Problem Using Genetic Algorithm
% Based on Heuristic Crossover and Mutation Operator "
% this crossover assumes that the ajacency representation is used to represent
% TSP tours
%
% This functions is based on xalt_edges.m and calls a low level function to
% perform recombination.
%
%
% Syntax:  NewChrom = xov_heuristic(OldChrom, XOVR, dist)
%
% Input parameters:
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%                (in any form, not necessarily real values).
%    XOVR      - Probability of recombination occurring between pairs
%                of individuals.
%    Dist      - Matrix containing the distances between cities
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mating, ready to be mutated and/or evaluated,
%                in the same format as OldChrom.
%

function NewChrom = xov_heuristic(OldChrom, XOVR,dist);

if nargin < 2, XOVR = NaN; end
   
[rows,cols]=size(OldChrom);
   
   maxrows=rows;
   if rem(rows,2)~=0
	   maxrows=maxrows-1;
   end
   
   for row=1:2:maxrows
	
     	% crossover of the two chromosomes
   	% results in 2 offsprings
	if rand<XOVR			% recombine with a given probability
		NewChrom(row,:) =xov_heuristic_low_level([adj2path(OldChrom(row,:));adj2path(OldChrom(row+1,:))],dist);
		NewChrom(row+1,:) =xov_heuristic_low_level([adj2path(OldChrom(row+1,:));adj2path(OldChrom(row,:))],dist);
	else
		NewChrom(row,:)=OldChrom(row,:);
		NewChrom(row+1,:)=OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end

   

% End of function
