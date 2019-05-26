function timerFunc(~, ~, radius, ...
    roundLimit_, clickLimit_, imSize, offset, nFrames)

    global flag i j img imgBlur out window roundLimit clickLimit x y

    idx = mod(i,nFrames) + 1;

    if idx == 1
        roundLimit = roundLimit_;
        j = j + 1;
    end

    if flag && roundLimit > 0 && clickLimit > 0
        HideCursor();
        try
            mask = createCircle(imSize(2), imSize(1), ...
                x-offset(2), y-offset(1), radius);
        catch
            mask = zeros(imSize);
        end
        im = (1-mask) .* imgBlur{idx} + mask .* img{idx};
    else 
        ShowCursor('CrossHair');
        im = imgBlur{idx};
    end

    imageTexture = Screen('MakeTexture', window, im);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    Screen('Flip', window);

    [x,y,buttons,~] = GetMouse(window);

    if buttons(1) && ...
            x-offset(2)>0 && x-offset(2)<imSize(2) && ...
            y-offset(1)>0 && y-offset(1)<imSize(1)
        flag = true;
        roundLimit = roundLimit - 1;
        clickLimit = clickLimit - 1;
        out(idx,j,1) = x;
        out(idx,j,2) = y;    
    else
        flag = false;
        clickLimit = clickLimit_;
        out(idx,j,:) = zeros(1,1,2);
    end

    %if buttons(2); stop(t); end

    i = i + 1;
end



% create circular mask
% function mask = createCircle(xDim, yDim, xc, yc, radii)
%     [xx,yy] = meshgrid(1:yDim,1:xDim);
%     mask = false(xDim,yDim);
%     mask = mask | hypot(xx - xc, yy - yc) <= radii;
%     mask = uint8(mask);
% end

function mask = createCircle(xDim, yDim, xc, yc, r)
global squareMask
mask = zeros(yDim + 2*r, xDim + 2*r);
mask(yc : yc+2*r-1, xc : xc+2*r-1) = ones(r*2) .* squareMask;
mask = mask(r+1 : r+yDim, r+1 : r+xDim);
mask = uint8(mask);
end