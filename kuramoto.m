function [] = kuramoto( K, N, time )
% Kuramoto phase oscillators. See:  https://en.wikipedia.org/wiki/Kuramoto_model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K: coupling parameter
% N: number of oscillators
% time: simulation time; T = 100*time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE INPUT: kuramoto( 8, 10, 2 )

cx = cos(linspace(0,2*pi,100)); % coordinates of the phase space (circle) 
cy = sin(linspace(0,2*pi,100));

y = 2*pi*rand(1,N);         % initial phase
omega = 3*randn(1,N);       % natural frequencies
tspan = (0:0.01:time);      % time

[T,Y] = ode45(@kuramoto_eq, tspan, y, [], K, N, omega);

order = zeros(length(Y),1); % order parameter 

for i = 1:size(Y)
    order(i) = 1/N*sum(exp(1i*Y(i,:)));
end


cmap = [0 0 0; hsv(N); 1 1 1];  % load colormap

sz = [500 550]/2;                                           % set plot window 
    screensize = get(0,'ScreenSize');
    xpos = ceil((screensize(3)-sz(2))/2); 
    ypos = ceil((screensize(4)-sz(1))/2); 
    hFig = figure(1);
    set(hFig, 'Position', [xpos ypos sz(2) sz(1)])
    
    plot(cx,cy,'k-')                                        % plot phase space
    hold on 
    
    axis([-1.5 1.5 -1.5 1.5])                               % set axis
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', [])
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', [])
    set(gca,'xtick',[])
    set(gca,'ytick',[])

M = getframe;

for i = 1:size(Y)
    
    sz = [500 550]/2;                                         % set plot window 
    screensize = get(0,'ScreenSize');
    xpos = ceil((screensize(3)-sz(2))/2); 
    ypos = ceil((screensize(4)-sz(1))/2); 
    hFig = figure(1);
    set(hFig, 'Position', [xpos ypos sz(2) sz(1)])
    
    plot(cx,cy,'k-')                                          % plot phase space
    hold on 
    
    axis([-1.5 1.5 -1.5 1.5])                                 % set axis
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', [])
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', [])
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    
    for j = 1:N                                 % plot oscillators
        plot(cos(Y(i,j)), sin(Y(i,j)), 'ko', 'MarkerSize', 5, 'MarkerFaceColor', cmap(j,:))
    end
    
    text(-0.6,1.35,['K = ', num2str(K),', T = ', num2str(i-1)],'Fontsize',12)
    
    re = (order(i)+conj(order(i)))/2;         % plot order parameter
    im = (order(i)-conj(order(i)))/(2*1i);
    
    plot([0, re], [0, im], 'k-')
    plot(re, im, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k')
   
    M = getframe;
    %exportgraphics(gcf,'kuramoto.gif','Append',true);
    
    hold off
    
 end
 
end

