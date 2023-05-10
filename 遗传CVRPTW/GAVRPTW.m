%选择：锦标赛
%交叉：顺序交叉
%变异：两个随机位置互换
tic;
clear;
clc;
close all;
CVRP=xlsread('data.xlsx');%位置数据
%data第一列为编号，1是配送中心数据，23列为坐标，4列为需求，56列为时间窗，7列为服务时间
[row,~] = size(CVRP);
dist=xlsread('dists.xlsx');%距离数据
row = row - 1;%客户点的数量
% 参数设置
N = 100;%种群数量
D = row;
volume = 5;           %车辆的容量
V=40;             %车辆行驶速度
C0 =0;                %车辆启动成本
C1 =6;                 %单位距离成本
global p1 p2
p1=14;%提前到达惩罚成本
p2=28;%延误到达惩罚成本
Iter = 200;             %迭代数
Pc_max= 0.8;%最大交叉概率
Pc_min= 0.6;%最小交叉概率
Pm_max = 0.4;%最大变异概率
Pm_min= 0.2;%最小变异概率
GA = zeros(N,D+1);%GA数组位置申请
Path = inf(N,2*D+2);%定义路径的数组，前2*D存放具体路径，2*D+1、2*D+2分别为车辆书及路径长度
% 初始化
[GA,Path] = initialization(CVRP,dist,N,D,volume,V,C0,C1,GA,Path);
gbest=min(Path(:,end));
fbest=min(gbest);
% 迭代
Gbest = zeros(1,Iter);%存放每次迭代的最佳距离值
for iter = 1:Iter
    Pc=Pc_min+(Pc_max-Pc_min)*iter/Iter;
    Pm=Pm_min+(Pm_max-Pm_min)*iter/Iter;
    k=rand();
    if fbest/gbest>k
        %全局搜索
        Parent1 = select(N,D,GA);
        Parent2 = select(N,D,GA);%分别通过锦标赛选择两个父代群
        GA = crossover(N,D,Pc,GA,Parent1,Parent2);%交叉操作
        GA = mutation(N,D,Pm,GA);%变异操作
        for i = 1:N
            Path(i,:) = pathdecode(CVRP,dist,D,volume,GA(i,1:D));
            GA(i,D+1) = fitness(Path(i,:),D,dist,C0,C1,V,CVRP);
            Path(i,2*D+2) = GA(i,D+1);
        end
    else
        %局部搜索
        GA= crossover(N,D,Pc,GA,Parent1,Parent2);%交叉操作
        GA= mutation(N,D,Pm,GA);%变异操作
        for i = 1:N
            Path(i,:) = pathdecode(CVRP,dist,D,volume,GA(i,1:D));
            GA(i,D+1) = fitness(Path(i,:),D,dist,C0,C1,V,CVRP);
            Path(i,2*D+2) = GA(i,D+1);
        end
    end
    Gbest(1,iter) = min(GA(:,D+1));
    fbest=min(Gbest(1:iter));
    gbest=min(GA(:,D+1));
    iter
end
% 命令行显示
[value,row] = min(Path(:,2*D+2));
[~,col] = find(Path(row,1:2*D)==1);
[~,k] = size(col);
bestroute=Path(row,1:col(end))-1;
[DisTraveled]=TextOutput(dist,CVRP(:,4),bestroute,volume);  %显示最优路径
fprintf('总距离 = %s km \n',num2str(DisTraveled))
plot(Gbest,'LineWidth',2);
xlabel('迭代次数')
ylabel('总成本')
title('遗传算法优化过程')
DrawPath(bestroute,CVRP(:,2:3))
toc;








