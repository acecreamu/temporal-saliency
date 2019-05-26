function trial(video, obs, radius, nRep, fps, roundLimit_, clickLimit_)

    global out flag i j window img imgBlur squareMask
    
    % if videos are prepared
    load(['mat/video' num2str(video)])
    
    % if not, uncomment 
%     blur = 15;
%     list = dir(['video' num2str(video) '/*.jpg']);
%     for i = 1:length(list)
%         %img{i} = imresize(imread([list(i).folder '\' list(i).name]),[720 1280]);
%         img{i} = imread([list(i).folder '\' list(i).name]);
%         imgBlur{i} = imgaussfilt(img{i}, blur);
%     end
    
    [imSize(1), imSize(2),~] = size(img{1});
    [scrSize(2), scrSize(1)] = Screen('WindowSize', window);
    offset = 0.5 * (scrSize - imSize);
    nFrames = length(img);

    flag = false;
    i = 0;
    j = 0;
    out = [];
    squareMask = createCircle(2*radius, 2*radius, radius, radius, radius);
    
    t = timer('Period', 1/fps,'TasksToExecute', length(img)*nRep,...
        'ExecutionMode','fixedRate','StopFcn', @timerStopFunc); 
        
    t.TimerFcn = {@timerFunc, ...
        radius, roundLimit_, clickLimit_, imSize, offset, nFrames};

    start(t);
    while(isvalid(t))
        pause(1/fps)
    end
    
    imageTexture = Screen('MakeTexture', window, 0.5);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    Screen('Flip', window);
    
    delete(timerfind);
    img = [];
    imgBlur = [];
    save(sprintf('video%03d_obs%03d.mat', video, obs), 'out');

end

function mask = createCircle(xDim, yDim, xc, yc, radii)
    [xx,yy] = meshgrid(1:yDim,1:xDim);
    mask = false(xDim,yDim);
    mask = mask | hypot(xx - xc, yy - yc) <= radii;
end