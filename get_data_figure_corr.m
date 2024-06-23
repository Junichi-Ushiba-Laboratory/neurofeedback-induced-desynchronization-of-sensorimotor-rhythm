clear
load('path_corr');
vi = visualize_data;
Color_real = vi.get_color(3,2);
Color_sham = [101	61	58]'/255;

%%
spMEP_data_pre = sq(spMEP_data(1,:,includ_subject_ID))';
spMEP_data_post = sq(spMEP_data(2,:,includ_subject_ID))';
spMEP_data_diff = spMEP_data_post-spMEP_data_pre;

data_concat = [
[(Median_data(2,TMS_applied_ID)-Median_data(1,TMS_applied_ID))]',...
    spMEP_data_diff(:,3),...
[(SICI_data_all(:,6)-SICI_data_all(:,3))],...%,[SICI_data_all(:,5)-SICI_data_all(:,2)], [SICI_data_all(:,4)-SICI_data_all(:,1)]],...
[(Mean_Sub_Score(end,TMS_applied_ID)-Mean_Sub_Score(1,TMS_applied_ID))]'];%,...
%[(Mean_Sub_Score(5,includ_subject_ID)-Mean_Sub_Score(2,includ_subject_ID))]'];


[rho,p] = partialcorr(data_concat) %,'Rows','complete')
rho(rho == diag(rho)) = 1;
%%
close all

% features = {'RT';'MEP rest';'MEP 50%RT';'MEP 80%RT';'SICI rest';'SICI 50%RT';'SICI 80%RT';;'ERD'};
features = {'RT';'MEP';'SICI';'ERD'};
features1 = {'\Delta RT';'\Delta MEP';'\Delta SICI';'\Delta ERSP'};
vi = VisualizeData;
vi.line_width = 1
rho_ = rho;
rho_(p>0.05) = 0;
col  = UtilTimeFrequencyVisualize.colormap_data;
col(end/2-3:end/2+3,:) = 1;
col(end,:) = 0;
vi.figure_square;
imagesc(rho_); colormap(col)
xticks(1:size(rho_,1)); xticklabels({'';'';'';'';});
yticks(1:size(rho_,2)); yticklabels(features1);
vi.set_box(1);
hold on;
lines = vi.plotGrid(size(rho_,1),size(rho_,2));
off_legend = @(x)vi.off_legend(x);
arrayfun(off_legend,lines);
pbaspect([ 1 1 1]);
title('Post-Pre')
vi.set_colorbar('Partial correlation',8,1);
vi.set_position([1 1612 237 150]);
vi.set_fig(4,8)
%caxis([-1 0])
%%
home
for i = 1 : size(rho_,1)
    for j = i : size(rho_,2)
        if p(i,j) ~=0 && p(i,j) < 0.05
            fprintf('%d,%d, %s-%s: %s\n',i,j,features{i},features{j},UtilStat.printCorr(rho_(i,j),p(i,j)));
        end
    end
end
%% plot
close all
Marker_size = 30;
vi = VisualizeData;
vi.is_mod_font_size = 0;
vi.line_width = 1;
vi.figure;
[mdl,a] = testCorr(data_concat(:,3),data_concat(:,1),1);
hold on;

idx_sub_real = cond_matrix(TMS_applied_ID,2);
idx_sub_sham = cond_matrix(TMS_applied_ID,3);
scatter(data_concat(idx_sub_real,3),data_concat(idx_sub_real,1),Marker_size,'filled','MarkerFaceColor',Color_real,'MarkerEdgeColor',Color_real);
scatter(data_concat(idx_sub_sham,3),data_concat(idx_sub_sham,1),Marker_size,'filled','MarkerFaceColor',Color_sham,'MarkerEdgeColor',Color_sham);
hold off
ylabel('\Delta RT [ms]','Interpreter','tex');
xlabel('\Delta SICI %','Interpreter','tex');
vi.set_fig(4,8);
vi.set_position([1 1612 170 150])

xlim([-30 50])
ylim([-40 30]);
drawnow;
%
vi.figure;
drawnow;
[mdl,a] = testCorr(data_concat(:,4),data_concat(:,3),1);
hold on;

idx_sub_real = cond_matrix(TMS_applied_ID,2);
idx_sub_sham = cond_matrix(TMS_applied_ID,3);

scatter(data_concat(idx_sub_real,4),data_concat(idx_sub_real,3),Marker_size,'filled','MarkerFaceColor',Color_real,'MarkerEdgeColor',Color_real);
scatter(data_concat(idx_sub_sham,4),data_concat(idx_sub_sham,3),Marker_size,'filled','MarkerFaceColor',Color_sham,'MarkerEdgeColor',Color_sham);
hold off
xlabel('\Delta ERD, %','Interpreter','tex');
ylabel('\Delta SICI %','Interpreter','tex');
drawnow;
vi.set_position([1 1612 170 150]);
vi.set_fig(4,8);

ylim([-30 50])
xlim([-25 15])
drawnow;
%% multiple regression
%delta_RT_ = delta_RT(includ_subject_ID)';
delta_RT_ = (Median_data(2,TMS_applied_ID)-Median_data(1,TMS_applied_ID));%./(Median_data(1,includ_subject_ID));
%%
%mdl = fitlm(data_concat(:,[2:end]),delta_RT_);
%UtilMultipleRegression
%%
RT_SICI = [(Median_data(2,TMS_applied_ID)-Median_data(1,TMS_applied_ID))',(SICI_data_all(:,6)-SICI_data_all(:,3))];
[r_RT_SICI,p_RT_SICI] = corr(RT_SICI(:,1),RT_SICI(:,2))
%%
SICI_ERD = [(SICI_data_all(:,6)-SICI_data_all(:,3)),delta_ERD(TMS_applied_ID)' ];
[r_SICI_ERD,p_SICI_ERD] = corr(SICI_ERD(:,1),SICI_ERD(:,2))