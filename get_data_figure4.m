%% MEP-SICI
%% data acquisition
try
    path_result = '/Volumes/NAS21/03_individual_graduated_students/2021 Muraoka/Documents/MATLAB/NFT_Experiment/MainExperiments/All_Results';
    old = cd(path_result)
    Sub_n = 22; % Sub23 and Sub24 were no data
    Session = {'pre','post'};
    group = readtable('Subject_Group.xlsx');
    condition_data = logical(group.Condition(1:Sub_n)); % 0 : sham, 1 : real
    cond_matrix = logical([ones(Sub_n,1),condition_data,~condition_data]); % (:,1) : All, (:,2) : Real, (*,3) : Sham
    Condition = {'All','Real','Sham'};
    clear group
    SICI_data = zeros(2,3,Sub_n);
    spMEP_data = zeros(2,3,Sub_n);


    for i = [1 3 4 9 10 13 14 15 17 18 19 20 21 22]%1:Sub_n
        ID = strcat('Sub',sprintf('%02d',i));
        filename_MP = strcat('TMS_exp/',ID,'_preparation_results.mat');
        load(filename_MP);
        SICI_data(:,:,i) = SICI_all;
        spMEP_data(:,:,i) = spMEP_all;

        clear SICI_all spMEP_all ID
    end

catch
    old = cd;
end



%% Reject subjects
%reasons of rejection : 6 no MEP in post sessions,7,11,12,16 no SICI, 8,23,24 no response due to high RMT
reject_subject_ID = [2 5 6 7 8 11 12 16];
includ_subject_ID = 1:Sub_n;
includ_subject_ID(reject_subject_ID) = [];
cond_matrix(reject_subject_ID,:) = false;
cd(old)
%switch_mep = 'single';
switch_mep = 'SICI';
switch switch_mep
    case 'single'
        %% data_single_pulse
        data_real = spMEP_data(:,:,cond_matrix(:,2)); %[evaluation-time stimulation-time sub]
        data_sham = spMEP_data(:,:,cond_matrix(:,3));
        label_y = 'Amplitude [mV]';
        yl = [0 1.8];
    case 'SICI'
        data_real = SICI_data(:,:,cond_matrix(:,2)); %[evaluation-time stimulation-time sub]
        data_sham = SICI_data(:,:,cond_matrix(:,3)); %[evaluation-time stimulation-time sub]
        yl = [20 140];
        label_y = 'SICI, %';
end

if 0 == 1
    %% export
    data_real_ = permute(data_real,[3,2,1]);
    data_sham_  = permute(data_sham,[3,2,1]);

    data_real_ = [data_real_(:,:,1);data_real_(:,:,2)];
    data_sham_ = [data_sham_(:,:,1);data_sham_(:,:,2)];

    data_real_(:,end+1) = 1;
    data_real_(:,end+1) = 1;
    data_real_(1:end/2,end) = 0;

    data_sham_(:,end+1) = 0;
    data_sham_(:,end+1) = 1;
    data_sham_(1:end/2,end) = 0;

    data_table = [data_real_;data_sham_];
    data_table = array2table(data_table ,'VariableNames',{'Resting';'50%RT';'80%RT';'Group';'Pre/Post'});
    writetable(data_table,sprintf('data_%s.csv',switch_mep))
end
% close all
if 0 == 1
%% time course
close all
for i_gp = 1 : 2
    col_pre = [0.2 0.2 0.2]';
    col_post = vi.get_color(3,3-i_gp);

    if i_gp == 1
        %% real
        data_pre = sq(data_real(1,:,:))';
        data_post = sq(data_real(2,:,:))';
    elseif i_gp == 2
        data_pre = sq(data_sham(1,:,:))';
        data_post = sq(data_sham(2,:,:))';
        col_post = [101	61	58]'/255;
    end
    vi.figure();
    vi.set_position([1 1 137 169]);
    a = notBoxPlot(data_pre,[1,3,5]);
    hold on;
    b = notBoxPlot(data_post,[1.5:2:5.5]);

    vi.pairwiseplot_nbp(a,col_pre,0.5);
    vi.pairwiseplot_nbp(b,col_post,0.5);
    
    a = vi.moduBoxplot(a,4,col_pre);
    b = vi.moduBoxplot(b,4,col_post);
    chg_width = @(x) set(x.mu,'LineWidth',1);
    a = arrayfun(chg_width,a,'UniformOutput',false);
    b = arrayfun(chg_width,b,'UniformOutput',false);    
    if ~isempty(yl)
        ylim(yl);
    end
    xticks(1.25:2:5.25)
    xticklabels({'Rest';'50%RT';'80%RT'})
    ylabel(label_y)
    set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
end
end

if 0 == 1
%% diff
%close all
switch switch_mep
    case 'single'
        label_y = '\Delta Amplitude [mV]';
        yl = [-0.6 0.8];
    case 'SICI'
        label_y = '\Delta SICI, %';
        yl = [-50 65];
end

diff_real = sq(data_real(2,:,:))'-sq(data_real(1,:,:))';
diff_sham = sq(data_sham(2,:,:))'-sq(data_sham(1,:,:))';
col_real = vi.get_color(3,2);
col_sham = [101	61	58]'/255;
%
vi.figure();
vi.set_position([1 1 137 169]);
a = notBoxPlot(diff_real,[1,3,5]);
hold on;
b = notBoxPlot(diff_sham,[1.5:2:5.5]);
a = vi.moduBoxplot(a,3,col_real);
b = vi.moduBoxplot(b,3,col_sham);

chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);    

xticks(1.25:2:5.25)
xticklabels({'Rest';'50%RT';'80%RT'})
ylabel(label_y)
ylim(yl)
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
end

if 0 ==1
    %% diff export

    diff_data = [diff_real;diff_sham];
    diff_data(:,end+1) = 1;
    diff_data(end/2+1:end,end) = 0;

    data_table = array2table(diff_data ,'VariableNames',{'Resting';'50%RT';'80%RT';'Group';});
    writetable(data_table,sprintf('diff_data_%s.csv',switch_mep))
end