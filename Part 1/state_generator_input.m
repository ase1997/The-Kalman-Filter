clear all
close all

%----------------------------setting up variables, inputs from user----------------------------%
T = 0.1;                        % sampling interval, value 9.396 from book 
N = 100;                        % no. of iterations, value from user (100 so that plots on same scale as in book fig 9.38)

sigma2_a = 40;                  % process (plant) noise's variance, value 9.395 from book
sigma2_r = 100;                 % measurement noise's variance, value 9.397 from book

F = [1 T; 0 1];                 % state transition matrix, equation 9.386 from book
G = [T^2/2; T];                 % input (control) transition matrix, equation 9.387 from book
C = [1 0];                      % output transition matrix, equation 9.390 from book

x_prev = [1000; -50];           % initialize [position(0); velocity(0)], values 9.393 & 9.394 from book
%----------------------------end----------------------------%  


%----------------------------initilize variables for plotting----------------------------%  
x_true = zeros(size(F,1), N);           % initialize matrix F_row-by-N to hold hold "grounth-truth" state vector values of postion and velocity with noise
x_noisy = zeros(size(G,2), N);          % initialize matrix G_column-by-N to hold position measurements (with noise)
%----------------------------end----------------------------%  


%----------------------------call function to generate state values----------------------------%  
[x_true, x_noisy] = state_generator(N, sigma2_a, sigma2_r, F, G, C, x_prev);     % return values for plotting
%----------------------------end----------------------------%  


%----------------------------plotting----------------------------%   
Nt = [1:N]'*T;                                      % steps
figure                                              % 1st figure
plot(Nt, x_true(1, :), Nt, x_noisy, ':k')           % for position - plot all values for "true" with noise and measurement with noise
legend('True', 'Noisy')
xlabel('t (s)')
ylabel('Position (m)')
axis([0, 10, 400, 1000])                            % scale to look like figure 9.38 in book
grid

figure                                              % 2nd figure
plot(Nt, x_true(2, :))                              % for velocity, plot all values for "true" with noise
legend('True')
xlabel('t (s)')
ylabel('Velocity (m/s)')
axis([0, 10, -100, 200])                            % scale to look like figure 9.38 in book
grid
%----------------------------end----------------------------%  