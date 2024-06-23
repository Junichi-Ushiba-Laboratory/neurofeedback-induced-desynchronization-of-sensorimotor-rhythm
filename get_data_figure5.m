%% Group analysis Reaction time

vi =visualize_data;
data_real = Median_data(:,cond_matrix(:,2));
data_placebo = Median_data(:,cond_matrix(:,3));
data_all = [data_real',data_placebo'];
label_y = 'Reaction time [ms]';
close all
col_pre = [0.2 0.2 0.2]';
col_post = vi.get_color(3,3-i_gp);


col_post = [101	61	58]'/255;
vi.figure();
vi.set_position([1 1 315 169]); 
a = notBoxPlot(data_all(:,1:2),1:2);
hold on;
b = notBoxPlot(data_all(:,3:4),3:4);

vi.pairwiseplot_nbp(a,vi.get_color(3,2),0.5);
vi.pairwiseplot_nbp(b,col_post,0.5);

a = vi.moduBoxplot(a,4,[col_pre,vi.get_color(3,2)]);
b = vi.moduBoxplot(b,4,[col_pre,col_post]);
chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);    
if ~isempty(yl)
    ylim(yl);
end
xlim([0.5 4.5])
xticks(1:4)
xticks(1:4); xticklabels({'Pre-training';'Post-training';'Pre-training';'Post-training'})
ylabel(label_y)
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)

%%
diff_real = sq(data_real(2,:,:))'-sq(data_real(1,:,:))';
diff_sham = sq(data_placebo(2,:,:))'-sq(data_placebo(1,:,:))';
col_real = vi.get_color(3,2);
col_sham = [101	61	58]'/255;
%
vi.figure();
vi.set_position([1 1 137 169]);
a = notBoxPlot(diff_real,[1]);
hold on;
b = notBoxPlot(diff_sham,[2]);
a = vi.moduBoxplot(a,3,col_real);
b = vi.moduBoxplot(b,3,col_sham);

chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);    

xticks(1:2); xlim([0.5 2.5])
xticks(1:2); xticklabels({'Real-group';'Sham-group'})
ylabel(label_y)
% ylim(yl)
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)