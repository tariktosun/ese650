% % Loads data from individual mat files into a convenient cell array.
% 
% data = struct();
% %struct('circle', {}, 'figure8', {}, 'fish', {}, 'hammer', {},...
%     %'pend', {}, 'wave', {});
% 
% traindirs = {'train/circle', 'train/figure8', 'train/fish', 'train/hammer',...
%     'train/pend', 'train/wave'};
% 
% classes = {'circle', 'figure8', 'fish', 'hammer', 'pend', 'wave'};
% %%
% for c = 1:numel(classes)
%     class = classes{c};
%     files = dir(['train/' class]);
%     foo = {};
%     j = 1;
%     for i=1:numel(files)
%         n = files(i).name;
%         if strcmp(n, '.') || strcmp(n, '..')
%             continue
%         end
%         foo{j} = load(n);
%         j = j+1;
%     end
%     data.(char(class)) = foo;  
% end
% %%
% files = dir('train/circle');
% circle = {};
% j = 1;
% for i=1:numel(files)
%     n = files(i).name;
%     if strcmp(n, '.') || strcmp(n, '..')
%         continue
%     end
%     circle{j} = load(n);
%     j = j+1;
% end
% data.circle = circle;
% %%
% files = dir('train/figure8');
% foo = {};
% j = 1;
% for i=1:numel(files)
%     n = files(i).name;
%     if strcmp(n, '.') || strcmp(n, '..')
%         continue
%     end
%     foo{j} = load(n);
%     j = j+1;
% end
% data.figure8 = foo;
% %%
% files = dir('train/fish');
% foo = {};
% j = 1;
% for i=1:numel(files)
%     n = files(i).name;
%     if strcmp(n, '.') || strcmp(n, '..')
%         continue
%     end
%     foo{j} = load(n);
%     j = j+1;
% end
% data.fish = foo;
% %%