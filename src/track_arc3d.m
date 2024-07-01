% this function plots arc between two points in 3d space
function [V1x,V2x,V3x,V4x] = track_arc3d(x,y,z,acc,scale,th1r,th1z,colorSpec1,colorSpec2,colorSpec3,colorSpec4)
P2=[x(1) y(1) z(1)];
P1=[x(2) y(2) z(2)];
P2p=scale*th1r*[x(1) y(1) z(1)];
P1p=scale*th1r*[x(2) y(2) z(2)];
P1new=P1-P1p;
P2new=P2-P2p;
x1=[P2new(1);P1new(1)]; y1=[P2new(2);P1new(2)];z1=[P2new(3);P1new(3)];

v1 = [x(1:end-1);y(1:end-1);z(1:end-1)]; % Vector from center to 1st point
va = [x1(1:end-1);y1(1:end-1);z1(1:end-1)]; % Vector from center to 1st point

r = sqrt(sum([x(1); y(1); z(1)].^2,1))

v2 = [x(2:end);y(2:end);z(2:end)]; % Vector from center to 2nd point
vb = [x1(2:end);y1(2:end);z1(2:end)]; % Vector from center to 2nd point

r1 = sqrt(sum([x1(1); y1(1); z1(1)].^2,1))
 k12=vecnorm_res(cross(v1, v2));
v3a = cross(cross(v1,v2),v1); % v3 lies in plane of v1 & v2 and is orthog. to v1
v3b = cross(cross(va,vb),va); % v3b lies in plane of v1 & v2 and is orthog. to v1

hold on
% th_r=0.14/30;th_z=0.14/75;
v3 = (r)*v3a./repmat(sqrt(sum(v3a.^2,1)),3,1); % Make v3 of length r
 v3le = (r1)*v3b./repmat(sqrt(sum(v3b.^2,1)),3,1); % Make v3 of length r

 % Let t range through the inner angle between v1 and v2
% tmax = atan2(sqrt(sum(cross(v1,v2).^2,1)),dot(v1,v2));
tmax = atan2(sqrt(sum(cross(v1,v3).^2,1)),dot(v1,v3));
t1max = atan2(sqrt(sum(cross(va,v3le).^2,1)),dot(va,v3le));

% acc=200;
 V1bl = zeros(3,sum(round(tmax*acc)));% preallocate
 V1bll = zeros(3,sum(round(tmax*acc)));
 V1bl2= zeros(3,sum(round(t1max*acc)));
 V1bl3= zeros(3,sum(round(t1max*acc)));
 
k = 0; % index in v
k1 = 0; % index in v
for i = 1:length(tmax)
    steps = round(tmax(i)*acc)+1; %Edited +1
    k = (1:steps) + k(end);
    t = linspace(0,tmax(i),steps);
    
     V1bll(:,k) = (v1(:,i)*cos(t)+v2(:,i)*sin(t));
    V1bl(:,k) = (v1(:,i)*cos(t)+v2(:,i)*sin(t))+ k12*th1z;
  

end
hold on
V1x= plot3(V1bl(1,:),V1bl(2,:),V1bl(3,:),'k')
 hold on
V2x= plot3(V1bll(1,:),V1bll(2,:),V1bll(3,:),'k')
 hold on

for i = 1:length(t1max)
    steps = round(t1max(i)*acc)+1; %Edited +1
    k1 = (1:steps) + k1(end);
    t1 = linspace(0,t1max(i),steps);

    V1bl2(:,k1) = (va(:,i)*cos(t1)+vb(:,i)*sin(t1));
    V1bl3(:,k1) = (va(:,i)*cos(t1)+vb(:,i)*sin(t1))+ k12*th1z;
end
V3x=plot3(V1bl2(1,:),V1bl2(2,:),V1bl2(3,:),'k')
hold on
V4x=plot3(V1bl3(1,:),V1bl3(2,:),V1bl3(3,:),'k')
hold on


 X=[V1bl2(1,:),fliplr(V1bl3(1,:))];
Y=[V1bl2(2,:),fliplr(V1bl3(2,:))];
Z=[V1bl2(3,:),fliplr(V1bl3(3,:))];
% colorSpec=[0.5,0.5,0.5];
% colorSpec1=[0,0,0.1];
h0=fill3(X,Y,Z,colorSpec1);
set(h0,'LineWidth',0.1)
hold on 
hold on 
X1=[V1bl(1,:),fliplr(V1bll(1,:))];
Y1=[V1bl(2,:),fliplr(V1bll(2,:))];
Z1=[V1bl(3,:),fliplr(V1bll(3,:))];
% colorSpec2=[1,0,0];
h1=fill3(X1,Y1,Z1,colorSpec2);
set(h1,'LineWidth',0.1)
hold on 
%we have considered only parallel curves, totally there are four curves,
%breadth direction can also be patched.
X2=[V1bl(1,:),fliplr(V1bl2(1,:))];
Y2=[V1bl(2,:),fliplr(V1bl2(2,:))];
Z2=[V1bl(3,:),fliplr(V1bl2(3,:))];
% colorSpec3=[0.8,0.8,0.8];
h2=fill3(X2,Y2,Z2,colorSpec3);
set(h2,'LineWidth',0.1)
hold on
X3=[V1bll(1,:),fliplr(V1bl3(1,:))];
Y3=[V1bll(2,:),fliplr(V1bl3(2,:))];
Z3=[V1bll(3,:),fliplr(V1bl3(3,:))];
% colorSpec4=[0.8,0.8,0.8];
h3=fill3(X3,Y3,Z3,colorSpec4);
set(h3,'LineWidth',0.1)
end