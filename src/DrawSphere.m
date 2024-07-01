%PLOTTING FUNCTIONS
function []= DrawSphere (centre,radius)
r = radius;
[x,y,z] = sphere(50);
x0 = centre(1); y0 = centre(2); z0 = centre(3);
x = x*r + x0;
y = y*r + y0;
z = z*r + z0;

lightGrey = 0.9*[1 1 1]; % It looks better if the lines are lighter
surface(x,y,z,'FaceAlpha',.2,'FaceColor', lightGrey,'EdgeColor','none')
hold on
plot3(x0,y0,z0,'o')
text(centre(1)-0.01,centre(2)-0.01,centre(3),'O','fontsize',14,'Interpreter', 'latex');
axis equal % so the sphere isn't distorted
view([1 1 .5]) % adjust the viewing angle
end