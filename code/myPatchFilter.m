function filtered_image = myPatchFilter(original_image)
image_size = size(original_image);

%%PARAMETERS
WINDOW_SIZE = [25 25];
PATCH_SIZE = [9 9];
%% Calculating Gaussian Kernel to make the patches isometric (variance - 4)
%%
p = PATCH_SIZE(1)/2 -1;
for a = -4:1:4
    for b = -4:1:4
        c(a+5,b+5) =  exp(-((a.^2)+(b.^2))/32);
    end
end
iso_mask = c ;
iso_mask = iso_mask /sum(c(:));

smoothen = @patch_filter;
%tuning the free parameter
for h_square = [10800 12000 13200] 
    
	tic;
    %adding gaussian noise to corrupt the image
    corrupted_image1 = imnoise(original_image,'gaussian',0,0.0025);
    corrupted_image = double(corrupted_image1);
    
    %% The window passed to the function is actually more than [25 25] to accomdate border pixels as well
    %%
	filtered_image  = nlfilter(corrupted_image,WINDOW_SIZE + PATCH_SIZE - 1,@(window) patch_filter (window,h_square,iso_mask));
    filtered_image = uint8(filtered_image);
    
     %% CALCULATING RMSD
    % since i am operating in image range( 1 - 255)
    % Sigma needs to be calculated in normalised form
    %%
	sigma_normalised = sqrt(h_square/(256*256));
	temp1 = (filtered_image - original_image).^2;
    temp2 = (sum(temp1(:)))/(image_size(1)*image_size(2));
    RMSD = sqrt(temp2)
    
    %% Displaying images with correct color map 
    myNumOfColors = 255;
    myColorScale = [[0: 1/(myNumOfColors -1): 1 ]',[0 :1/(myNumOfColors -1): 1 ]', [0: 1/(myNumOfColors -1):1 ]']; 
    figure
    title(['h^{2} = ' h_square ])
    subplot(1,3,1)
        imagesc(original_image);
        colormap(myColorScale);
        colormap gray;
        daspect([1 1 1])
        title('original image');
    noise_sigma = 0.05;
   
    subplot(1,3,2)
        imagesc(corrupted_image1)
        colormap(myColorScale);
        colormap gray;
        daspect([1 1 1])
        title('corrupted image');
    
        
    myNumOfColors = 256;
	myColorScale = [[0: 1/(myNumOfColors -1): 1 ]',[0 :1/(myNumOfColors -1): 1 ]', [0: 1/(myNumOfColors -1):1 ]'];
    subplot(1,3,3)
     
        imagesc(filtered_image)
        colormap(myColorScale);
        colormap gray;
        daspect([1 1 1])
        title('fitered image')
    
	toc
end
%toc;


end

