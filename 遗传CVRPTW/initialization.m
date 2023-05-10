function [GA,Path] = initialization(CVRP,dist,N,D,volume,V,C0,C1,GA,Path)

for i = 1:N
    dist_matrix = dist;
    dist_matrix(:,1) = inf;
    k = 1;%路径中节点的个数
    GA(i,k) = 1;
    while GA(i,k)==1
        GA(i,k) = randperm(D+1,1);%随机选择一个起始客户点
    end
    dist_matrix(:,GA(i,k)) = inf;
    while k<=30
        k = k + 1;
        [~,col] = min(dist_matrix(GA(i,k-1),:));
        GA(i,k) = col;
        dist_matrix(:,GA(i,k)) = inf;
    end
    Path(i,:) = pathdecode(CVRP,dist,D,volume,GA(i,1:D));
    GA(i,D+1) = fitness(Path(i,:),D,dist,C0,C1,V,CVRP);%计算距离
    Path(i,2*D+2) = GA(i,D+1);
end
end