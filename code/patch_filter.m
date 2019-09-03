function smoothed_pixel = patch_filter(window,h_square,iso_mask)
	
	%%the pixel of interest is the center pixel.
	% we need to compare the central patch with all the other patches
	
	%smoothed_pixel = $\sum widow\_pixel * w_{ij};
	%indeces of central patch can be calculated as 
	%y = round(size(window + patch_size)/2)
	%y = y(1)
	%t = round(size(patch)/2)
	%t = t(1)
	%mid_patch  = window(y-t:y+t,y-t:y+t)
    %
    %%
    
	central_patch = window(13:21,13:21);
	weights = zeros(25,25);
	di = zeros(25,25); % WINDOW_SIZE
	%we have to loop through the patches to calculate dissimilarity i.e di
	%disp('for loop time')
	%tic;
	for x = 5:29
		for y = 5:29
			temp_1 = (central_patch - window(x-4:x+4,y-4:y+4));
			temp_2 = temp_1 .* temp_1;
			temp_3 = temp_2 .* iso_mask;
			di(x-4,y-4) = sum(temp_2(:));
		end
	end
	%toc;
	weights = exp(-di/h_square);
	normalised_weight = weights / sum(weights(:));
	window_pix = window(5:29,5:29); %pixels in the window
	temp_mask_1 = normalised_weight .* window_pix;
	smoothed_pixel = sum(temp_mask_1(:));
	

	
end