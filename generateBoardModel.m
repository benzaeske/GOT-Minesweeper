%Max Alger-Meyer 105813822 1320-104 Fleming
%Ben Zaeske 105928422 1320-104 Fleming
%Function Stub

function [ newBoardModel ] = generateBoardModel( boardSize )

%Generates a new board model of the size specified by boardSize.

length = boardSize + 1;

height = boardSize + 1;

%create an empty cell array

newBoardModel = cell(length);

%determine the number of kings

numberKings = uint16(boardSize*boardSize/6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place the kings randomly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Run a for loop that generates random coordinates for each king

for i = 1:numberKings
    
    randomRowVal = randi([2 height]);
    randomColVal = randi([2 length]);
    
    %Check to make sure no duplicate kings are placed.
    
    while strcmp('*', newBoardModel(randomRowVal, randomColVal))
            
        randomRowVal = randi([2 height]);
        randomColVal = randi([2 length]);
            
    end
    
    %Place the king at the generated coordinates
    
    newBoardModel(randomRowVal, randomColVal) = {'*'};

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place the Dragon Queen randomly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Generate random index values for the Dragon Queen

randomRowVal = randi([2 height]);
randomColVal = randi([2 length]);

%Check that none of the coordinates are shared with a king

    while strcmp('*', newBoardModel(randomRowVal, randomColVal))
            
        randomRowVal = randi([2 height]);
        randomColVal = randi([2 length]);
            
    end
    
%Place the queen at the generated coordinates    

newBoardModel(randomRowVal, randomColVal) = {'D'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fill the remaining spaces with numbers representing nearby kings.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Go through all the indeces 

for row = 2:height
    
    for col = 2:length
        
        %Check to see if the space represented by row and col isn't a king 
        %or the Dragon Queen (This ensures that the kings and dragon queen 
        %are not written over with numbers):
        
        if ~strcmp(newBoardModel(row, col), '*') && ~strcmp(newBoardModel(row, col), 'D')
            
            % Create a counter variable for the number of surrounding
            % kings. Initial value = 0.
            
            adjKings = 0;
            
            %The following is a set of if statements that check to see if
            %the space is a corner, edge, or somewhere in the middle of the 
            %board. Once the location is determined, a for loop is created 
            %that checks the appropriate number of surrounding tiles for a 
            %king, and adds 1 to the variable adjKings for each king found.
            
            % Upper left corner:
            if row == 2 && col == 2
                
                for i = row:row+1
                    
                    for j = col:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Upper right corner:
            elseif row == 2 && col == length
                    
                for i = row:row+1
                    
                    for j = col-1:col
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Lower left corner:    
            elseif row == height && col == 2
                
             for i = row-1:row
                    
                    for j = col:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
             end
              
            % Lower right corner:   
            elseif row == height && col == length
                
                for i = row-1:row
                    
                    for j = col-1:col
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
             
            % Upper edge:
            elseif row == 2
                
                for i = row:row+1
                    
                    for j = col-1:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Left edge:
            elseif col == 2
                
                for i = row-1:row+1
                    
                    for j = col:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Lower edge:
            elseif row == height
                
                for i = row-1:row
                    
                    for j = col-1:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Right edge:
            elseif col == length
                
                for i = row-1:row+1
                    
                    for j = col-1:col
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
            
            % Not an edge or corner:
            else
                
                for i = row-1:row+1
                    
                    for j = col-1:col+1
                        
                        if strcmp(newBoardModel(i,j), '*')
                        
                            adjKings = adjKings + 1;
                            
                        end
                        
                    end
                    
                end
                
            end
            
            % Assign adjKings to the index specified by the current row and 
            % col.
            
            newBoardModel(row, col) = {adjKings};
            
        end
          
    end
    
end

end

