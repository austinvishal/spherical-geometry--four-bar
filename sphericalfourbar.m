% syms alpha1 alpha2 alpha3 alpha4 theta beta gamma phi real
% Points= [[1,0,0]; [0.8668,0.4986,0.0045]; [0.4292,0.2571,0.8659];[0,1,0]];
% Links= {{'P1','P2','I'},{'P2','P3'},{'P3','P4'},{'P4','P1','G'}};
% 
% % Fixed- P1,P4, Input- P2, State- P3
% P1=Points(1,:)/norm(Points(1,:));
% P2=Points(2,:)/norm(Points(2,:));
% P3=Points(3,:)/norm(Points(3,:));
% P4=Points(4,:)/norm(Points(4,:));
% alpha1=deg2rad(45.485);
% alpha2=deg2rad(85.811);
% alpha3=deg2rad(93.681);
% alpha4=deg2rad(34.272);
% alpha=[50, 85, 85, 160];
 set(gcf, 'color', 'white','units','pixels','position',[0 0 1920 1080]);
light('style','local','position',[0 0 3],'color',[1 1 1])
 view(1.730381126596186e+02,17.580255852715169)
%  vidObj=VideoWriter('spherical4bar2.mp4');
%  vidObj.FrameRate = 24;
%  open(vidObj);
alpha=[110, 160, 160, 110];
alpha1=deg2rad(alpha(1));
alpha2=deg2rad(alpha(2));
alpha3=deg2rad(alpha(3));
alpha4=deg2rad(alpha(4));
% th_r=0.14/30;th_z=2*0.14/75;
th_r=0.14/30;th_z=2*0.14/75; % related to spherical arc link
%% input vectors
% theta is input angle phi is output angle
% theta_min=acos((cos(alpha3-alpha2)-cos(alpha1)*cos(alpha4))/(sin(alpha1)*sin(alpha4)));
% theta_max=acos((cos(alpha3+alpha2)-cos(alpha1)*cos(alpha4))/(sin(alpha1)*sin(alpha4)));
%  theta=theta_min;
%  theta=pi;
%  for theta=0
   for theta=0:0.08:2*pi/8
%% input output equation
A1= sin(alpha1)*sin(alpha3)*sin(theta);
B1= cos(alpha1)*sin(alpha3)*sin(alpha4)-sin(alpha1)*sin(alpha3)*cos(alpha4)*cos(theta);
C1= cos(alpha1)*cos(alpha3)*cos(alpha4)+sin(alpha1)*cos(alpha3)*sin(alpha4)*cos(theta)-cos(alpha2);
L1= (-A1+(A1^2+B1^2-C1^2)^0.5)/(C1-B1);
L2=(-A1-(A1^2+B1^2-C1^2)^0.5)/(C1-B1);
% NOTE here we used atan2. with atan + - two solutions exist
% phi=2*atan(L1);
% phi=2*atan(L2);
phi=2*atan2((-A1-(A1^2+B1^2-C1^2)^0.5),(C1-B1))
%%
a=[sin(alpha4);cos(alpha4);0];
b=[cos(alpha1)*sin(alpha4)-sin(alpha1)*cos(alpha4)*cos(theta);...
    cos(alpha1)*cos(alpha4)+sin(alpha1)*sin(alpha4)*cos(theta);...
    sin(alpha1)*sin(theta)];
c=[sin(alpha3)*cos(phi); cos(alpha3);sin(alpha3)*sin(phi)];
d=[0;1;0];

% %% input output equation
% A1= sin(alpha1)*sin(alpha3)*sin(theta);
% B1= cos(alpha1)*sin(alpha3)*sin(alpha4)-sin(alpha1)*sin(alpha3)*cos(alpha4)*cos(theta);
% C1= cos(alpha1)*cos(alpha3)*cos(alpha4)+sin(alpha1)*cos(alpha3)*sin(alpha4)*cos(theta)-cos(alpha2);
% L1= (-A1+(A1^2+B1^2-C1^2)^0.5)/(C1-B1);
% L2=(-A1-(A1^2+B1^2-C1^2)^0.5)/(C1-B1);
% % NOTE here we used atan2. with atan + - two solutions exist
% % phi=2*atan(L1);
% % phi=2*atan(L2);
% phi=2*atan2((-A1-(A1^2+B1^2-C1^2)^0.5),(C1-B1))
%% relation between coupling link with respect to input link by angle beta
beta = acos((sin(alpha3)*sin(alpha4)*cos(phi)+cos(alpha3)*cos(alpha4)-cos(alpha1)*cos(alpha2))/(sin(alpha1)*sin(alpha2)));
%% relation between coupling link with respect to output link by angle gamma
gamma = acos((sin(alpha1)*sin(alpha4)*cos(theta)+cos(alpha1)*cos(alpha4)-cos(alpha3)*cos(alpha2))/(sin(alpha2)*sin(alpha3)));

% % displacement of the output link
% A2= sin(alpha1)*sin(alpha3)*sin(phi);
% B2= sin(alpha1)*(cos(alpha3)*sin(alpha4)-sin(alpha3)*cos(alpha4)*cos(phi));
% C2= cos(alpha1)*cos(alpha3)*cos(alpha4)+cos(alpha1)*sin(alpha3)*sin(alpha4)*cos(phi)-cos(alpha2);
% M1= (-A2+(A2^2+B2^2-C2^2)^0.5)/(C2-B2);
% M2=(-A2-(A2^2+B2^2-C2^2)^0.5)/(C2-B2);
% % NOTE here we used atan2. with atan + - two solutions exist
% % theta=2*atan(M1);
% theta=2*atan2((-A2+(A2^2+B2^2-C2^2)^0.5),(C2-B2));
hold off
delete(gca)
%   DrawSphere([0,0,0],1);
% hold on
track_arc3d([a(1) ;b(1)],[a(2) ;b(2)],[a(3) ;b(3)],200,6,th_r,th_z,[1,0,0],[1,0,0],[1,0,0],[1,0,0])
% hold on 
track_arc3d([b(1) ;c(1)],[b(2) ;c(2)],[b(3) ;c(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
% hold on 
track_arc3d([c(1) ;d(1)],[c(2) ;d(2)],[c(3) ;d(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
% hold on 
track_arc3d([a(1) ;d(1)],[a(2) ;d(2)],[a(3) ;d(3)],200,6,th_r,th_z,[1,0,1],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])

text(a(1)-0.01,a(2)-0.01,a(3),'A','fontsize',14,'Interpreter', 'latex');
hold on
 text(b(1)-0.01,b(2)-0.01,b(3),'B','fontsize',14,'Interpreter', 'latex');
hold on
 text(c(1)-0.01,c(2)-0.01,c(3),'C','fontsize',14,'Interpreter', 'latex');
hold on
text(d(1)-0.01,d(2)-0.01,d(3),'D','fontsize',14,'Interpreter', 'latex');
hold on
lh1 =plot3([a(1) 0]',[a(2) 0]',[a(3) 0]','Color' , 'r', 'LineWidth', 1, 'LineStyle',':'); %ax2
lh1.Color = [lh1.Color 0.5];
hold on
lh2 =plot3([b(1) 0]',[b(2) 0]',[b(3) 0]','Color' , 'r', 'LineWidth', 1, 'LineStyle',':');
lh2.Color = [lh2.Color 0.5];
hold on
lh3 =plot3([c(1) 0]',[c(2) 0]',[c(3) 0]','Color' , 'r', 'LineWidth', 1, 'LineStyle',':');
lh3.Color = [lh3.Color 0.5];
hold on
lh4 =plot3([d(1) 0]',[d(2) 0]',[d(3) 0]','Color' , 'r', 'LineWidth', 1, 'LineStyle',':');
lh4.Color = [lh4.Color 0.5];
hold off
% track_arc3d([a(1) ;b(1)],[a(2) ;b(2)],[a(3) ;b(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
% % hold on 
% track_arc3d([b(1) ;c(1)],[b(2) ;c(2)],[b(3) ;c(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
% % hold on 
% track_arc3d([c(1) ;d(1)],[c(2) ;d(2)],[c(3) ;d(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
% % hold on 
% track_arc3d([a(1) ;d(1)],[a(2) ;d(2)],[a(3) ;d(3)],200,6,th_r,th_z,[0.5,0.5,0.5],[1,1,1],[0.8,0.8,0.8],[0.8,0.8,0.8])
%  hold off
 %Lighting
%     light('style','local','position',[0 0 3],'color',[1 1 1])
view(1.730381126596186e+02,17.580255852715169)
     axis vis3d
box on 
grid off 
DrawSphere([0,0,0],1);
drawnow
pause(0.1)
  hold off
%   delete(gca)
%     currFrame= getframe(gcf);
%            writeVideo(vidObj, currFrame);
%   delete(obj1);delete(obj2);delete(obj3);delete(obj4);
% h=[V1x,V2x,V3x,V4x,V11x,V22x,V33x,V44x,V111x,V222x,V333x,V444x,V1111x,V2222x,V3333x,V4444x];
% delete(h);
 end
%        close(gcf)
%   close(vidObj);
% DrawSphere([0,0,0],1);
