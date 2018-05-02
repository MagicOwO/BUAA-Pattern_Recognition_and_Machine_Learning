% Parameters
prior_prob1 = 0.6;
prior_prob2 = 0.3;
prior_prob3 = 0.1;
decision_cost = [0 1 8; 3 0 3; 6 1 0];

% Generate dataset and plot
mean1_init = [-2 -3.5];
cov1_init = [1 0.5; 0.5 2];
mean2_init = [-1 4];
cov2_init = [2 0; 0 1];
mean3_init = [1.5, -1];
cov3_init = [1 0; 0 1];
w1 = mvnrnd(mean1_init, cov1_init, 50);
w2 = mvnrnd(mean2_init, cov2_init, 50);
w3 = mvnrnd(mean3_init, cov3_init, 50);
figure(1)
hold on
plot(w1(:, 1), w1(:, 2), '.b')
plot(w2(:, 1), w2(:, 2), 'ok')
plot(w3(:, 1), w3(:, 2), '*r')
title('Dataset')

% Init grid
[x, y] = meshgrid(-5 : 0.1 : 5);
figure(1)
hold on

% Conditional probability parameters and plot
mean1 = mean(w1);
cov1 = cov(w1(:, 1), w1(:, 2));
mean2 = mean(w2);
cov2 = cov(w2(:, 1), w2(:, 2));
mean3 = mean(w3);
cov3 = cov(w3(:, 1), w3(:, 2));
figure(2)
cond_prob1 = reshape(mvnpdf([x(:), y(:)], mean1, cov1), size(x));
cond_prob2 = reshape(mvnpdf([x(:), y(:)], mean2, cov2), size(x));
cond_prob3 = reshape(mvnpdf([x(:), y(:)], mean3, cov3), size(x));
surf(x, y, cond_prob1)
hold on
surf(x, y, cond_prob2)
surf(x, y, cond_prob3)
title('Conditional Probability')

% Calculate posterior probability and plot 
post_prob1 = prior_prob1 * cond_prob1;
post_prob2 = prior_prob2 * cond_prob2;
post_prob3 = prior_prob3 * cond_prob3;
post_prob_all = post_prob1 + post_prob2 + post_prob3;
post_prob1 = post_prob1 ./ post_prob_all;
post_prob2 = post_prob2 ./ post_prob_all;
post_prob3 = post_prob3 ./ post_prob_all;
figure(3)
surf(x, y, post_prob1)
hold on
surf(x, y, post_prob2)
surf(x, y, post_prob3)
title('Posterior Probability')

% Plot decision region with minimum error
region = calculate_decision_region(x, post_prob1, post_prob2, post_prob3, 'max');
figure(4)
hold on
surf(x, y, region)
title('Decision Boundary With Minimum Error')

% Calculate posterior probability with minimal risk and plot
cost1 = decision_cost(1, 1) * post_prob1 + decision_cost(2, 1) * post_prob2 + decision_cost(3, 1) * post_prob3;
cost2 = decision_cost(1, 2) * post_prob1 + decision_cost(2, 2) * post_prob2 + decision_cost(3, 2) * post_prob3;
cost3 = decision_cost(1, 3) * post_prob1 + decision_cost(2, 3) * post_prob2 + decision_cost(3, 3) * post_prob3;
figure(5)
surf(x, y, cost1)
hold on
surf(x, y, cost2)
surf(x, y, cost3)
title('Decision Cost')

% Plot decision region with minimal risk
region = calculate_decision_region(x, cost1, cost2, cost3, 'min');
figure(6)
hold on
surf(x, y, region)
title('Decision Boundary With Minimum Risk')


function region = calculate_decision_region(x, prob1, prob2, prob3, option)
assert(nargin == 5);
region = zeros(size(prob1));
for i = 1 : size(x, 1)
    for j = 1 : size(x, 2)
        if(strcmp(option, 'max'))
            [~, loc] = max([prob1(i, j), prob2(i, j), prob3(i, j)]);
        elseif(strcmp(option, 'min'))
            [~, loc] = min([prob1(i, j), prob2(i, j), prob3(i, j)]);
        end
        region(i, j) = loc - 1;
    end
end
end