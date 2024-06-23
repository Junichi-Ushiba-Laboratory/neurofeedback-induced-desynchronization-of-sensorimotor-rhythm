close all
Mean_Sub_Score = S.Mean_Sub_Score;label_y = 'ERSP (Alpha), %';
%Mean_Sub_Score = S.Mean_Sub_Score2; label_y = 'ERSP (Beta), %';%beta
cond_matrix = S.cond_matrix;
close;


%%
%close all

col_real = vi.get_color(3,2);
col_sham = [101	61	58]'/255;
idx_training = 2:5;

vi = VisualizeData;
vi.figure();s
%vi.set_position([1 1 137 169]);
vi.set_position([1 1 114 147]);
a = notBoxPlot(Mean_Sub_Score(idx_training,cond_matrix(:,2))',[1:2:numel(idx_training)*2]);
hold on;
b = notBoxPlot(Mean_Sub_Score(idx_training,cond_matrix(:,3))',[1+0.5:2:numel(idx_training)*2+0.5]);

vi.pairwiseplot_nbp(a,col_real,0.5);
vi.pairwiseplot_nbp(b,col_sham,0.5);

a = vi.moduBoxplot(a,4,col_real);
b = vi.moduBoxplot(b,4,col_sham);
chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);
% if ~isempty(yl)
%     ylim(yl);
% end
xticks(1.25:2:numel(idx_training)*2+0.25)
xticklabels({'1';'2';'3';'4'})
ylabel(label_y)
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)

[212 147];%160]
%147
