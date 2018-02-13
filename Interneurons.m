function [names,nocells_interneuron,p_ISI_10ms] = Interneurons(trialtype,region)
cd /Users/milenna/Google_Drive/Lab/Final
if strcmpi(region,'DG')
    [num,text,raw] = xlsread('DATABASE_FINALWaS_NewReports.xlsx'); 
elseif strcmpi(region,'CA')
    [num,text,raw] = xlsread('DATABASE_FINALWaS_NewReports.xlsx',2); 
end

% ind = strmatch('WT6', text(:,9))-1;
% 
% inds = find(num(:,11) == 1 & num(:,14)<8 & num(:,16)>5);
%indices = find(num(:,11) == 1 & num(:,14)<8);
% indices = intersect(inds,ind)
% indices = find(num(:,11) == 1 & num(:,8)==140831 & num(:,14)<8 & num(:,16)>5);
inds = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)<8 & num(:,16)>5);
inds2 = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>=8 & num(:,20)<0.1 & num(:,16)>5);
inds3 = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)<8 & num(:,16)>3.5 & num(:,20)<0.2);
inds4 = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>=8 & num(:,20)<0.5 & num(:,16)>8);

indsingle = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)<8 & num(:,16)>5);
indsingle2 = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>=8 & num(:,20)<0.1 & num(:,16)>5);
indsingle3 = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)<8 & num(:,16)>3.5 & num(:,20)<0.2);
indsingle4 = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>=8 & num(:,20)<0.5 & num(:,16)>8);

inds = [inds;inds2;inds3;inds4;indsingle;indsingle2;indsingle3;indsingle4];
% inds = [inds;;inds2;indsingle;indsingle2];
% inds = [inds;indsingle];
% inds = find(num(:,11) == 1 & num(:,14)<8 & num(:,16)>5);

%for CT only:
%  ind = strmatch('CT', text(:,1))-1
% for PICtask:
% ind = strmatch('PIC', text(:,1))-1
indices = inds
%   indices = intersect(inds,ind)
%for CT only:
if strcmpi(trialtype,'CT')
    ind = strmatch('CT', text(:,1))-1;
    indices = intersect(inds,ind);
% for PICtask:
elseif strcmpi(trialtype,'PIC')
    ind = strmatch('PIC', text(:,1))-1;
    indices = intersect(inds,ind);
% elseif strcmpi(trialtype,'All')
%     indices = inds;
end


%tells you which clusters they are:
names = text(indices+1, [2,14,15,11]);

nocells_interneuron= length(indices)    
tot_qual = num(indices, 4);
bkgr_qual = num(indices, 5);
inter_qual = num(indices, 6);

width = num(indices, 14); %convert this to ms
r_waveform = num(indices, 15);
grand_rate = num(indices, 16);
p_actpix_ROOM = num(indices, 17);
r_mapcoh_ROOM = num(indices, 18);
map_IC_ROOM = num(indices, 19);
p_ISI_10ms = num(indices, 20);
ISI = num(indices, 21);
n_fields_ROOM = num(indices, 22);
p_actpix_ARENA= num(indices, 24);
r_mapcoh_ARENA = num(indices, 25);
map_IC_ARENA = num(indices, 26);
n_fields_ARENA = num(indices, 27);


% ave_width_DGinter = nanmean(width)
% ave_r_waveform_DGinter= nanmean(r_waveform)
% ave_grand_rate_DGinter = nanmean(grand_rate)
% ave_p_actpix_ROOM_DGinter = nanmean(p_actpix_ROOM)
% ave_r_mapcoh_ROOM_DGinter = nanmean(r_mapcoh_ROOM)
% ave_map_IC_ROOM_DGinter = nanmean(map_IC_ROOM)
% ave_p_ISI_10ms_DGinter = nanmean(p_ISI_10ms)
% ave_ISI_DGinter = nanmean(ISI)
% ave_n_fields_ROOM_DGinter = nanmean(n_fields_ROOM)
% ave_p_actpix_ARENA_DGinter = nanmean(p_actpix_ARENA)
% ave_r_mapcoh_ARENA_DGinter = nanmean(r_mapcoh_ARENA)
% ave_map_IC_ARENA_DGinter = nanmean(map_IC_ARENA)
% ave_n_fields_ARENA_DGinter = nanmean(n_fields_ARENA)


aves7=[nanmean(tot_qual)
    nanmean(bkgr_qual)
    nanmean(inter_qual)
nanmean(width)
nanmean(r_waveform)
nanmean(grand_rate)
nanmean(p_actpix_ROOM)
nanmean(r_mapcoh_ROOM)
nanmean(map_IC_ROOM)
nanmean(p_ISI_10ms)
nanmean(ISI)
nanmean(n_fields_ROOM)
nanmean(p_actpix_ARENA)
nanmean(r_mapcoh_ARENA)
nanmean(map_IC_ARENA)
nanmean(n_fields_ARENA)];

se7 = [nanstd(tot_qual)./sqrt(size(tot_qual,1))
    nanstd(bkgr_qual)./sqrt(size(bkgr_qual,1))
    nanstd(inter_qual)./sqrt(size(inter_qual,1))
nanstd(width)./sqrt(size(width,1))
nanstd(r_waveform)./sqrt(size(r_waveform,1))
nanstd(grand_rate)./sqrt(size(grand_rate,1))
nanstd(p_actpix_ROOM)./sqrt(size(p_actpix_ROOM,1))
nanstd(r_mapcoh_ROOM)./sqrt(size(r_mapcoh_ROOM,1))
nanstd(map_IC_ROOM)./sqrt(size(map_IC_ROOM,1))
nanstd(p_ISI_10ms)./sqrt(size(p_ISI_10ms,1))
nanstd(ISI)./sqrt(size(ISI,1))
nanstd(n_fields_ROOM)./sqrt(size(n_fields_ROOM,1))
nanstd(p_actpix_ARENA)./sqrt(size(p_actpix_ARENA,1))
nanstd(r_mapcoh_ARENA)./sqrt(size(r_mapcoh_ARENA,1))
nanstd(map_IC_ARENA)./sqrt(size(map_IC_ARENA,1))
nanstd(n_fields_ARENA)./sqrt(size(n_fields_ARENA,1))];



% figure(1)
% subplot(1,3,1)
% N_tot_qual = hist(tot_qual,[-1:2:30]);
% bar([-1:2:30], N_tot_qual, 'histc');
% axis([-1 30 0 50]);
% title('tot qual');
% hold on
% subplot(1,3,2)
% N_bkgr_qual = histc(bkgr_qual,[-1:15]);
% bar([-1:15], N_bkgr_qual, 'histc');
% axis([-1 15 0 40]);
% title('bkgr qual');
% hold on
% subplot(1,3,3)
% N_inter_qual = histc(inter_qual,[-1:17]);
% bar([-1:17], N_inter_qual, 'histc');
% axis([-1 15 0 30]);
% title('inter qual');
% hold on
% [ax,h2] = suplabel('DG', 't');
% set(h2, 'FontSize', 20);
% 
% figure(2)
% subplot(2,3,1)
% N_width = histc(width,[3:20]);
% bar([3:20], N_width, 'histc');
% axis([0 20 0 50]);
% title('width');
% hold on
% subplot(2,3,2)
% N_r_waveform = histc(r_waveform,[-0.6:0.1:1]);
% bar([-0.6:0.1:1], N_r_waveform, 'histc');
% axis([0 1 0 100]);
% title('rwaveform');
% hold on
% 
% % There are some neurons who have >30 grand rate but then the graph gets
% % even uglier.
% subplot(2,3,3)
% N_grand_rate = histc(grand_rate,[0:1:85]);
% bar([0:1:85], N_grand_rate, 'histc');
% axis([0 85 0 100]);
% title('grandrate');
% hold on
% 
% 
% subplot(2,3,4)
% N_grand_rate = histc(grand_rate,[0:0.2:5]);
% bar([0:0.2:5], N_grand_rate, 'histc');
% axis([0 5 0 50]);
% title('grandrate 0-6 sp/s');
% hold on
% 
% subplot(2,3,5)
% N_p_ISI_10ms = histc(p_ISI_10ms, [0:0.1:1]);
% bar([0:0.1:1], N_p_ISI_10ms, 'histc');
% axis([0, 1, 0, 100]);
% title('p ISI 10ms');
% hold on
% subplot(2,3,6)
% N_ISI = histc(ISI, [0:1:15]);
% bar([0:1:15], N_ISI, 'histc');
% title('ISI (ms)')
% hold on
% [ax,h2] = suplabel('DG', 't');
% set(h2, 'FontSize', 20);
% % 
% % subplot('position', [0.05 0.1 0.4 0.4])
% % N_p_ISI_10ms = histc(p_ISI_10ms, [0:0.1:1]);
% % bar([0:0.1:1], N_p_ISI_10ms, 'histc');
% % axis([0, 1, 0, 550]);
% % title('p ISI 10ms');
% % hold on
% % subplot('position', [0.55 0.1 0.4 0.4])
% % N_ISI = histc(ISI, [0:1:50]);
% % bar([0:1:50], N_ISI, 'histc');
% % title('ISI (ms)')
% % hold on
% 
% 
% 
% figure(3)
% subplot(2,4,1)
% hist(p_actpix_ROOM)
% title('p. actpix ROOM');
% hold on
% 
% %why can this be negative?
% subplot(2,4,2)
% N_r_mapcoh_ROOM = histc(r_mapcoh_ROOM, [-0.3:0.1:1]);
% bar([-0.3:0.1:1], N_r_mapcoh_ROOM, 'histc');
% axis([-0.3 1 0 40]);
% title('r mapcoh ROOM');
% hold on
% 
% subplot(2,4,3)
% N_map_IC_ROOM = histc(map_IC_ROOM, [-1:0.5:12]);
% bar([-1:0.5:12], N_map_IC_ROOM, 'histc');
% axis([-1 12 0 30]);
% title('map IC ROOM');
% hold on
% 
% subplot(2,4,4)
% N_n_fields_ROOM = histc(n_fields_ROOM, [0:1:10]);
% bar([0:1:10], N_n_fields_ROOM, 'histc');
% axis([0 10, 0 80]);
% title('n fields ROOM');
% hold on
% 
% subplot(2,4,5)
% hist(p_actpix_ARENA)
% title('p. actpix ARENA')
% hold on
% 
% %why can this be negative?
% subplot(2,4,6)
% N_r_mapcoh_ARENA = histc(r_mapcoh_ARENA, [-0.3:0.1:1]);
% bar([-0.3:0.1:1], N_r_mapcoh_ARENA, 'histc');
% axis([-0.3 1 0 20]);
% title('r mapcoh ARENA');
% hold on
% 
% subplot(2,4,7)
% N_map_IC_ARENA = histc(map_IC_ARENA, [-1:0.5:12]);
% bar([-1:0.5:12], N_map_IC_ARENA, 'histc');
% axis([-1 12 0 20]);
% title('map IC ARENA');
% hold on
% 
% subplot(2,4,8)
% N_n_fields_ARENA = histc(n_fields_ARENA, [0:1:10]);
% bar([0:1:10], N_n_fields_ARENA, 'histc');
% axis([0, 10, 0, 80])
% title('n fields ARENA');
% hold on
% [ax,h2] = suplabel('DG', 't');
% set(h2, 'FontSize', 20);
% 
names(find(~cellfun('isempty',regexp(names(:,1),'150803'))),:)=[]

% save(char(strcat('Interneurons',trialtype,region)))
end
