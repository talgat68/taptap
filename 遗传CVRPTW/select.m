function  x = select(N,D,GA)
%锦标赛
x = GA;
for i = 1:N
    candi = randperm(N,5);%在所有染色体中随机选取5个个体
    [fit,row] = min(GA(candi,D+1));%找路径最短的个体
    if fit<x(i,D+1)
        x(i,:) = GA(candi(row),:);%如果5个中最小的染色体产生的距离小于原数组中的染色体距离，则存放在父代的染色体群体中
    end
end
end