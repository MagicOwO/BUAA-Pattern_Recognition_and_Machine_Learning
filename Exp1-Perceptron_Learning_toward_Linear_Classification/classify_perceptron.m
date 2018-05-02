function iter_cnt = classify_perceptron(dataset_sep, learning_rate, ~)
% Generate dataset
[w1, w2] = generate_dataset(dataset_sep);
% Sequence for updates
seq_list = randperm(size(w1, 1) + size(w2, 1));
% Set random number generator for test
% rng(0)
% Plot original dataset
% f = figure(1);
hold on
if(nargin >= 3) 
    pause off
else
    pause on
end
plot(w1(:, 1), w1(:, 2), 'ob', 'LineWidth', 2)
plot(w2(:, 1), w2(:, 2), '+g', 'LineWidth', 2)
legend('w1','w2')
% Classify with perceptron
w = 2 * rand(3, 1) - 1;
converged = 0;
iter_cnt = 0;

x = (-10 : 0.01 : 10);
y1 = -1 * (w(1) / w(2)) * x - (w(3) / w(2));
h = plot(x, y1, 'g', 'LineWidth', 2);


while(converged == 0)
    converged = 1;
    for i = 1 : length(seq_list)
        seq = seq_list(i);
        sample = [];
        % If sample belongs to w1
        if(seq <= length(w1))
            sample = [w1(seq, :), 1];
        % If sample belongs to w2
        else
            sample = -1 * [w2(seq - length(w1), :), 1];
        end
        y = sample * w;
        if y < 0
            iter_cnt = iter_cnt + 1;
            w = w + learning_rate * sample';
            converged = 0;
            y1 = -1 * (w(1) / w(2)) * x - (w(3) / w(2));
            delete(h)
            h = plot(x, y1, 'k', 'LineWidth', 2);
            axis([-10 10 -10 10]);
            title(['update: ', num2str(iter_cnt)]);
            pause(0.7)
            break
        end
    end
    if(iter_cnt > 10000)
        disp('Dataset linearly unseparable. Perceptron does not converge.')
        return
    end
end

disp(['The perceptron converged after ', num2str(iter_cnt), ' updates'])
disp(w')
end