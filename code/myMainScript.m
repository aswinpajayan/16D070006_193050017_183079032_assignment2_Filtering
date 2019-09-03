%% MyMainScript

%tic;
%%Reading input image
x = load('../data/barbara.mat');
s = size(x.imageOrig);
original_image = uint8(mat2gray(x.imageOrig)*255);
filtered_image = myPatchFilter(original_image);

x = imread('../data/grass.png');
original_image = uint8(mat2gray(x)*255);
filtered_image = myPatchFilter(original_image);

x = imread('../data/honeyCombReal.png');
original_image = uint8(mat2gray(x)*255);
filtered_image = myPatchFilter(original_image);


