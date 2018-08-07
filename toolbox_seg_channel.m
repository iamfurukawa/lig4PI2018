function tools = toolbox_seg_channel()
    tools.seg_channel_yellow_debug = @seg_channel_yellow_debug;
    tools.seg_channel_red_debug = @seg_channel_red_debug;
    tools.seg_channel_blue_debug = @seg_channel_blue_debug;
    
    tools.seg_channel_yellow = @seg_channel_yellow;
    tools.seg_channel_red = @seg_channel_red;
    tools.seg_channel_blue = @seg_channel_blue;
end

function maskedforSkin = seg_channel_yellow_debug(rgbImage, r, g, b)
    format long g;
    format compact;
    fontSize = 25;

    figure, imshow(rgbImage);
    impixelinfo

    % % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows, columns, numberOfColorBands] = size(rgbImage);
    % %Display the original color image.
    figure, subplot(3, 2, 1);
    imshow(rgbImage);
    title('Original Color Image', 'FontSize', fontSize);
    % % Enlarge figure to full screen.
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);

    % % % Let's compute and display the histogram of the red channel
    [pixelCount, grayLevels] = imhist(redChannel);
    subplot(3, 2, 2); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of red channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the green channel
    [pixelCount, grayLevels] = imhist(greenChannel);
    subplot(3, 2, 3); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of green channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the blue channel
    [pixelCount, grayLevels] = imhist(blueChannel);
    subplot(3, 2, 4); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of blue channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.


    skinPixels = redChannel > r & greenChannel > g & blueChannel < b;
    % Mask the image using bsxfun() function to get skin pixels.
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));

    % Show the skin pixels
    subplot(3, 2, 5);
    imshow(maskedforSkin);
    title('Skin Pixels', 'FontSize', fontSize);
    % 
    figure, imshow(maskedforSkin)
end

function maskedforSkin = seg_channel_red_debug(rgbImage, r, g, b)
    format long g;
    format compact;
    fontSize = 25;

    figure, imshow(rgbImage);
    impixelinfo

    % % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows, columns, numberOfColorBands] = size(rgbImage);
    % %Display the original color image.
    figure, subplot(3, 2, 1);
    imshow(rgbImage);
    title('Original Color Image', 'FontSize', fontSize);
    % % Enlarge figure to full screen.
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);


    thresholdValue = 75; % Whatever you define white as.
    whitePixels = redChannel < thresholdValue & greenChannel < thresholdValue & blueChannel < thresholdValue;
    redChannel(whitePixels) = 255;
    greenChannel(whitePixels) = 255;
    blueChannel(whitePixels) = 255;
    rgbImage = cat(3, redChannel, greenChannel, blueChannel);


    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);

    % % % Let's compute and display the histogram of the red channel
    [pixelCount, grayLevels] = imhist(redChannel);
    subplot(3, 2, 2); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of red channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the green channel
    [pixelCount, grayLevels] = imhist(greenChannel);
    subplot(3, 2, 3); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of green channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the blue channel
    [pixelCount, grayLevels] = imhist(blueChannel);
    subplot(3, 2, 4); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of blue channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.


    skinPixels = r >230 & g > 230 & b >230;
    % Mask the image using bsxfun() function to get skin pixels.
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));

    % Show the skin pixels
    subplot(3, 2, 5);
    imshow(maskedforSkin);
    title('Skin Pixels', 'FontSize', fontSize);
    % 
    figure, imshow(maskedforSkin)
end

function maskedforSkin = seg_channel_blue_debug(rgbImage, r, g, b)
    format long g;
    format compact;
    fontSize = 25;

    figure, imshow(rgbImage);
    impixelinfo

    % % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows, columns, numberOfColorBands] = size(rgbImage);
    % %Display the original color image.
    figure, subplot(3, 2, 1);
    imshow(rgbImage);
    title('Original Color Image', 'FontSize', fontSize);
    % % Enlarge figure to full screen.
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);

    % % % Let's compute and display the histogram of the red channel
    [pixelCount, grayLevels] = imhist(redChannel);
    subplot(3, 2, 2); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of red channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the green channel
    [pixelCount, grayLevels] = imhist(greenChannel);
    subplot(3, 2, 3); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of green channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    % 
    % % Let's compute and display the histogram of the blue channel
    [pixelCount, grayLevels] = imhist(blueChannel);
    subplot(3, 2, 4); 
    bar(grayLevels, pixelCount);
    grid on;
    title('Histogram of blue channel image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.


    skinPixels = r < 150 & g < 200 & b > 150;
    % Mask the image using bsxfun() function to get skin pixels.
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));

    % Show the skin pixels
    subplot(3, 2, 5);
    imshow(maskedforSkin);
    title('Skin Pixels', 'FontSize', fontSize);
    % 
    figure, imshow(maskedforSkin)
end

function maskedforSkin = seg_channel_yellow(rgbImage, r, g, b)
    format long g;
    format compact;
    
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    skinPixels = redChannel > r & greenChannel > g & blueChannel < b;
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));
end

function maskedforSkin = seg_channel_red(rgbImage, r, g, b)
    format long g;
    format compact;
    
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    thresholdValue = 75;
    whitePixels = redChannel < thresholdValue & greenChannel < thresholdValue & blueChannel < thresholdValue;
    redChannel(whitePixels) = 255;
    greenChannel(whitePixels) = 255;
    blueChannel(whitePixels) = 255;
    rgbImage = cat(3, redChannel, greenChannel, blueChannel);
    
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    skinPixels = redChannel > r & greenChannel > g & blueChannel > b;
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));
end

function maskedforSkin = seg_channel_blue(rgbImage, r, g, b)
    format long g;
    format compact;
    
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    skinPixels = redChannel < r & greenChannel < g & blueChannel > b;
    maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));
end