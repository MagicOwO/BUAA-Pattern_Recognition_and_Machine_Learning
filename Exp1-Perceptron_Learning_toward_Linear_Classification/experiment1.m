i = 0;
j = 0;
a = zeros(i, j);
for dataset_sep = 0.5 : 0.5 : 5
    i = i + 1;
    j = 0;
    for learning_rate = 0.1 : 0.1 : 1
        j = j + 1;
        tmp = 0;
        for z = 1 : 1000
            tmp = tmp + classify_perceptron(dataset_sep, learning_rate, 0);
        end
        a(i, j) = tmp / 1000;
    end
end
disp(a)