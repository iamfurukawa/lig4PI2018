%Removendo todos os warnings!
warning('off','all'); warning;

%Limpando tudo!
clear; close all; clc;

%Carrega Libs!
tools_seg = toolbox_seg_channel();
tools_process = toolbox_pre_processing();
tools_game = toolbox_game();

%Variaveis!
    %Player!
player = 1;
    %Timer!
timer = 10;
    %Canais!
y_channel_r = 125; y_channel_g = 125; y_channel_b = 100;
b_channel_r = 150; b_channel_g = 200; b_channel_b = 150;
r_channel_r = 230; r_channel_g = 230; r_channel_b = 230;
    %bwareaopen e strel!
y_processing_bwr = 30;  y_processing_str = 5;
b_processing_bwr = 30;  b_processing_str = 10;
r_processing_bwr = 800; r_processing_str = 5;
    %Normal!
normal = 20;
    %Areas!
minArea = 1000;
maxArea = 10000;
    %Tabuleiros!
board = zeros(6,7);
tmp = zeros(6,7);
move = zeros(6,7);
    %Camera!
cam = webcam(2);

fprintf("Start!\n");
for ll = 1 : 10000    
    pause(timer);
    fprintf("Test: %d\n", ll);
    %Lê a img!
    img = snapshot(cam); %imread('Imagem4.jpg');

    %Separando a imagens por canais!
    redChannel = img(:, :, 1);
    greenChannel = img(:, :, 2);
    blueChannel = img(:, :, 3);

    %Segmenta a imagem por canais de cores!
    yChannel = tools_seg.seg_channel_yellow(img, y_channel_r, y_channel_g, y_channel_b);
    bChannel = tools_seg.seg_channel_blue(img, b_channel_r, b_channel_g, b_channel_b);
    rChannel = tools_seg.seg_channel_red(img, r_channel_r, r_channel_g, r_channel_b);

    %Faz um pré processamento para retirar impurezas!
    yChannel = tools_process.circles_processing(yChannel, y_processing_bwr, y_processing_str);
    bChannel = tools_process.circles_processing(bChannel, b_processing_bwr, b_processing_str);
    rChannel = tools_process.circles_processing(rChannel, r_processing_bwr, r_processing_str);

    %Junta todas as segmentações!
    allChannels = yChannel + bChannel + rChannel;

    %Exibindo cada sementação e a junção delas!
    %figure,
    %subplot(2,2,1),imshow(yChannel),    title('Yellow Channel');
    %subplot(2,2,2),imshow(bChannel),    title('Blue Channel');
    %subplot(2,2,3),imshow(rChannel),    title('Red Channel');
    %subplot(2,2,4),imshow(allChannels), title('All Channels');

    %Rotula esferas
    labels = bwlabel(allChannels, 8);
    props = regionprops(labels, 'Centroid', 'Area');
    
    %Ordena props!
    for i = 1 : (max(max(labels)) - 1)
        for j = (i + 1) : max(max(labels))
            if props(i).Centroid(1) > props(j).Centroid(1) || (props(i).Centroid(1) == props(j).Centroid(1) && props(i).Centroid(2) > props(j).Centroid(2))
                aux = props(i); props(i) = props(j); props(j) = aux;
            end
        end
    end
    base = -1;
    %Normaliza as posições em y!
    for i = 1 : (max(max(labels)))
        props(i).Centroid(1) = round(props(i).Centroid(1));
        %fprintf("Centroid : %d   Base : %d\n ",props(i).Centroid(1),base);      
       if(base > props(i).Centroid(1) + normal || base > props(i).Centroid(1) - normal)
           props(i).Centroid(1) = base;
       else
           base = props(i).Centroid(1);
       end
    end


    %Ordena props!
    for i = 1 : (max(max(labels)) - 1)
        for j = (i + 1) : max(max(labels))
            if props(i).Centroid(1) > props(j).Centroid(1) || (props(i).Centroid(1) == props(j).Centroid(1) && props(i).Centroid(2) > props(j).Centroid(2))
                aux = props(i); props(i) = props(j); props(j) = aux;
            end
        end
    end
    

    %Plota na imagem dados e monta tabuleiro!
    figure, imshow(allChannels);
    i = 1; x = 1; y = 1;
    for k = 1 : max(max(labels)) % insere os números dos rótulos nas regiões
        if props(k).Area > minArea && props(k).Area < maxArea
            text(props(k).Centroid(1), props(k).Centroid(2) - 15, num2str(i));
            text(props(k).Centroid(1) - 20, props(k).Centroid(2) + 15, num2str(props(k).Area));
            cent = round(props(k).Centroid);

            if x > 6
                x = 1; y = y+1;
            end

            if redChannel(cent(2), cent(1)) > 125 && greenChannel(cent(2), cent(1)) > 125 && blueChannel(cent(2), cent(1)) < 100
                board(x, y) = 2;
            elseif redChannel(cent(2), cent(1)) < 150 && greenChannel(cent(2), cent(1)) < 200 && blueChannel(cent(2), cent(1)) > 150
                board(x, y) = 1;
            end

            x = x + 1; i = i + 1;
        end
    end

    if max(max(tmp ~= board)) == 1
        
        %close all;
        
        if tools_game.hasWinner(board) == 1
            fprintf("O jogador %d venceu!\n", player);
            break;
        else
            move = tools_game.bestMove(board, player);

            figure, imshow(img);
            hold on
            i = 1; x = 1; y = 1;
            for k = 1 : length(props) % insere os números dos rótulos nas regiões
                if props(k).Area > minArea && props(k).Area < maxArea        
                    if x > 6
                        x = 1; y = y+1;
                    end
                    
                    if move(x, y) == 1
                        plot(props(k).Centroid(1), props(k).Centroid(2), 'cp', 'MarkerSize', 20);
                    end

                    x = x + 1; i = i + 1;
                end
            end

            if max(max(move)) == 0
                fprintf("Não há melhor jogada!\n");
            end
        end
        
        %Armazena o tabuleiro atual!
        tmp = board;
        
        %Troca de player!
        if player == 1
            player = 2;
        else
            player = 1;
        end
        
        fprintf("Vez do jogador %d!\n", player);
    end
end

%Limpa o objeto!
clear('cam');
fprintf("End Game!\n");