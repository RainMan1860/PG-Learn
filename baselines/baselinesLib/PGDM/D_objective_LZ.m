function fD = D_objective(X, D, a, N, d)

sum_dist = 0;

% LZ speed up 
for diff_pair = D'
    i = diff_pair(1);
    j = diff_pair(2);
    d_ij = X(i,:) - X(j,:) + ~(X(i,:) | X(j,:));
    dist_ij = distance1(a, d_ij);
    sum_dist = sum_dist +  dist_ij;
end

fD = gF2(sum_dist);


% __________cover function 1_________
function fD = gF1(sum_dist)
% gF1(y) = y
    fD = sum_dist;

function fD = gF2(sum_dist)
% gF1(y) = log(y)
    fD = log(sum_dist);


function dist_ij = distance1(a, d_ij)
% distance: distance(d) = L1
fudge = 0.000001;
dist_ij = sqrt((d_ij.^2)*a);


function dist_ij = distance2(a, d_ij)
% distance using distance2: distance(d) = sqrt(L1)
fudge = 0.000001;
dist_ij = ((d_ij.^2)*a)^(1/4);


function dist_ij = distance3(a, d_ij)
% distance using distance3: 1-exp(-\beta*L1)
fudge = 0.000001;
beta = 0.5;
L1 = sqrt((d_ij.^2)*a);
dist_ij = 1 - exp(-beta*L1);
