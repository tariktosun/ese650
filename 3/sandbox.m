%% 

%% Visualize:
figure;
colors = {'k', 'r', 'b', 'c', 'g'};
for i=1:5
    visualize_acc(data.hammer{i}, colors{i});
end