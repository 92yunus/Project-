
% Solving two-dimensional diffusion equation without any heat-source
 % Solve  Ut = Uxx + Uyy
 % Parameters 
% Domain and Steps
bx = 2*pi;
by = 2*pi;
% Now comes the node numbers for x and y in spacing and t in time
Nx = 80; %(This will differ to observe behavior)
Ny = 80; %(This will differ to observe behavior)
Nt = 500; %(this will also change to observe behavior in time)
% Now Comes the increment size
dx = bx/(Nx - 1);
dy = by/(Ny - 1);
% Note dx and dy are the same: dx = dy for ease of use
% Satisfy time-speed condition | Studying the Effects of Diffusive CFL
c = 0.1; % speed
C = 0.08; % courant number (CFL condition C < 1);
dt = C*dx/c;
% Now define the field variables 
Un = zeros (Ny, Nx); % temperature
x = linspace (0, bx, Nx); % x distance
y = linspace (0, by, Ny); % y distance
[X, Y] = meshgrid(x, y); % what this meshing would do, is to visualize our psuedo-code into interactive results
% Now define the initial and boundary conditions as stated in Project-prompt
Un(:, :) = 0;  % This defines the time initiation 
t = 0;
% now looping 
for n = 1 : Nt
    Un = Uc;
    t = t + dt; % new time
    for i = 2:Nx-1 
        for j = 2:Ny-1
            %Un(j,i) = Uc(j, i) + ((dt/(dx.^2)).*((Un(j, i+1) + Un(j+1, i) - 4*Un(j, i) + Un(j, i-1) + Un(j-1, i)))); % explicit
            Un(j,i) = Uc(j, i) + ((dt/(dx.^2)).*((Uc(j, i+1) + Uc(j+1, i) - 4*Uc(j, i) + Uc(j, i-1) + Uc(j-1, i)))); % implicit 

        end
    end
% Now comes the boundary conditions 
% given are 
% 1 (ax = 0 < x  < bx = 2pi)  ,  2 ( ay = 0 < y < by = 2pi) ,
% u(x = ax, y) = phi_ab(y) , u(x = bx, y) = si_ab(y) ,
% First apply the Dirichlet Boudary conditions
Un (:, 1) = (cos(y*pi)-1).*cosh(2*pi-y);
Un (:, end) = (y.*y).*(sin(y/4));
% Now apply the Newman Boundary Conditions
Un (end, :) = Un (end-1, :);
Un (1, :) = Un (2, :);
% Visualize 
mesh(x, y, Un); axis ([0 bx 0 by 0 t]);
 title(sprintf('Time = % f seconds', t));
 Un;
end
