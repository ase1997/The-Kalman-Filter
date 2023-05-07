function [x_true, x_noisy, x_est, Kg_plot, MSE_theo] = kalman_filter(N, sigma2_a, sigma2_r, F, G, C, x_prev);

    %----------------------------setting up variables----------------------------%
    seed = 1040;                    % 512(o)*2 + 16  
    rng(seed, 'twister');
    
    Q = sigma2_a;                   % process noise u(k-1) ~ N(0,Q) from book page 881
    W_m = sigma2_r;                 % measurement noise, consider position only, it's a matrix 9.392 fro both position and velocity
    x = [0; 0];                     % initilize state estimate vector
    P = [1000 0; 0 1000];           % initialize error, which is a scalar 1000 for this example 9.10
    %----------------------------end----------------------------%
    
    
    %----------------------------for loop to generate "true" and noisy measurements----------------------------%
    for n = 1:N 
        Q_noise = normrnd(0, sqrt(Q));              % generate normal distributed process noise
        Wm_noise = normrnd(0, sqrt(W_m));           % generate normal distributed meaurement noise
       
        x_current = F * x_prev + G * Q_noise;       % current "true" state vector values + noise, equation 9.212 from book
        r = C * x_current + Wm_noise;               % current measured value of postion + noise, equation 9.213
        
        % predict
        x_predict = F * x;                          % predict "true" position and velocity using F, equation 9.298
        P_predict = F * P * F' + G * Q * G';        % predict P using F-P-G-Q, equation 9.299
        r_predict = C * x_predict;                  % predict measured postion and velocity, equation 9.300
        P_tilde = C * P_predict * C' + W_m;         % calculate P tilde, equation 9.301

        % Kalman gain
        Kg = P_predict * C' * inv(P_tilde);         % calculate Kalman gain, equation 9.302

        x = F * x + Kg * (r - r_predict);           % update the state estimate vector, equation 9.303
        P = (eye(2) - Kg * C) * P_predict;          % update P, equation 9.304

        x_true(:, n) = x_current;                   % assign to x_input for plotting
        x_noisy(n) = r;                             % assign to x_noisy for plotting
        x_est(:, n) = x;                            % assign to x_est for plotting
        Kg_plot(:, n) = Kg;                         % assign to Kg_plot for plotting
        MSE_theo(1, n) = P(1,1);                    % theoretical MSE holder for position values
        MSE_theo(2, n) = P(2,2);                    % theoretical MSE holder for velicity values
        x_prev = x_current;                         % update state value
    end
    %----------------------------end----------------------------%    