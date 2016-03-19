function f_display_roi(img,rois)
	rois(:,3) = rois(:,3)-rois(:,1);
	rois(:,4) = rois(:,4)-rois(:,2);
	figure;
	imagesc(img);
	colormap gray;
	hold on;
	for i =1:size(rois,1)
		rectangle('Position',rois(i,:),'EdgeColor','r');
	end
	hold off;
end