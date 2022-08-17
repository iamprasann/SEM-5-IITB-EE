%%common region extraction
function [ip_img_final, reg_img_final] = commonregion(ip_img, reg_img)
[H, W] = size(ip_img);
max_h_reduction = 20;
max_w_reduction = 20;

best_norm = 100000;
best_h_reduction_top = 50;
best_h_reduction_bottom = 50;
best_w_reduction_left = 50;
best_w_reduction_right = 50;

for i = 1:max_h_reduction
    for j = 1:max_h_reduction
        for k = 1:max_w_reduction
            for l = 1:max_w_reduction
                
				input_dummy = ip_img(i:(H - i - j), k:(W - k - l));
				reg_dummy = reg_img(i:(H - i - j), k:(W - k - l));

				input_row_sum = sum(input_dummy, 1);
                input_row_sum = input_row_sum(:);
				input_col_sum = sum(input_dummy, 2);
                input_col_sum = input_col_sum(:);
				reg_row_sum = sum(reg_dummy, 1);
                reg_row_sum = reg_row_sum(:);             
				reg_col_sum = sum(reg_dummy, 2);
                reg_col_sum = reg_col_sum(:);

				input_array = cat(1, input_row_sum, input_col_sum);
				reg_array = cat(1, reg_row_sum, reg_col_sum);
				
                dist = norm(input_array-reg_array);

				if (dist < best_norm) 
					best_norm = dist; 
					best_h_reduction_top = i;
					best_h_reduction_bottom = j;
					best_w_reduction_left = k;
					best_w_reduction_right = l;
                end
                
            end
        end
    end
end

ip_img_final = ip_img(best_h_reduction_top:(H - best_h_reduction_top - best_h_reduction_bottom), best_w_reduction_left:(W - best_w_reduction_left - best_w_reduction_right));
reg_img_final = reg_img(best_h_reduction_top:(H - best_h_reduction_top - best_h_reduction_bottom), best_w_reduction_left:(W - best_w_reduction_left - best_w_reduction_right));

end