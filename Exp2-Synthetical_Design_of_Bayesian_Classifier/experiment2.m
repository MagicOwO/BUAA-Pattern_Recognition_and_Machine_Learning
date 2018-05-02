w1 = [-3.9847 -3.5549 -1.2401 -0.9780 -0.7932 -2.8531 -2.7605 -3.7287 -3.5414 -2.2692 -3.4549 -3.0752 -3.9934 -0.9780 -1.5799 -1.4885 -0.7431 -0.4221 -1.1186 -2.3462 -1.0826 -3.4196 -1.3193 -0.8367 -0.6579 -2.9683];
w2 = [2.8792 0.7932 1.1882 3.0682 4.2532 0.3271 0.9846 2.7648 2.6588];

% Range of domain
x = (-5 : 0.1 : 5);

% Calculate the conditional probability
mean1 = mean(w1);
std1 = std(w1);
mean2 = mean(w2);
std2 = std(w2);

% Plot the conditional probability
conditional1 = (1 / (sqrt(2 * pi) * std1)) * exp(-1 * (x - mean1) .^ 2 / (2 * std1 ^ 2));
conditional2 = (1 / (sqrt(2 * pi) * std2)) * exp(-1 * (x - mean2) .^ 2 / (2 * std2 ^ 2));
figure(1)
hold on;
plot(x, conditional1)
plot(x, conditional2)
title('Conditional Probability')

% Calculate the prior probability
prior1 = 0.9;
prior2 = 0.1;

% Calculate the posterior probability
posterior1 = prior1 * conditional1;
posterior2 = prior2 * conditional2;
posterior_sum = posterior1 + posterior2;
posterior1 = posterior1 ./ posterior_sum;
posterior2 = posterior2 ./ posterior_sum;
figure(2);
hold on
title('Posterior Probability')
plot(x, posterior1)
plot(x, posterior2)
for i = 1 : length(x)
    if(posterior1(i) < 0.5)
        disp(['Decision Boundary with maximum accuracy: ', num2str(x(i))])
        break
    end
end

% Consider the decision risk
risk21 = 6;
risk12 = 1;
cost1 = posterior2 * risk12;
cost2 = posterior1 * risk21;
figure(3)
hold on 
plot(x, cost1)
plot(x, cost2)
title('desicion loss')
for i = 1 : length(x)
    if(cost1(i) > cost2(i))
        disp(['Decision Boundary with minimal cost: ', num2str(x(i))])
        break
    end
end