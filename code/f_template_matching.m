function [rois] = f_template_matching(img_name,threshold)
	load(strcat('../mandatory/',img_name),'img');
	mandatory_img = img;

	%load(strcat('..\prohibitory\',img_name),'img');
	prohibitory_img = img;

	%load(strcat('..\prohibitory\',img_name),'img');
	danger_img = img;

	% mandatory_img = imread(strcat('..\mandatory\',img_name));
	% prohibitory_img = imread(strcat('..\prohibitory\',img_name));
	% danger_img = imread(strcat('..\mandatory\',img_name));

	mandatory_template_path = ('../mandatory/templates/');
	prohibitory_template_path = ('../prohibitory/templates/');
	danger_template_path = ('../danger/templates/');

	mandatory_templates = extract_templates(mandatory_template_path);
	prohibitory_templates = extract_templates(prohibitory_template_path);
	danger_templates = extract_templates(danger_template_path);

    
    %mandatory image, prohibitory image and danger image are svm outputs of
    %the same image with corresponding svms
    
	scale = 1.1;
	[rois,score] = sub_scale_matching(mandatory_img,prohibitory_img,danger_img, ...
		  mandatory_templates,prohibitory_templates,danger_templates,threshold);
	order = zeros(size(score));

	for k = 1:22
		mandatory_img = imresize(mandatory_img,1/scale);
        prohibitory_img = imresize(prohibitory_img,1/scale);
        danger_img = imresize(danger_img,1/scale);
        
		[rois_,score_] = sub_scale_matching(mandatory_img,prohibitory_img,danger_img, ...
		  mandatory_templates,prohibitory_templates,danger_templates,threshold);
		rois = [rois ;floor(rois_.*(scale^k))];
		score = [score ; score_];
    end
	
    ids = find((rois(:,1) > 0) & (rois(:,2) > 0));
    rois = rois(ids,:);
    score = score(ids);
    score = score(score > 0.3);
    rois = rois(score > 0.3,:);
    display(rois);
    display(score);
	rois = remove_overlapping_regions(rois,score);
end

function [rois,score] = sub_scale_matching(mandatory_img,prohibitory_img,danger_img, ...
		  mandatory_templates,prohibitory_templates,danger_templates, threshold)
	% roi = [ulx, uly, lrx, lry]
	% rois = [roi]
	R = zeros(size(mandatory_img));
	for i =1:size(mandatory_templates,3)
		R = bsxfun(@max,R,conv2(mandatory_img, mandatory_templates(:,:,i),'SAME'));
    end
    
    [xdetections, ydetections, score] = get_distinct_detections(R);
    [rois] = generate_rois_from_points(xdetections, ydetections);
    
% 	for i =1:size(prohibitory_templates,3)
% 		R = bsxfun(@max,R,conv2(prohibitory_img, prohibitory_templates(:,:,i),'SAME'));
% 	end
% 
% 	for i =1:5
% 		size(danger_templates)
% 		R = bsxfun(@max,R,1.2*conv2(danger_img, danger_templates(:,:,i),'SAME'));
% 	end
% 
% 	for i =6:10
% 		R = bsxfun(@max,R,conv2(danger_img, danger_templates(:,:,i),'SAME'));
% 	end

	% for id =1:size(x,1)
	% 	roi = [x-7 y-7 x+8 y+8];
	% 	rois = [rois roi];
	% 	score = [score R(y(id),x(id))];
	% end
end

function templates = extract_templates(template_path)
	listOfFiles = dir(template_path);
	listOfFiles([listOfFiles.isdir]) = [];

	templates = zeros(16,16,size(listOfFiles,1));
	for imgId = 1:size(listOfFiles, 1)
	    imgPath = strcat(template_path, listOfFiles(imgId).name);
	    templates(:,:,imgId) = rgb2gray(imread(imgPath));
	end
end

function [resRoi,resScore] = remove_overlapping_regions(roi,score)
	flag  = ones(size(roi,1),1);
	for i = 1:size(roi,1)
		if flag(i)==0
			continue;
		end

		for j = i+1:size(roi,1)
            if flag(j)==0
        		continue;
            end

			if get_overlap(roi(i,:),roi(j,:)) > 0.2
                %if score(i) > score(j)
                if abs(roi(i,4) - roi(i,2)) > abs(roi(j,4) - roi(j,2))
					flag(j)=0;
				else
					flag(i)=0;
				end
			end
		end
    end 
	resRoi = roi(flag==1,:);
	resScore = score(flag==1);

end

function overlap = get_overlap( resRoi, gtRoi )
% roi = [ulx, uly, lrx, lry]

	if resRoi(3) < gtRoi(1) || resRoi(4) < gtRoi(2) ...
	        || resRoi(1) > gtRoi(3) || resRoi(2) > gtRoi(4)
	    overlap = 0;
	else
	    intersectRoi(1) = max([resRoi(1), gtRoi(1)]);
	    intersectRoi(2) = max([resRoi(2), gtRoi(2)]);
	    intersectRoi(3) = min([resRoi(3), gtRoi(3)]);
	    intersectRoi(4) = min([resRoi(4), gtRoi(4)]);

	    if intersectRoi(3) < 0 || intersectRoi(4) < 0 
	        intersectArea = 0;
	    else
	        intersectArea = (intersectRoi(3) - intersectRoi(1) + 1) * (intersectRoi(4) - intersectRoi(2) + 1);
	    end

	    A1 = (resRoi(3) - resRoi(1) + 1) * (resRoi(4) - resRoi(2) + 1);
	    A2 = (gtRoi(3) - gtRoi(1) + 1) * (gtRoi(4) - gtRoi(2) + 1);

	    overlap = max([intersectArea/A1 intersectArea/A2]);
	end
end


function [xdetections, ydetections, score] = get_distinct_detections(R)
%R: Response image
%sort the response from high to low
    [val, ind] = sort(R(:), 'descend');
    detcount = 1;
    itr = 1;
    xdetections = [];
    ydetections = [];
	score = [];
    %iterate through all values from convolution
    %keeping best 10 detections
    while ((detcount <= 3) && (itr < length(ind)))
        [y, x] = ind2sub([size(R,1), size(R,2)], ind(itr));
        overlap = false;
        
        %check overlap using euclidean distance
        if detcount > 1
            X = [xdetections(:), ydetections(:)];
            Y = [x, y];
            distances = pdist2(X, Y);
            minDistance = min(distances(:));
            if minDistance  <= 100
                overlap = true;
            end
        end
        
        %add detection if no overlap
        if(~overlap)
            xdetections(detcount) = x;
            ydetections(detcount) = y;
            score(detcount) = val(itr);
            detcount = detcount +1;
        end
        itr = itr+1;
    end
    
    display(xdetections);
    display(ydetections);
    display(score);
    
end

function [rois] = generate_rois_from_points(xdetections, ydetections)
    rois = zeros([3,4]);
    w = 16;
    h = 16;
    for i = 1:length(xdetections)
        xmin = xdetections(i) - 7;
        ymin = ydetections(i) - 7;
        rois(i, :) =[xmin, ymin ,xdetections(i)+8, ydetections(i)+8];
    end
end