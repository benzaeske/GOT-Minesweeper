%Max Alger-Meyer 105813822 1320-104 Fleming
%Ben Zaeske 105928422 1320-104 Fleming
%Game of Thrones Skeleton

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Welcome user to the game
disp('Welcome to the GAME OF THRONES');

%Ask for their name and store it in a variable called playerName
playerName=input('State your name, Your Grace: ');

%Initialize a logical called playAgain and set it to 1
playAgain=1;

%Initialize a variable called restartCondition and set it to 0 (0 means
%they haven't played yet, 1 means they want to try again with the same
%board layout, 2 means they want to play again with a different board 
%size.)

restartCondition=0;

%Ask the user for the size of the board, and assign their response to the
%variable name boardSize.


fprintf('How vast is your kingdom %s, Your Grace? ', playerName);
boardSize = input('Enter an integer for the size of the board (numbers above 1): ');

%Make sure the board size is acceptable

while boardSize <= 1
    
    boardSize=input('That board size is too small, please enter another value (numbers above 1 please): ');

end

%Use the functions generateBoardView and generateBoardModel to initialize
%the board view and model(the boardView is what the user sees as they play
%the game, and boardModel is the actual array containing the information of
%the locations of kings, etc.)
        
boardView=generateBoardView(boardSize);
boardModel=generateBoardModel(boardSize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Loop that runs individual games
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create a while loop that keeps running as long as the user wants to keep
%playing

while playAgain == 1
    
    %restartCondition==2 means that the user has requested to play again 
    %on a different board size, so the script asks the user for a new board
    %size.
    
    if  restartCondition == 2
        
        fprintf('How vast is your kingdom %s, Your Grace? ', playerName);
        boardSize=input('Enter an integer for the size of the board (numbers above 1): ');
        
        %Make sure the board size is acceptable

        while boardSize <= 1
    
            boardSize=input('That board size is too small, please enter another value (numbers above 1 please): ');

        end
        
        %Initialize new view and model
        
        boardView = generateBoardView(boardSize);
        boardModel = generateBoardModel(boardSize);
       
    %restartCondition==1 means the user wants to play again on the same
    %board size, so update the view but keep the model the same.
        
    elseif restartCondition == 1
        
        boardView=generateBoardView(boardSize);

    end     
    
    %Initialize the number of kings based on the board size (number of
    %towns/6)

    numberKings=uint16(boardSize*boardSize/6);
    
    %remaining kings and remaining knights are variables that track the
    %number of remaining kings and knights as the game progresses. Both are
    %initialized to equal the initial number of kings on the initial board.
    
    remainingKings=numberKings;
    remainingKnights=numberKings;
    
    %player wins is a logical that is 0 if the player hasn't won yet, but 1
    %if the player has won.
    
    playerWins=0;
    
    %numberMoves is a counter that keeps track of the number of moves for
    %the purpose of keeping track of the number of moves that the player takes
    %to finish the game.
    
    numberMoves=0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Loop that runs turns in the current game
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Create a while loop that runs if the player hasn't run out of knights
    %or if there are kings on the board.
    
    while remainingKings > 0 && remainingKnights>0
        
        %Display to the user their remaining resources and the current
        %state of the board. 
        
        fprintf('%s, Your Grace, You have %.0f knights left to defeat %.0f kings. \n',...
            playerName, remainingKnights, remainingKings); 
        
        cellplot(boardView);
        
        %Ask the user for their desired coordinates for their next move,
        %and set both the column and row that they request to the variables
        %row and col (add +1 to each to adjust for the row and column
        %markers in the boards display).
        
        row = input('Please enter the row of your next move: ')+1;
        
        while row-1 < 1 || row-1 > boardSize
           row = input('Invalid index, please enter a number between 1 and the kingdom size (inclusive): ') + 1; 
        end
        
        col=input('Please enter the column of your next move: ')+1;
        
        while col-1 < 1 || col-1 > boardSize
           col = input('Invalid index, please enter a number between 1 and the kingdom size (inclusive): ') + 1; 
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Dealing with the player's next move
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %If the player hasn't made a move at their desired location,
        %proceed. 
        
        if cell2mat(boardView(row,col)) == '.'
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
            %If the player hits a king
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if cell2mat(boardModel(row,col)) == '*' 
                
                %Update the boardView to show the king that the player hit.
                
                boardView(row,col )= {'*'};
                
                %Decrease the number of remaining kings by 1.
                
                remainingKings=remainingKings - 1;
                remainingKnights = remainingKnights + 2;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %If the player hits the Dragon Queen
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            elseif cell2mat(boardModel(row,col)) == 'D'
                
                %Update the boardView to show the Dragon Queen that the player hit.

                boardView(row,col) = {'D'};
                
                %Present the user with a choice
                
                decision=input('You have encountered the mother of Dragons, would you like to swear allegiance? (Y/N): ');
                
                %Make sure the user enters a valid response.
                
                while decision~= 'Y' && decision ~= 'N' 
                    
                    decision=input('You have encountered the mother of Dragons, would you like to swear allegiance? (Y/N): ');
                    
                end 
                
                %If the user swears allegiance, tell them their army has
                %been increased by 5 and increase remainingKnights by 5.
                
                if strcmp(decision,'Y')
                    
                    disp('Your army has increased by 5 knights');
                    
                    remainingKnights = remainingKnights+5;
                    
                %Otherwise remove all of their remaining knights and notify
                %them that they have lost. 
                    
                else
                    
                    remainingKnights=0;
                    
                    disp('Your army has been destroyed in blood and fire');
                    
                end 

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %If the player does not hit a king or the Dragon Queen
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            else
                
                %Update view to show number of near kings using the
                %revealNearbyKings function.
                
                boardView = revealNearbyKings(row, col, boardView, boardModel);
                
                % subtract one from remainingKnights:
                remainingKnights = remainingKnights - 1;
                
            end
            
            % Add 1 to the number of moves:
            numberMoves = numberMoves + 1;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % At the end of each turn check if the user has won:
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %If the remaining kings is 0, the user has won. 
        
        if remainingKings==0
            
            %Set playerWins to 1 and notify the user that they have won the
            %game. Tell them the number of remaining knights and the number
            %of moves that it took them to finish.
            
            playerWins=1;
            
            fprintf('Congradulations %s, Your Grace! You have %.0f knights left, and you defeated all %.0f Kings in %.0f moves.\n',...
                playerName, remainingKnights, numberKings, numberMoves);
            
            %Write the entire board model over the visible board
            
            for row = 2:length(boardModel)
                for col = 2: length(boardModel)
                    boardView(row,col) = boardModel(row,col);
                end
            end
            
            %plot the entire board with all tiles visible 

            cellplot(boardView);
            
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %What to do at the end of each game
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %If the player has won add their game to the results text file and ask
    %them if they would like to play again:
    
    if playerWins==1
        
        %If the file already exists, append the results:
        
        if exist('benmax_zaeskealgermeyer_results.txt', 'file')
    
            fileID = fopen('benmax_zaeskealgermeyer_results.txt', 'a');
            fprintf(fileID, '%10s\t%10.0f\t%12.0f\n', playerName, numberMoves, boardSize);
    
        %If the file doesn't exist yet, create it with the proper header
        %and add the results of the game:
        else
    
            fileID = fopen('benmax_zaeskealgermeyer_results.txt', 'w');
            fprintf(fileID, '%10s\t%10s\t%12s\n%10s\t%10s\t%12s\n', 'Name', 'Score', 'Board Size', '----', '-----', '----------');
            fprintf(fileID, '%10s\t%10.0f\t%12.0f\n', playerName, numberMoves, boardSize);
    
        end
        
        %Ask the user if they want to play again:
        
        newGame=input('Would you like to play again, Your Grace? (Y/N): ');
    
        %Make sure the user enters a valid response.
    
        while newGame ~= 'Y' && newGame ~= 'N'
        
            newGame=input('Would you like to play again, Your Grace? (Y/N): ');
            
        end
       
        %If they do not, set playAgain to 0 which will end the while loop and
        %end the program. Otherwise the program repeats because playAgain is
        %still 1. 
    
        if newGame == 'N'

            playAgain = 0;
            
        else
            
            restartCondition = 2;
        
        end
    
        %If the player has lost, first ask if they want to play again on
        %the same board, if not, ask if they want to play again on a
        %different board.
        
    else 
        
        restart = input('Sorry for your loss, would you like to play again on the same board? (Y/N): ');
                    
        %Make sure the user enters a valid response.
                    
        while restart ~= 'Y' && restart ~= 'N'
                        
              restart = input('Sorry for your loss, would you like to play again on the same board? (Y/N): ');
                          
        end 
                    
        %If 'Y', set restartCondition to 1.
                    
        if restart == 'Y'
                        
              restartCondition = 1;
              
        %If the user enters 'N', ask if they want to play again on a
        %different board.
              
        else 
                        
            newGame = input('Would you like to play again on a different board, Your Grace? (Y/N): ');
            
            %Make sure the user enters a valid response.
            
            while newGame ~= 'Y' && newGame ~= 'N'
                        
              newGame = input('Would you like to play again on a different board, Your Grace? (Y/N): ');
                          
            end  
            
            %If the user enters 'Y', set restartCondition to 2.
            
            if newGame == 'Y'
                
                restartCondition = 2;
                
            %Otherwise, set playAgain to 0.
                
            else 
                
                playAgain = 0;
                
            end
            
        end       
        
    end
    
end 

