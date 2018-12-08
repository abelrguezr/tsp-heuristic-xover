function NewChrom = xov_heuristic_low_level(Parents, Dist);
% Crossover with local heuristics for TSP
% as described in the paper by Vahdati1 et al. 
% "A New Approach to Solve Traveling Salesman Problem Using Genetic Algorithm
% Based on Heuristic Crossover and Mutation Operator "
% this crossover assumes that the path representation is used to represent
% TSP tours
%   Input:
%       - OldChrom: Matrix containing the parents. Each line corresponds to
%       one individual.
%         
%       - Dist: Matrix containing the distance between citiess.
%   Output:
%    	* NewChrom: Vector container the offspring after mating in adjacency form.
%
%
%   Function calling:
%   NewChrom = xov_heuristic_low_level(Parents, Dist)

    % Get chromosome length.
    CHROM_LENGTH = length(Parents(1,:));
    NewChrom=zeros(1,CHROM_LENGTH);

    % Get the parents    
    parentA = Parents(1,:);
    parentB = Parents(2,:);

    % Start by picking a random city
    current_city = datasample(parentA,1);
    indexA=find(parentA == current_city);
    indexB=find(parentB == current_city);
   
    % Initialize pointers to the selected city
    pa1=circshift(parentA,CHROM_LENGTH-indexA+1);
    pa2=fliplr(circshift(parentA,CHROM_LENGTH-indexA));
    pb1=circshift(parentB,CHROM_LENGTH-indexB+1);
    pb2=fliplr(circshift(parentB,CHROM_LENGTH-indexB));
    
       
    j=1;
    
    % Loop to define a tour. The loop will stop when the pointers vector are
    % empty, i.e., when all the cities have been visited
    while ~(isequal(pa1,pa2) && isempty(pa1))

        % Add the current city to the tour.
        NewChrom(1,j) = current_city;
        
        % Eliminate the city from the pointers vector
        pa1(pa1==current_city)=[];
        pa2(pa2==current_city)=[];
        pb1(pb1==current_city)=[];
        pb2(pb2==current_city)=[];
     
        % If pointer vector is empty, break the loop
        if(isempty(pa1))
            break;
        end    
        
        % Evaluate the next city in the tour between the candidates based
        % on distance to the current city. Lowest distance is preferred. If
        % there are various options with the same distance, a random
        % one is chosen.
        
        candidates=[pa1(1),pa2(1),pb1(1),pb2(1)];
        dist2city=arrayfun(@(x) Dist(current_city,x), candidates);
        index_best=datasample(find(dist2city == min(dist2city(:))),1);

        % Update the current city to be the value of the particular pointer.   
        switch index_best
            case 1
                current_city = pa1(1);
            case 2
                current_city = pa2(1);
            case 3
                current_city = pb1(1);
            case 4
                current_city = pb2(1);    
        end
                      
        j=j+1;
    end    
NewChrom=path2adj(NewChrom);
end
% End of function