function path = pathdecode(CVRP,dist,D,volume,x)
%解码
path = inf(1,2*D+2);%存放解码后的路径
k = 1;%路径中已有的节点个数
path(k) = 1;%第一个节点是配送中心
heavy = 0;%初始的车辆载重为0
numcar = 0;%车辆数初始为0
d = 0;%初始车辆的行驶距离
for j = 1:D
    k = k + 1;%已有的节点个数加1
    if (heavy+CVRP(x(j),4)<volume)
        path(k) = x(j);
        heavy = heavy + CVRP(x(j),4);%累计车辆的载重
        d = d + dist(path(k-1),x(j));%累计车辆的行驶距离
    else
        heavy = CVRP(x(j),4);%重置车辆的载货量
        path(k) = 1;%添加一个配送中心节点序号
        k = k + 1;
        path(k) = x(j);%下一个加入路径的节点
        d = dist(path(k-1),path(k));%重置车辆的行驶距离
        numcar = numcar + 1;%车辆数加1
    end
end
k = k + 1;
numcar = numcar + 1;
path(k) = 1;%车辆回到配送中心
path(2*D+1) = numcar;%记录车辆数
end