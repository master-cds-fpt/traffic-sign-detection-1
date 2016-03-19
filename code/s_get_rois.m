mandatory_rois = [];
danger_rois = [];
prohibitory_rois = [];

for i = 600:899
	file_name = sprintf('%05d.mat',i);
	mandatory_rois_ = f_template_matching(file_name,'../mandatory/','../mandatory/templates/');
	if(size(mandatory_rois_,1) < 0)
		continue;
	end
	mandatory_rois = [mandatory_rois ; [i*ones(size(mandatory_rois_,1),1) mandatory_rois_]];
end
save('../roi/mandatory','mandatory_rois');

for i = 600:899
	file_name = sprintf('%05d.mat',i);
	danger_rois_ = f_template_matching(file_name,'../mandatory/','../danger/templates/');
	if(size(danger_rois_,1) < 1)
		continue;
	end
	danegr_rois = [danger_rois ; [i*ones(size(danger_rois_,1),1) danger_rois_]];
end
save('../roi/danger','danger_rois');

% for i = 600:899
% 	file_name = sprintf('%05d.mat',i);
% 	prohibitory_rois_ = f_template_matching(file_name,'../prohibitory/','../prohibitory/templates/');
% 	if(size(prohibitory_rois_,1) < 1)
% 		continue;
% 	end
% 	prohibitory_rois = [prohibitory_rois ; [i*ones(size(prohibitory_rois_,1),1) prohibitory_rois_]];
% end

% save('../roi/prohibitory','prohibitory_rois');