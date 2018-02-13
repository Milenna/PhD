
function [names,nocells_placeDG,n_fields_ROOM,p_ISI_10ms] = Placecells(trialtype,region)
cd /Users/milenna/Documents/Lab/Final

if strcmpi(region,'DG')
    [num,text,raw] = xlsread('DATABASE_FINALWaS_NewReports.xlsx'); 
elseif strcmpi(region,'CA')
    [num,text,raw] = xlsread('DATABASE_FINALWaS_NewReports.xlsx',2); 
end
% ind = strmatch('WT16', text(:,9))-1
% inds = find(num(:,11) == 1 & num(:,8) == 140831 & num(:,14)>6 & num(:,16)<5.1 & num(:,17)<0.75 & num(:,18)>0.15 & num(:,19)>0.35 & num(:,22)>0)
% indices = intersect(inds,ind)

% indices = find(num(:,11) == 1 & num(:,8) == 140805 & num(:,14)>6 & num(:,16)<5.1 & num(:,17)<0.75 & num(:,18)>0.18 &num(:,19)>0.4 & num(:,22)>0);
% indices = find(num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1 & num(:,18)>0.19 &num(:,19)>0.3 & num(:,22)>0);
% ind = strmatch('circle', text(:,10))-1
% testbox only
% ind = find(strncmpi('test', text(:,10),4))-1
% for place cells:
% inds =  find(num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1&  num(:,18)>0.19 &num(:,19)>0.3 & num(:,22)>0);
% inds = find(num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,18)>0.25 &num(:,19)>0.49 & num(:,22)>0);

inds = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.8 & num(:,18)>0.2 &num(:,19)>0.49 & num(:,22)>0);
indsingle = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.8 & num(:,18)>0.2 &num(:,19)>0.49 & num(:,22)>0);
indsArena = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,30)<0.8 & num(:,31)>0.2 &num(:,32)>0.49 & num(:,33)>0);
indsingleArena = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,30)<0.8 & num(:,31)>0.2 &num(:,32)>0.49 & num(:,33)>0);
inds1 = [inds;indsingle;indsArena;indsingleArena];
inds = unique(inds1);

% more stringent
% inds = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.65 & num(:,18)>0.25 &num(:,19)>0.49 & num(:,22)>0);
% indsingle = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.65 & num(:,18)>0.25 &num(:,19)>0.49 & num(:,22)>0);
% indsArena = find(num(:,4)>8 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,30)<0.65 & num(:,31)>0.25 &num(:,32)>0.49 & num(:,33)>0);
% indsingleArena = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,30)<0.65 & num(:,31)>0.25 &num(:,32)>0.49 & num(:,33)>0);
% inds1 = [inds;indsingle;indsArena;indsingleArena]
% inds = unique(inds1)

% inds2 = find(num(:,4)>8 & num(:,11) == 5 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.8 & num(:,18)>0.25 &num(:,19)>0.49 & num(:,22)>0);
% indsingle2 = find(num(:,5)>4 & num(:,6)==0 & num(:,11) == 1 & num(:,14)>6 & num(:,16)<5.1& num(:,17)<0.8 & num(:,18)>0.25 &num(:,19)>0.49 & num(:,22)>0);
% inds2 = [inds2;indsingle2]
% 
% inds=intersect(inds,inds2)

%for CT only:
if strcmpi(trialtype,'CT')
ind = strmatch('CT', text(:,1))-1;
% for PICtask:
elseif strcmpi(trialtype,'PIC')
ind = strmatch('PIC', text(:,1))-1;
%  indices = inds
end
  indices = intersect(inds,ind);


%tells you which clusters they are:
names = text(indices+1, [2,14,15,11]);

for nn = 1:size(names,1)

fileID = fopen('place_DG.txt','a')
formatSpec = '%s\t %s\t %s\n';
fprintf(fileID, formatSpec, names{nn, 1}(1:end-8),names{nn,2:3});
fclose(fileID);

end

nocells_placeDG = length(indices)    ;
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
p_actpix_ARENA= num(indices, 30);
r_mapcoh_ARENA = num(indices, 31);
map_IC_ARENA = num(indices, 32);
n_fields_ARENA = num(indices, 33);
trial = text(indices+1, 12);
date = num(indices,8);

ave_width_DGplace = nanmean(width)
ave_r_waveform_DGplace= nanmean(r_waveform)
ave_grand_rate_DGplace = nanmean(grand_rate)
ave_p_actpix_ROOM_DGplace = nanmean(p_actpix_ROOM)
ave_r_mapcoh_ROOM_DGplace = nanmean(r_mapcoh_ROOM)
ave_map_IC_ROOM_DGplace = nanmean(map_IC_ROOM)
ave_p_ISI_10ms_DGplace = nanmean(p_ISI_10ms)
ave_ISI_DGplace = nanmean(ISI)
ave_n_fields_ROOM_DGplace = nanmean(n_fields_ROOM)
ave_p_actpix_ARENA_DGplace = nanmean(p_actpix_ARENA)
ave_r_mapcoh_ARENA_DGplace = nanmean(r_mapcoh_ARENA)
ave_map_IC_ARENA_DGplace = nanmean(map_IC_ARENA)
ave_n_fields_ARENA_DGplace = nanmean(n_fields_ARENA)

name = strcat(num2str(date),'_',names(:,4),'_',trial,'_',names(:,2),'_',names(:,3));
 FCA= table(tot_qual, bkgr_qual, inter_qual, width, grand_rate, p_actpix_ROOM, r_mapcoh_ROOM, map_IC_ROOM, p_ISI_10ms, ...
ISI, n_fields_ROOM, p_actpix_ARENA, r_mapcoh_ARENA, map_IC_ARENA, n_fields_ARENA,'RowNames',name);

% writetable(FCA,char(strcat('PlaceCells',region,trialtype,'.txt')),'Delimiter','\t','WriteRowNames',true)



aves5=[nanmean(tot_qual)
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

se5 = [nanstd(tot_qual)./sqrt(size(tot_qual,1))
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
% axis([-1 30 0 40]);
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
% axis([-1 15 0 40]);
% title('inter qual');
% hold on
% [ax,h2] = suplabel('DG', 't');
% set(h2, 'FontSize', 20);
% 
% figure(2)
% subplot(2,3,1)
% N_width = histc(width,[3:20]);
% bar([3:20], N_width, 'histc');
% axis([0 20 0 30]);
% title('width');
% hold on
% subplot(2,3,2)
% N_r_waveform = histc(r_waveform,[-0.6:0.1:1]);
% bar([-0.6:0.1:1], N_r_waveform, 'histc');
% axis([0 1 0 30]);
% title('rwaveform');
% hold on
% 
% % There are some neurons who have >30 grand rate but then the graph gets
% % even uglier.
% subplot(2,3,3)
% N_grand_rate = histc(grand_rate,[0:1:85]);
% bar([0:1:85], N_grand_rate, 'histc');
% axis([0 85 0 30]);
% title('grandrate');
% hold on
% 
% 
% subplot(2,3,4)
% N_grand_rate = histc(grand_rate,[0:0.2:5]);
% bar([0:0.2:5], N_grand_rate, 'histc');
% axis([0 5 0 30]);
% title('grandrate 0-6 sp/s');
% hold on
% 
% subplot(2,3,5)
% N_p_ISI_10ms = histc(p_ISI_10ms, [0:0.1:1]);
% bar([0:0.1:1], N_p_ISI_10ms, 'histc');
% axis([0, 1, 0, 30]);
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
% axis([0 1 0 20])
% 
% %why can this be negative?
% subplot(2,4,2)
% N_r_mapcoh_ROOM = histc(r_mapcoh_ROOM, [-0.3:0.1:1]);
% bar([-0.3:0.1:1], N_r_mapcoh_ROOM, 'histc');
% axis([-0.3 1 0 20]);
% title('r mapcoh ROOM');
% hold on
% 
% subplot(2,4,3)
% N_map_IC_ROOM = histc(map_IC_ROOM, [-1:0.5:12]);
% bar([-1:0.5:12], N_map_IC_ROOM, 'histc');
% axis([-1 12 0 20]);
% title('map IC ROOM');
% hold on
% 
% subplot(2,4,4)
% N_n_fields_ROOM = histc(n_fields_ROOM,[0:1:10]);
% bar([0:1:10],N_n_fields_ROOM, 'histc');
% axis([0 10, 0 20]);
% title('n fields ROOM');
% hold on
% subplot(2,4,5)
% hist(p_actpix_ARENA)
% axis
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
% axis([0, 10, 0, 20])
% title('n fields ARENA');
% hold on
% [ax,h2] = suplabel('DG', 't');
% set(h2, 'FontSize', 20);

names(find(~cellfun('isempty',regexp(names(:,1),'150803'))),:)=[];

% save DG_placecells.mat
 end
% 
