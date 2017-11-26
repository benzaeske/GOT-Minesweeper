function [ newBoardView ] = revealNearbyKings(row, col, boardView, boardModel )
%revealNearbyKings returns a board view updated with information regarding
%nearby kings based on the players move (specified by row and col).

% Sets the function output equal to the most current boardView
newBoardView = boardView;

% Check to make sure the row and col in consideration hasn't been revealed
% yet, isn't a king in the model, and isn't the dragon queen in the model. 
%(In other words: it's a number)
if cell2mat(boardView(row, col)) == '.' && cell2mat(boardModel(row, col)) ~= '*' && cell2mat(boardModel(row, col)) ~= 'D'
    
    % Update the newBoardView to be equal to the boardModel at the row and
    % col specified by the function's inputs:
    newBoardView(row, col) = boardModel(row, col);
    
    % Check to see if the spot that was just updated is a 0
    if cell2mat(newBoardView(row, col)) == 0
        
        % Calculation of the board's dimension to make future if statement
        % conditions easier to read
        maxDimension = length(boardView);
        
        % The following is a set of if statements that check if the 8
        % surrounding indeces are within the bounds of the cell array, boardView. If
        % the new index in question is within the bounds of the cell array, 
        % this function is called recursively at that new index:
        
        if row - 1 > 1 && col - 1 > 1
            
            newBoardView = revealNearbyKings(row - 1, col - 1, newBoardView, boardModel);
            
        end
        
        if row - 1 > 1
            
            newBoardView = revealNearbyKings(row - 1, col, newBoardView, boardModel);
            
        end
        
        if col - 1 > 1
            
            newBoardView = revealNearbyKings(row, col - 1, newBoardView, boardModel);
            
        end
        
        if row + 1 <= maxDimension && col + 1 <= maxDimension
            
            newBoardView = revealNearbyKings(row + 1, col + 1, newBoardView, boardModel);
            
        end
        
        if row + 1 <= maxDimension
            
            newBoardView = revealNearbyKings(row + 1, col, newBoardView, boardModel);
            
        end
        
        if col + 1 <= maxDimension
            
            newBoardView = revealNearbyKings(row, col + 1, newBoardView, boardModel);
            
        end
        
        if row - 1 > 1 && col + 1 <= maxDimension
            
            newBoardView = revealNearbyKings(row - 1, col + 1, newBoardView, boardModel);
            
        end
        
        if row + 1 <= maxDimension && col - 1 > 1
            
            newBoardView = revealNearbyKings(row + 1, col - 1, newBoardView, boardModel);
            
        end 
        
    end
    
end

end

