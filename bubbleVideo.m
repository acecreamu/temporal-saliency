%########### PARAMETERS ############
cd C:\Users\acecreamu\Desktop\bubbleVideo
clear
 
obs = 39;           % observer's ID

nRep = 5;           % number of repeats of one video
fps = 25;           % video's fps (for timer)
radius = 200;       % radius of circular window (in px)
roundLimit_ = 100;  % limit of clear frames per round (in frames)
clickLimit_ =  25;  % limit of clear frames per one click (in frames)

%###################################
%%

% run PTB
Screen('Preference', 'SkipSyncTests', 0);
setupPTB;

% show instructions
global window
im = im2double(imread('instructions.jpg'));
imageTexture = Screen('MakeTexture', window, im);
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window);
pause(10);
%KbWait([], 2); 

% run videos and save results
trial(3, obs, radius, nRep, fps, roundLimit_, clickLimit_)
trial(4, obs, radius, nRep, fps, roundLimit_, clickLimit_)
trial(5, obs, radius, nRep, fps, roundLimit_, clickLimit_)
trial(6, obs, radius, nRep, fps, roundLimit_, clickLimit_)
trial(7, obs, radius, nRep, fps, roundLimit_, clickLimit_)

sca;
