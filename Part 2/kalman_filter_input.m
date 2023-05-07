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


%----------------------------initialize variables for plotting----------------------------%  
x_true = zeros(size(F,1), N);           % initialize matrix F_row-by-N to hold "grounth-truth" state vector values of postion and velocity with noise
x_noisy = zeros(size(G,2), N);          % initialize matrix G_column-by-N to hold position measurements (with noise)
x_est = zeros(size(F,1), N);            % initializw matrix F_row-by-N to hold estimated values of position and velocity
Kg_plot = zeros(size(F,1), N);          % initialize matrix F_row-by-N to hold Kalman gain values of postion and velocity
MSE_theo = zeros(size(F,1), N);         % initialize matrix F_row-by-N to hold theoretical MSE for position and velocuty, which is diagonal elements of P matrix.
%----------------------------end----------------------------%  


%----------------------------call function to generate state values----------------------------%  
[x_true, x_noisy, x_est, Kg_plot, MSE_theo] = kalman_filter(N, sigma2_a, sigma2_r, F, G, C, x_prev);     % return values for plotting
%----------------------------end----------------------------%  


%----------------------------plotting----------------------------%   
Nt = [1:N]'*T;                                      % steps
figure                                              % 1st figure: "true"/measured/estimated postions 
plot(Nt, x_true(1, :), Nt, x_noisy, ':k', Nt, x_est(1, :), '--')           % for position - plot all values for "true" with noise, measurement with noise, and estimated position values
legend('True', 'Noisy', 'Estimate')
xlabel('t (s)')
ylabel('Position (m)')
axis([0, 10, 400, 1000])                            % scale to look like figure 9.38 in book
grid

figure                                              % 2nd figure: "true"/estimated velocity
plot(Nt, x_true(2, :), Nt, x_est(2, :), '--')       % for velocity, plot all values for "true" with noise and estimate velocity values
legend('True', 'Estimate')
xlabel('t (s)')
ylabel('Velocity (m/s)')
axis([0, 10, -100, 200])                            % scale to look like figure 9.38 in book
grid

figure                                              % 3rd figure: Kg vs. time for postion
plot(Nt, Kg_plot(1, :))                             % plot all values on first row of Kg_plot, which is for postition
title('Kalman Gain - Position')
xlabel('t (s)')
ylabel('k_p')
axis([0, 10, 0, 1.5])                               % scale to look like figure 9.39 in book
grid

figure                                              % 4th figure: Kg vs. time for velocity
plot(Nt, Kg_plot(2, :))                             % plot all values on second row of Kg_plot, which is for velocity
title('Kalman Gain - Velocity')
xlabel('t (s)')
ylabel('k_v')
axis([0, 10, 0, 1.5])                               % scale to look like figure 9.39 in book
grid

figure                                              % 5th figure: theoretical MSE vs. time for position
plot(Nt, MSE_theo(1, :))                            % plot all values on first row of MSE_theo, which is for position
xlabel('t (s)')
ylabel('Theoretical MSE (position)')
axis([0, 10, 0, 100])                               % scale to look like figure 9.40 in book
grid

figure                                              % 6th figure: theoretical MSE vs. time for velocity
plot(Nt, MSE_theo(2, :))                            % plot all values on second row of MSE_theo, which is for velocity
xlabel('t (s)')
ylabel('Theoretical MSE (velocity)')
axis([0, 10, 0, 1200])                              % scale to look like figure 9.40 in book
grid
%----------------------------end----------------------------%  