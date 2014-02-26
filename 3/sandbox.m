%% Visualize accelerations for the hammer:
figure;
colors = {'k', 'r', 'b', 'c', 'g'};
for i=1:5
    if i==4
        continue
    end
    visualize_acc(hammer{i}, colors{i});
end