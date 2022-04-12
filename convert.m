%% Read and adjust gt
fid = fopen('00.txt');
A = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);
gt = cell2mat(A);
gt = gt(:, [11 9 10 12 3 1 2 4 7 5 6 8]);
gt(:, [2 3 5 8 9 12])= -gt(:, [2 3 5 8 9 12]);

%% Read time and sample gt accordingly
fid = fopen('SC-F-LOAM/times.txt');
times = cell2mat(textscan(fid, '%f'));
fclose(fid);
m = size(gt, 1);
n = size(times, 1);
time_total = times(n);
ind = zeros(n, 1);
for i = 1:n
    ind(i,1) = round(m * times(i) / time_total);
end
gt = gt(ind, :);

%% Output gt
out = gt;
fid = fopen('ground_truth.txt', 'wt');
[m,n]= size(out);
for i = 1:m
    for j = 1:n
        if j==n
            fprintf(fid, '%e', out(i,j));
            fprintf(fid, '\n');
        else
            fprintf(fid, '%e', out(i,j));
            fprintf(fid, ' ');
        end
    end
end
fclose(fid);