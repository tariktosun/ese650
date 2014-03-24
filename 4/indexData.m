function d = indexData( data, i )
% d = indexData( data, i )
% Indexes into the data struct.
%%
d = struct();
d.ts = data.ts(i);
d.ranges = data.ranges(:,i);
d.angles = data.angles;
d.Encoders = data.Encoders(:,i);
d.gyro = data.gyro(:,i);

end