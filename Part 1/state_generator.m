function [x_true, x_noisy] = state_generator(N, sigma2_a, sigma2_r, F, G, C, x_prev);

    %----------------------------setting up variables----------------------------%
    seed = 1040;                    % 512(o)*2 + 16  
    rng(seed, 'twister');
    
    Q = sigma2_a;                   % process noise u(k-1) ~ N(0,Q) from book page 881
    W_m = sigma2_r;                 % measurement noise, consider position only, it's a matrix 9.392 fro both position and velocity
       
    %----------------------------end----------------------------%
    
    
    %----------------------------for loop to generate "true" and noisy measurements----------------------------%
    for n = 1:N 
        Q_noise = normrnd(0, sqrt(Q));              % generate normal distributed process noise
        Wm_noise = normrnd(0, sqrt(W_m));           % generate normal distributed meaurement noise
       
        x_current = F * x_prev + G * Q_noise;       % current "true" state vector values + noise, equation 9.212 from book
        r = C * x_current + Wm_noise;               % current measured value of postion + noise, equation 9.213
         
        x_true(:, n) = x_current;                   % assign to x_input for plotting
        x_noisy(n) = r;                             % assign to x_noisy for plotting
        x_prev = x_current;                         % update state value
    end
    %----------------------------end----------------------------%    
