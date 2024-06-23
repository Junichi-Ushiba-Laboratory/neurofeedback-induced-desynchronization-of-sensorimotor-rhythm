%% TF
file_TF = dir(fullfile('path_tf','*.fig'));
[file_TF,num_file] = vi.fullPath(file_TF);
close all
col = UtilTimeFrequencyVisualize.colormap_data;
for i_file = 1 : num_file
    open(file_TF{i_file})
    %%
%     set(gcf,'Color','w','Position',[100 901 305 194]);
    set(gcf,'Color','w','Position',[100 977 133 98]);
    set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
    ylim([3 35])
    %colorbar off
%     ylabel(''); yticklabels('')
    drawnow
    colormap(col)
end