function tools = toolbox_game()
    tools.hasWinner = @hasWinner;
    tools.bestMove = @bestMove;

    tools.verifyHoz = @horizontal;
    tools.verifyVert = @vertical;
    tools.verifyDiagonalPri = @diagonalPri;
    tools.verifyDiagonalSec = @diagonalSec;
    tools.verifyL1 = @L1;
    tools.verifyL2 = @L2;
    tools.verifyL3 = @L3;
    tools.verifyL4 = @L4;
    tools.verifyLD1 = @LD1;
    tools.verifyLD2 = @LD2;
    tools.verifyLD3 = @LD3;
    tools.verifyLD4 = @LD4;
    tools.verifyLD5 = @LD5;
    tools.verifyLD6 = @LD6;
    tools.verifyLD7 = @LD7;
    tools.verifyLD8 = @LD8;
end

%Verify Winner
function ans1 = hasWinner(mat)
    ans1 = 0; vector = zeros(1,16);
    
    res = horizontal(mat); vector(1,1) = res.winCounter;
    res = vertical(mat); vector(1,2) = res.winCounter;
    res = L1(mat); vector(1,3) = res.winCounter;
    res = L2(mat); vector(1,4) = res.winCounter;
    res = L3(mat); vector(1,5) = res.winCounter;
    res = L4(mat); vector(1,6) = res.winCounter;
    res = LD1(mat); vector(1,7) = res.winCounter;
    res = LD2(mat); vector(1,8) = res.winCounter;
    res = LD3(mat); vector(1,9) = res.winCounter;
    res = LD4(mat); vector(1,10) = res.winCounter;
    res = LD5(mat); vector(1,11) = res.winCounter;
    res = LD6(mat); vector(1,12) = res.winCounter;
    res = LD7(mat); vector(1,13) = res.winCounter;
    res = LD8(mat); vector(1,14) = res.winCounter;
    res = diagonalPri(mat); vector(1,15) = res.winCounter;
    res = diagonalSec(mat); vector(1,16) = res.winCounter;
    
    if sum(vector) ~= 0
        ans1 = 1;
    end
    
end

%Best NEXT Move
function ans2 = bestMove(mat, idPlayer)
    ans2 = zeros(6,7);
    idPlayerWin = 0;
    
    for player = 1 : 2
        for j = 1 : 7
            for i = 6 : -1 : 1
                if mat(i,j) == 0
                    mat(i,j) = player;
                    if hasWinner(mat) ~= 0
                        if idPlayer == player
                            ans2(i, j) = 1;
                            idPlayerWin = 1;
                        elseif idPlayer ~= player && idPlayerWin == 0
                            ans2(i, j) = 1;
                        end
                    end
                    mat(i,j) = 0;
                    break;
                end
            end
        end
    end
end

%Verify Horizontal
function ans3 = horizontal(mat)
    %Init answer
    ans3.map = zeros(6,7);
    ans3.win = -1;
    ans3.winCounter = 0;
    
    for i = 1:6 %For each row...
        for j = 1:4 %For each set of 4...
            %If equal, save.
            if mat(i, j) == mat(i, j + 1) && mat(i, j) == mat(i, j + 2) && mat(i, j) == mat(i, j + 3) && mat(i, j) ~= 0
                ans3.map(i,j) = 1;
                ans3.win = mat(j, i);
                ans3.winCounter = ans3.winCounter + 1;
                break;
            end   
        end
    end
   
end

%Verify Vertical
function ans4 = vertical(mat)
    %Init answer
    ans4.map = zeros(6,7);
    ans4.win = -1;
    ans4.winCounter = 0;
    
    for i = 1:7 %For each col...
        for j = 1:3 %For each set of 4...
            %If equal, save.
            if mat(j, i) == mat(j + 1, i) && mat(j, i) == mat(j + 2, i) && mat(j, i) == mat(j + 3, i) && mat(j, i) ~= 0
                ans4.map(j,i) = 1;
                ans4.win = mat(j, i);
                ans4.winCounter = ans4.winCounter + 1;
                break;
            end   
        end
    end
    
end

%Verify "Primary" Diagonal
function ans5 = diagonalPri(mat)
    %Init answer
    ans5.map = zeros(6,7);
    ans5.win = -1;
    ans5.winCounter = 0;
    
    %Verify all diagonals "primary"
    if mat(3, 1) == mat(4, 2) && mat(3, 1) == mat(5, 3) && mat(3, 1) == mat(6, 4) && mat(3, 1) ~= 0
        ans5.map(3,1) = 1;
        ans5.win = mat(3,1);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(1, 4) == mat(2, 5) && mat(1, 4) == mat(3, 6) && mat(1, 4) == mat(4, 7) && mat(1, 4) ~= 0
        ans5.map(1,4) = 1;
        ans5.win = mat(1,4);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(2, 1) == mat(3, 2) && mat(2, 1) == mat(4, 3) && mat(2, 1) == mat(5, 4) && mat(2, 1) ~= 0
        ans5.map(2,1) = 1;
        ans5.win = mat(2,1);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(3, 2) == mat(4, 3) && mat(3, 2) == mat(5, 4) && mat(3, 2) == mat(6, 5) && mat(3, 2) ~= 0
        ans5.map(3,2) = 1;
        ans5.win = mat(3,2);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(1, 3) == mat(2, 4) && mat(1, 3) == mat(3, 5) && mat(1, 3) == mat(4, 6) && mat(1, 3) ~= 0
        ans5.map(1,3) = 1;
        ans5.win = mat(1,3);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(2, 4) == mat(3, 5) && mat(2, 4) == mat(4, 6) && mat(2, 4) == mat(5, 7) && mat(2, 4) ~= 0
        ans5.map(2,4) = 1;
        ans5.win = mat(2,4);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(1, 2) == mat(2, 3) && mat(1, 2) == mat(3, 4) && mat(1, 2) == mat(4, 5) && mat(1, 2) ~= 0
        ans5.map(1,2) = 1;
        ans5.win = mat(1,2);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(2, 3) == mat(3, 4) && mat(2, 3) == mat(4, 5) && mat(2, 3) == mat(5, 6) && mat(2, 3) ~= 0
        ans5.map(2,3) = 1;
        ans5.win = mat(2,3);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(3, 4) == mat(4, 5) && mat(3, 4) == mat(5, 6) && mat(3, 4) == mat(6, 7) && mat(3, 4) ~= 0
        ans5.map(3,4) = 1;
        ans5.win = mat(3,4);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(1, 1) == mat(2, 2) && mat(1, 1) == mat(3, 3) && mat(1, 1) == mat(4, 4) && mat(1, 1) ~= 0
        ans5.map(1,1) = 1;
        ans5.win = mat(1,1);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(2, 2) == mat(3, 3) && mat(2, 2) == mat(4, 4) && mat(2, 2) == mat(5, 5) && mat(2, 2) ~= 0
        ans5.map(2,2) = 1;
        ans5.win = mat(2,2);
        ans5.winCounter = ans5.winCounter + 1;
    end
    
    if mat(3, 3) == mat(4, 4) && mat(3, 3) == mat(5, 5) && mat(3, 3) == mat(6, 6) && mat(3, 3) ~= 0
        ans5.map(3,3) = 1;
        ans5.win = mat(3,3);
        ans5.winCounter = ans5.winCounter + 1;
    end    
end

%Verify "Secondary" Diagonal
function ans6 = diagonalSec(mat)

    %Init answer
    ans6.map = zeros(6,7);
    ans6.win = -1;
    ans6.winCounter = 0;
    
    if mat(1, 4) == mat(2, 3) && mat(1, 4) == mat(3, 2) && mat(1, 4) == mat(4, 1) && mat(1, 4) ~= 0
        ans6.map(1,4) = 1;
        ans6.win = mat(1,4);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(3, 7) == mat(4, 6) && mat(3, 7) == mat(5, 5) && mat(3, 7) == mat(6, 4) && mat(3, 7) ~= 0
        ans6.map(3,7) = 1;
        ans6.win = mat(3,7);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(1, 5) == mat(2, 4) && mat(1, 5) == mat(3, 3) && mat(1, 5) == mat(4, 2) && mat(1, 5) ~= 0
        ans6.map(1,5) = 1;
        ans6.win = mat(1,5);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(2, 4) == mat(3, 3) && mat(2, 4) == mat(4, 2) && mat(2, 4) == mat(5, 1) && mat(2, 4) ~= 0
        ans6.map(2,4) = 1;
        ans6.win = mat(2,4);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(2, 7) == mat(3, 6) && mat(2, 7) == mat(4, 5) && mat(2, 7) == mat(5, 4) &&  mat(2, 7) ~= 0
        ans6.map(2,7) = 1;
        ans6.win = mat(2,7);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(3, 6) == mat(4, 5) && mat(3, 6) == mat(5, 4) && mat(3, 6) == mat(6, 3) &&  mat(3, 6) ~= 0
        ans6.map(3,6) = 1;
        ans6.win = mat(3,6);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(1, 6) == mat(2, 5) && mat(1, 6) == mat(3, 4) && mat(1, 6) == mat(4, 3) && mat(1, 6) ~= 0
        ans6.map(1,6) = 1;
        ans6.win = mat(1,6);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(2, 5) == mat(3, 4) && mat(2, 5) == mat(4, 3) && mat(2, 5) == mat(5, 2) && mat(2, 5) ~= 0
        ans6.map(2,5) = 1;
        ans6.win = mat(2,5);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(3, 4) == mat(4, 3) && mat(3, 4) == mat(5, 2) && mat(3, 4) == mat(6, 1) && mat(3, 4) ~= 0
        ans6.map(3,4) = 1;
        ans6.win = mat(3,4);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(1, 7) == mat(2, 6) && mat(1, 7) == mat(3, 5) && mat(1, 7) == mat(4, 4) && mat(1, 7) ~= 0
        ans6.map(1,7) = 1;
        ans6.win = mat(1,7);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(2, 6) == mat(3, 5) && mat(2, 6) == mat(4, 4) && mat(2, 6) == mat(5, 3) && mat(2, 6) ~= 0
        ans6.map(2,6) = 1;
        ans6.win = mat(2,6);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
    if mat(3, 5) == mat(4, 4) && mat(3, 5) == mat(5, 3) && mat(3, 5) == mat(6, 2) && mat(3, 5) ~= 0
        ans6.map(3,5) = 1;
        ans6.win = mat(3,5);
        ans6.winCounter = ans6.winCounter + 1;
    end
    
end

%Verify L
function ans7 = L1(mat)

    %Init answer
    ans7.map = zeros(6,7);
    ans7.win = -1;
    ans7.winCounter = 0;
    
    for i = 1 : 4
        for j = 1 : 6
            if mat(i, j) == mat(i + 1, j) && mat(i, j) == mat(i + 2, j) && (mat(i, j) == mat(i, j + 1) || mat(i, j) == mat(i + 2, j + 1)) && mat(i, j) ~= 0
                ans7.map(i,j) = 1;
                ans7.win = mat(i, j);
                ans7.winCounter = ans7.winCounter + 1;
            end
        end
    end
end

function ans8 = L2(mat)

    %Init answer
    ans8.map = zeros(6,7);
    ans8.win = -1;
    ans8.winCounter = 0;
    
    for i = 1 : 4
        for j = 2 : 7
            if mat(i, j) == mat(i + 1, j) && mat(i, j) == mat(i + 2, j) && (mat(i, j) == mat(i, j - 1) || mat(i, j) == mat(i + 2, j - 1)) && mat(i, j) ~= 0
                ans8.map(i,j) = 1;
                ans8.win = mat(i, j);
                ans8.winCounter = ans8.winCounter + 1;
            end
        end
    end
end

function ans9 = L3(mat)

    %Init answer
    ans9.map = zeros(6,7);
    ans9.win = -1;
    ans9.winCounter = 0;
    
    for i = 1 : 5
        for j = 1 : 5
            if mat(i, j) == mat(i , j + 1) && mat(i, j) == mat(i, j + 2) && (mat(i, j) == mat(i + 1, j) || mat(i, j) == mat(i + 1, j + 2)) && mat(i, j) ~= 0
                ans9.map(i,j) = 1;
                ans9.win = mat(i, j);
                ans9.winCounter = ans9.winCounter + 1;
            end
        end
    end
end

function ans10 = L4(mat)
    %Init answer
    ans10.map = zeros(6,7);
    ans10.win = -1;
    ans10.winCounter = 0;
    
    for i = 2 : 6
        for j = 1 : 5
            if mat(i, j) == mat(i , j + 1) && mat(i, j) == mat(i, j + 2) && (mat(i, j) == mat(i - 1, j) || mat(i, j) == mat(i - 1, j + 2)) && mat(i, j) ~= 0
                ans10.map(i,j) = 1;
                ans10.win = mat(i, j);
                ans10.winCounter = ans10.winCounter + 1;
            end
        end
    end
end

%Verify LD part 1 "Primary"
function ans11 = LD1(mat)
    
    %Init answer
    ans11.map = zeros(6,7);
    ans11.win = -1;
    ans11.winCounter = 0;
    
    for i = 1 : 4
        for j = 1 : 4
            if mat(i, j) == mat(i + 1, j + 1) && mat(i, j) == mat(i + 2, j + 2) && mat(i, j) == mat(i + 1, j + 3) && mat(i, j) ~= 0
                ans11.map(i,j) = 1;
                ans11.win = mat(i, j);
                ans11.winCounter = ans11.winCounter + 1;
            end
        end
    end
end

function ans12 = LD2(mat)
    
    %Init answer
    ans12.map = zeros(6,7);
    ans12.win = -1;
    ans12.winCounter = 0;
    
    for i = 1 : 3
        for j = 1 : 5
            if mat(i, j) == mat(i + 1, j + 1) && mat(i, j) == mat(i + 2, j + 2) && mat(i, j) == mat(i + 3, j + 1) && mat(i, j) ~= 0
                ans12.map(i,j) = 1;
                ans12.win = mat(i, j);
                ans12.winCounter = ans12.winCounter + 1;
            end
        end
    end
end

function ans13 = LD3(mat)
   
    %Init answer
    ans13.map = zeros(6,7);
    ans13.win = -1;
    ans13.winCounter = 0;
    
    for i = 2 : 4
        for j = 1 : 5
            if mat(i, j) == mat(i + 1, j + 1) && mat(i, j) == mat(i + 2, j + 2) && mat(i, j) == mat(i - 1, j + 1) && mat(i, j) ~= 0
                ans13.map(i,j) = 1;
                ans13.win = mat(i, j);
                ans13.winCounter = ans13.winCounter + 1;
            end
        end
    end
end

function ans14 = LD4(mat)
    %Init answer
    ans14.map = zeros(6,7);
    ans14.win = -1;
    ans14.winCounter = 0;
    
    for i = 1 : 4
        for j = 2 : 5
            if mat(i, j) == mat(i + 1, j + 1) && mat(i, j) == mat(i + 2, j + 2) && mat(i, j) == mat(i + 1, j - 1) && mat(i, j) ~= 0
                ans14.map(i,j) = 1;
                ans14.win = mat(i, j);
                ans14.winCounter = ans14.winCounter + 1;
            end
        end
    end
end

%Verify LD part 2 "Secondary"
function ans15 = LD5(mat)
    
    %Init answer
    ans15.map = zeros(6,7);
    ans15.win = -1;
    ans15.winCounter = 0;
    
    for i = 3 : 6
        for j = 2 : 5
            if mat(i, j) == mat(i - 1, j + 1) && mat(i, j) == mat(i - 2, j + 2) && mat(i, j) == mat(i - 1, j - 1) && mat(i, j) ~= 0
                ans15.map(i,j) = 1;
                ans15.win = mat(i, j);
                ans15.winCounter = ans15.winCounter + 1;
            end
        end
    end
end

function ans16 = LD6(mat)
    %Init answer
    ans16.map = zeros(6,7);
    ans16.win = -1;
    ans16.winCounter = 0;
    
    for i = 1 : 4
        for j = 3 : 6
            if mat(i, j) == mat(i + 1, j - 1) && mat(i, j) == mat(i + 2, j - 2) && mat(i, j) == mat(i + 1, j + 1) && mat(i, j) ~= 0
                ans16.map(i,j) = 1;
                ans16.win = mat(i, j);
                ans16.winCounter = ans16.winCounter + 1;
            end
        end
    end
end

function ans17 = LD7(mat)

    %Init answer
    ans17.map = zeros(6,7);
    ans17.win = -1;
    ans17.winCounter = 0;
    
    for i = 2 : 4
        for j = 3 : 6
            if mat(i, j) == mat(i + 1, j - 1) && mat(i, j) == mat(i + 2, j - 2) && mat(i, j) == mat(i - 1, j - 1) && mat(i, j) ~= 0
                ans17.map(i,j) = 1;
                ans17.win = mat(i, j);
                ans17.winCounter = ans17.winCounter + 1;
            end
        end
    end
end

function ans18 = LD8(mat)

    %Init answer
    ans18.map = zeros(6,7);
    ans18.win = -1;
    ans18.winCounter = 0;
    
    for i = 3 : 5
        for j = 1 : 5
            if mat(i, j) == mat(i - 1, j + 1) && mat(i, j) == mat(i - 2, j + 2) && mat(i, j) == mat(i + 1, j + 1) && mat(i, j) ~= 0
                ans18.map(i,j) = 1;
                ans18.win = mat(i, j);
                ans18.winCounter = ans18.winCounter + 1;
            end
        end
    end
end