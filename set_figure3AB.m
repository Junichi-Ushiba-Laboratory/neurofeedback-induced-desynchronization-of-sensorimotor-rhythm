%% ERD
path_figure = 'path_ERD';
file_TF = dir(fullfile(path_figure,'*.fig'));
[file_TF,num_file] = vi.fullPath(file_TF);

close all
for i_file = 1 : num_file
    open(file_TF{i_file})
end
drawnow;
%% get data
figure(2)
%%
c = get(gca,'Children');
c = findobj(c,'type','Line');

cx = {c(:).XData};
cx = cat(1,cx{:});

cy = {c(:).YData};
cy = cat(1,cy{:});

data_real = cy(12:end,:);
data_sham = cy(1:11,:);
%% export
table_result = cy;
table_result(:,end+1) = 1;
table_result(1:end/2,end) = 0;
table_result = array2table(table_result,"VariableNames",{'Pre-eval','Post-eval','Group'});

writetable(table_result,'Result_ERSP.csv')
%%
%vi.figure([1 1306 265 150])
col_real = vi.get_color(3,2);
col_sham = [101	61	58]'/255;

vi.figure([1 1306 212 147])
a = notBoxPlot(data_real,[1 2]); hold on ;
b = notBoxPlot(data_sham,[3 4]);xlim([0.5 4.5]);

vi.moduBoxplot(a,4,vi.get_color(3,2))
vi.moduBoxplot(b,4,col_sham)

vi.pairwiseplot_nbp(a,0.5,0.5)
vi.pairwiseplot_nbp(b,0.5,0.5)
chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);
xticks(1:4); xticklabels({'Pre-training';'Post-training';'Pre-training';'Post-training'})
%ylabel('SMR-ERD, %')
ylabel('ERSP, %')
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
%
%vi.figure([266 1306 141 150])
vi.figure([266 1306 114 147])
a = notBoxPlot(data_real(:,2)-data_real(:,1),[1]); hold on ;
b = notBoxPlot(data_sham(:,2)-data_sham(:,1),[2]);xlim([0.5 2.5]);
ylabel('\Delta ERSP, %')
vi.moduBoxplot(a,4,vi.get_color(3,2))
vi.moduBoxplot(b,4,col_sham)
chg_width = @(x) set(x.mu,'LineWidth',1);
a = arrayfun(chg_width,a,'UniformOutput',false);
b = arrayfun(chg_width,b,'UniformOutput',false);
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
xticks(1:2); xticklabels({'Real-group';'Sham-group'})
%%
[h,p,~,s] = ttest2(data_real(:,2)-data_real(:,1),data_sham(:,2)-data_sham(:,1));
