for video = 1:7
    
    blur = 15;  % sigma of a gaussian for blurred frames

    list = dir(['video' num2str(video) '/*.jpg']);
    for i = 1:length(list)
        %img{i} = imresize(imread([list(i).folder '\' list(i).name]),[720 1280]);
        img{i} = imread([list(i).folder '\' list(i).name]);
        imgBlur{i} = imgaussfilt(img{i}, blur);
    end

    save(['mat/video' num2str(video) '.mat'],'img', 'imgBlur');
    
    disp(video)
end