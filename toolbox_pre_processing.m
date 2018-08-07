function tools = toolbox_pre_processing()
    tools.circles_processing = @circles;
end

function bwImage = circles(rgbImage, bwr, str)
    %Binarizando imagem.
    imgBinaria = im2bw(rgbImage, graythresh(rgbImage));

    %bwreaopen
    imgBwreaopen = bwareaopen(imgBinaria, bwr);

    %strel tipo disco tamanho N e imclose
    se = strel('disk', str);
    bwImage = imclose(imgBwreaopen, se);
end