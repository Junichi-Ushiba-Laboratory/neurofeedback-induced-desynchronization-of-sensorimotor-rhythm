%% Topo
file_Topo = dir(fullfile('/path_topo','*.fig'));
[file_Topo,num_file] = vi.fullPath(file_Topo);
close all
for i_file = 1 : num_file
    open(file_Topo{i_file})
    drawnow
    set(gcf,'Color','w','Position',[100 941 165 154]);
    f = gcf;
    f.Renderer = 'painters';
    a = get(gca,'Children');
    a(1).LineWidth = 1;a(2).LineWidth = 1;;a(3).LineWidth = 1;
    a(4).MarkerSize = 0.5;
    a(6).LineWidth = 0.25;a(6).LineColor = ones(3,1)*0.4;
    pbaspect([1 1 1])
%     set(gcf,'Color','w','Position',[100 977 133 98]);
%     set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)
%     ylim([3 35])
    colorbar off
%     ylabel(''); yticklabels('')
    drawnow;
end