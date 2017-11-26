function [ newBoardView ] = generateBoardView( boardSize )
%Generates a new board view of the size specified by boardSize.

%Initialize variables to keep track of board dimensions

length = boardSize + 1;

height = boardSize + 1;

%create an empty cell array

newBoardView = cell(length);

%Creat a nested for loop that will iterate through each index filling it
%with the appropriate character or row/column number.

for row = 1:height
    
    for col = 1:length
        
        if row == 1 && col == 1
            
            newBoardView(row,col) = {[]};
            
        elseif row == 1
            
            newBoardView(row,col) = {col-1};
            
        elseif col == 1
            
            newBoardView(row,col) = {row-1};
            
        else 
            
            newBoardView(row,col) = {'.'};
            
        end

    end
        
end
    
end

