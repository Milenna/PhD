function []=calculateTausBasedonPosition_func(name,spike_smalldistINI_PlC,spike_smalldistCONF_PlC,spike_smalldistINI_INT,spike_smalldistCONF_INT)%,spike_alldistINI,spike_alldistINI_PlC,spike_alldistINI_INT)

binsize=1 %133ms, 2=266ms etc
% load x and y spikes/bin vectors from 'DistancefromShockZone.m'
% cd /Users/fentonlab/Documents/lab/electrophys/Final/WalkandStill/TS/
% load charsPl
% load spikesanddistancesforTAUS_133msPlC4pix_shzone_fields.mat
% spike_alldistINI_PlC=spike_alldistINI;
% spike_alldistCONF_PlC=spike_alldistCONF;
% spike_smalldistINI_PlC=spike_smalldistINI;
% spike_smalldistCONF_PlC=spike_smalldistCONF;
% 
% % load charsInt
% load spikesanddistancesforTAUS_133msIntLib4pix_shzone.mat
% spike_alldistINI_INT=spike_alldistINI;
% spike_alldistCONF_INT=spike_alldistCONF;
% spike_smalldistINI_INT=spike_smalldistINI;
% spike_smalldistCONF_INT=spike_smalldistCONF;
% name = {'fields'}

for aa = 1:6
tau_iniall{aa} = [];
tau_confall{aa} =[];
end
    
    stdbins= 6;
  for fieldsect =1:size(spike_smalldistINI_PlC,4)  
    for animal=1:size(spike_smalldistINI_PlC,1)
        animal
        for i_trial = 1:size(spike_smalldistINI_PlC,2)
            i_trial
            nn=0;
            for x_cell = 1:size(spike_smalldistINI_PlC,3)
                for y_cell = 1:size(spike_smalldistINI_INT,3)
                    nn=nn+1; 
                   for i_bin=1:stdbins

                    if size(spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistINI_INT{animal,i_trial,y_cell},1)<40
                    tau_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    z_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    prob_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    else
                       sz1=size(spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect},1);
%                        sz1=size(spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect},1);

                          
                           inds1=(i_bin-1)*floor(sz1/stdbins)+1:i_bin*floor(sz1/stdbins);
                           stdbins_indsini= [1:sz1]';
                           if stdbins==2
                               stdbins_indsini=inds1;
                           else
                               stdbins_indsini(inds1,:)=[];
                           end
                          
                       
                       x_ini= spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsini,2);
                       y_ini=spike_smalldistINI_INT{animal,i_trial,y_cell}(stdbins_indsini,2);
                      [tau_ini{animal,i_trial,fieldsect}(nn,i_bin), z_ini{animal,i_trial,fieldsect}(nn,i_bin),...
                           prob_ini{animal,i_trial,fieldsect}(nn,i_bin)]=...
                           calculate_kendall_sep(x_ini,y_ini);
                       end  
                       if size(spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistCONF_INT{animal,i_trial,y_cell},1)<40
                        tau_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        z_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        prob_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        else
                        sz2=size(spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1);
%                         sz2=size(spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1);
                        
                           inds2=(i_bin-1)*floor(sz2/stdbins)+1:i_bin*floor(sz2/stdbins);
                           stdbins_indsconf= [1:sz2]';
                           if stdbins==2
                               stdbins_indsconf=inds2;
                           else
                               stdbins_indsconf(inds2,:)=[];
                            end
                       
                       
                       x_conf=spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsconf,2);
                       y_conf=spike_smalldistCONF_INT{animal,i_trial,y_cell}(stdbins_indsconf,2);
                       
%                        x_ini= spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsini,2);
%                        y_ini=spike_alldistINI_INT{animal,i_trial,y_cell}(stdbins_indsini,2);
%                        x_conf=spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsconf,2);
%                        y_conf=spike_alldistCONF_INT{animal,i_trial,y_cell}(stdbins_indsconf,2);
                       
                       [tau_conf{animal,i_trial,fieldsect}(nn,i_bin),z_conf{animal,i_trial,fieldsect}(nn,i_bin)...
                          ,prob_conf{animal,i_trial,fieldsect}(nn,i_bin)]=...
                           calculate_kendall_sep(x_conf,y_conf);
                       end
                       end
                end
                end
            
                std_tau_ini{animal,i_trial,fieldsect}(:,1)=nanstd(tau_ini{animal,i_trial,fieldsect},0,2);
                std_tau_conf{animal,i_trial,fieldsect}(:,1)=nanstd(tau_conf{animal,i_trial,fieldsect},0,2);
%                 std_z_ini{animal,i_trial}=nanstd(z_ini{animal,i_trial},2);
%                 std_z_conf{animal,i_trial}=nanstd(z_conf{animal,i_trial},2);
%                 std_prob_ini{animal,i_trial}=nanstd(prob_ini{animal,i_trial},2);
%                 std_prob_conf{animal,i_trial}=nanstd(prob_conf{animal,i_trial},2);
        end
        end
    end     
    save(strcat('tauposition_small_stds_133ms_',name,'.mat'), 'std_tau_ini', 'std_tau_conf','tau_ini','tau_conf','prob_ini','prob_conf','z_ini','z_conf')


    clear std_tau_ini std_tau_conf tau_ini tau_conf prob_ini prob_conf z_ini z_conf
    stdbins=2;
    for fieldsect=1:size(spike_smalldistINI_PlC,4)
    for animal=1:size(spike_smalldistINI_PlC,1)
        animal
        for i_trial = 1:size(spike_smalldistINI_PlC,2)
            i_trial
            nn=0;
            for x_cell = 1:size(spike_smalldistINI_PlC,3)
                for y_cell = 1:size(spike_smalldistINI_INT,3)
                    nn=nn+1; 
                for i_bin=1:stdbins

                    if size(spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistINI_INT{animal,i_trial,y_cell},1)<40
                    tau_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    z_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    prob_ini{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                    else
                       sz1=size(spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect},1);
%                        sz1=size(spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect},1);

                          
                           inds1=(i_bin-1)*floor(sz1/stdbins)+1:i_bin*floor(sz1/stdbins);
                           stdbins_indsini= [1:sz1]';
                           if stdbins==2
                               stdbins_indsini=inds1;
                           else
                               stdbins_indsini(inds1,:)=[];
                           end
                          
                       
                       x_ini= spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsini,2);
                       y_ini=spike_smalldistINI_INT{animal,i_trial,y_cell}(stdbins_indsini,2);
                      [tau_ini{animal,i_trial,fieldsect}(nn,i_bin), z_ini{animal,i_trial,fieldsect}(nn,i_bin),...
                           prob_ini{animal,i_trial,fieldsect}(nn,i_bin)]=...
                           calculate_kendall_sep(x_ini,y_ini);
                       end  
                       if size(spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistCONF_INT{animal,i_trial,y_cell},1)<40
                        tau_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        z_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        prob_conf{animal,i_trial,fieldsect}(nn,1:stdbins)=NaN(1,stdbins);
                        else
                        sz2=size(spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1);
%                         sz2=size(spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1);
                        
                           inds2=(i_bin-1)*floor(sz2/stdbins)+1:i_bin*floor(sz2/stdbins);
                           stdbins_indsconf= [1:sz2]';
                           if stdbins==2
                               stdbins_indsconf=inds2;
                           else
                               stdbins_indsconf(inds2,:)=[];
                            end
                       
                       
                       x_conf=spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsconf,2);
                       y_conf=spike_smalldistCONF_INT{animal,i_trial,y_cell}(stdbins_indsconf,2);
                       
%                        x_ini= spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsini,2);
%                        y_ini=spike_alldistINI_INT{animal,i_trial,y_cell}(stdbins_indsini,2);
%                        x_conf=spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(stdbins_indsconf,2);
%                        y_conf=spike_alldistCONF_INT{animal,i_trial,y_cell}(stdbins_indsconf,2);
                       
                       [tau_conf{animal,i_trial,fieldsect}(nn,i_bin),z_conf{animal,i_trial,fieldsect}(nn,i_bin)...
                          ,prob_conf{animal,i_trial,fieldsect}(nn,i_bin)]=...
                           calculate_kendall_sep(x_conf,y_conf);
                       end
                       end
                end
                end
                std_tau_ini{animal,i_trial,fieldsect}(:,1)=nanstd(tau_ini{animal,i_trial,fieldsect},0,2);
                std_tau_conf{animal,i_trial,fieldsect}(:,1)=nanstd(tau_conf{animal,i_trial,fieldsect},0,2);
%                 std_z_ini{animal,i_trial}=nanstd(z_ini{animal,i_trial},2);
%                 std_z_conf{animal,i_trial}=nanstd(z_conf{animal,i_trial},2);
%                 std_prob_ini{animal,i_trial}=nanstd(prob_ini{animal,i_trial},2);
%                 std_prob_conf{animal,i_trial}=nanstd(prob_conf{animal,i_trial},2);

        end
            
    end
    end
    
    save(strcat('tauposition_small_halves_133ms_',name,'.mat'), 'std_tau_ini', 'std_tau_conf','tau_ini','tau_conf','prob_ini','prob_conf','z_ini','z_conf')
     clear std_tau_ini std_tau_conf tau_ini tau_conf prob_ini prob_conf z_ini z_conf
     
    for fieldsect=1:size(spike_smalldistINI_PlC,4)
     for animal=1:size(spike_smalldistINI_PlC,1)
         animal
        for i_trial = 1:size(spike_smalldistINI_PlC,2)
            i_trial
                    nn=0;
            for x_cell = 1:size(spike_smalldistINI_PlC,3)
                for y_cell = 1:size(spike_smalldistINI_INT,3)
                 nn=nn+1;
                if size(spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistINI_INT{animal,i_trial,y_cell},1)<40
                tau_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
%                 tau_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
                z_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
%                 z_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
                prob_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
%                 prob_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
                else
                x_ini=spike_smalldistINI_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
                y_ini=spike_smalldistINI_INT{animal,i_trial,y_cell}(:,2);
               
%                 
%                 x_ini=spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
%                 y_ini=spike_alldistINI_INT{animal,i_trial,y_cell}(:,2);
%                 x_conf=spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
%                 y_conf=spike_alldistCONF_INT{animal,i_trial,y_cell}(:,2);

        
                    [tau_ini{animal,i_trial,fieldsect}(nn,1),...
                      z_ini{animal,i_trial,fieldsect}(nn,1),...
                      prob_ini{animal,i_trial,fieldsect}(nn,1)]=...
                      calculate_kendall_sep(x_ini,y_ini);
                end
                 if size(spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect},1)<40 || size(spike_smalldistCONF_INT{animal,i_trial,y_cell},1)<40
%                 tau_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
                tau_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
%                 z_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
                z_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
%                 prob_ini{animal,i_trial,fieldsect}(nn,1)=NaN;
                prob_conf{animal,i_trial,fieldsect}(nn,1)=NaN;
                else
               
                x_conf=spike_smalldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
                y_conf=spike_smalldistCONF_INT{animal,i_trial,y_cell}(:,2);
%                 
%                 x_ini=spike_alldistINI_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
%                 y_ini=spike_alldistINI_INT{animal,i_trial,y_cell}(:,2);
%                 x_conf=spike_alldistCONF_PlC{animal,i_trial,x_cell,fieldsect}(:,2);
%                 y_conf=spike_alldistCONF_INT{animal,i_trial,y_cell}(:,2);

        
                    [tau_conf{animal,i_trial,fieldsect}(nn,1),...
                     z_conf{animal,i_trial,fieldsect}(nn,1)...
                      ,prob_conf{animal,i_trial,fieldsect}(nn,1)]=...
                      calculate_kendall_sep(x_conf,y_conf);
                end
                end
            end
        end
     end
    save(strcat('taus_position_133ms_small_',name,'.mat'), 'tau_ini', 'tau_conf','z_ini', 'z_conf', 'prob_ini', 'prob_conf')
    end
end
