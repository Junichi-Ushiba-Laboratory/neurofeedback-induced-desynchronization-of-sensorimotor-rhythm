%% Corr

load('~/Dropbox/WIP/pj_Muraoka/ws_bu/Corr_ws.mat');
vi = visualize_data;
Color_real = vi.get_color(3,2);
Color_sham = [101	61	58]'/255;
%% delta ERD2(beta) and delta ERD(alpha)
close all
Marker_size = 32;
disp("-------------------------------------------------------------------------");
disp("----- delta alpha and delta beta -----");
delta_ERD_mdl = fitlm(delta_ERD,delta_ERD2);

[r,p] = corrcoef(delta_ERD,delta_ERD2);
disp(strcat('r = ',num2str(r(1,2)),'p = ',num2str(p(1,2))));

crr_fig = figure('Name','delta alpha and delta beta','Color','w','Position',[266 1306 114 147]);
ax_crr  = axes('Parent',crr_fig);
hold on
if p(1,2) < p_threshold || abs(r(1,2)) > r_threshold
    l = plotAdded(delta_ERD_mdl);
    disp(delta_ERD_mdl);
    l(1).delete;
    l(2).LineWidth = 1.5; l(2).Color = [0 0 0];
    l(3).LineWidth = 2; l(3).Color = [0 0 0];
end
fff=scatter(delta_ERD(cond_matrix(:,2)),delta_ERD2(cond_matrix(:,2)),Marker_size,'filled','MarkerFaceColor',Color_real);
ffff=scatter(delta_ERD(cond_matrix(:,3)),delta_ERD2(cond_matrix(:,3)),Marker_size,'filled','MarkerFaceColor',Color_sham);
hold off
xlabel('\Delta ERSP (Alpha), %','Interpreter','tex');
ylabel('\Delta ERSP (Beta), %','Interpreter','tex');
title(strcat('r = ',num2str(r(1,2)),', p = ',num2str(p(1,2))));
%l = legend([fff,ffff],{'Real-group','Sham-group'});
legend off
set(gca,'FontName','Helvetica','FontSize',8,'LineWidth',0.8)

xlim([-25 25])
