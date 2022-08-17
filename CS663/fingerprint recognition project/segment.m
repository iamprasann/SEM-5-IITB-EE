function [top_row, bottom_row, left_col, right_col] = segment(reg_img, scale)
    
    rot_img = (reg_img-min(reg_img, [], 'all'))./(max(reg_img, [], 'all')-min(reg_img, [], 'all'));
    
    rot_row_sum = sum(rot_img, 2);
    rot_row_sum = rot_row_sum(:);
	rot_col_sum = sum(rot_img, 1);
    rot_col_sum = rot_col_sum(:);
    
	[H, W] = size(rot_img);
	top_row = 1;
	bottom_row = H;
	left_col = 1;
	right_col = W;
    
	for i = 1:H
		if(rot_row_sum(i,1) > W*scale)
			top_row = i; break
        end
    end
    
    for i = 1:H-1
		if(rot_row_sum(H-i,1) > W*scale)
			bottom_row = H-i; break
        end
    end
    
    for i = 1:W
		if(rot_col_sum(i,1) > H*scale)
			left_col = i; break
        end
    end

    for i = 1:W-1
		if(rot_col_sum(W-i,1) > H*scale)
			right_col = W-i; break
        end
    end
    
end