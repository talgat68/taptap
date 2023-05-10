%ѡ�񣺽�����
%���棺˳�򽻲�
%���죺�������λ�û���
tic;
clear;
clc;
close all;
CVRP=xlsread('data.xlsx');%λ������
%data��һ��Ϊ��ţ�1�������������ݣ�23��Ϊ���꣬4��Ϊ����56��Ϊʱ�䴰��7��Ϊ����ʱ��
[row,~] = size(CVRP);
dist=xlsread('dists.xlsx');%��������
row = row - 1;%�ͻ��������
% ��������
N = 100;%��Ⱥ����
D = row;
volume = 5;           %����������
V=40;             %������ʻ�ٶ�
C0 =0;                %���������ɱ�
C1 =6;                 %��λ����ɱ�
global p1 p2
p1=14;%��ǰ����ͷ��ɱ�
p2=28;%���󵽴�ͷ��ɱ�
Iter = 200;             %������
Pc_max= 0.8;%��󽻲����
Pc_min= 0.6;%��С�������
Pm_max = 0.4;%���������
Pm_min= 0.2;%��С�������
GA = zeros(N,D+1);%GA����λ������
Path = inf(N,2*D+2);%����·�������飬ǰ2*D��ž���·����2*D+1��2*D+2�ֱ�Ϊ�����鼰·������
% ��ʼ��
[GA,Path] = initialization(CVRP,dist,N,D,volume,V,C0,C1,GA,Path);
gbest=min(Path(:,end));
fbest=min(gbest);
% ����
Gbest = zeros(1,Iter);%���ÿ�ε�������Ѿ���ֵ
for iter = 1:Iter
    Pc=Pc_min+(Pc_max-Pc_min)*iter/Iter;
    Pm=Pm_min+(Pm_max-Pm_min)*iter/Iter;
    k=rand();
    if fbest/gbest>k
        %ȫ������
        Parent1 = select(N,D,GA);
        Parent2 = select(N,D,GA);%�ֱ�ͨ��������ѡ����������Ⱥ
        GA = crossover(N,D,Pc,GA,Parent1,Parent2);%�������
        GA = mutation(N,D,Pm,GA);%�������
        for i = 1:N
            Path(i,:) = pathdecode(CVRP,dist,D,volume,GA(i,1:D));
            GA(i,D+1) = fitness(Path(i,:),D,dist,C0,C1,V,CVRP);
            Path(i,2*D+2) = GA(i,D+1);
        end
    else
        %�ֲ�����
        GA= crossover(N,D,Pc,GA,Parent1,Parent2);%�������
        GA= mutation(N,D,Pm,GA);%�������
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
% ��������ʾ
[value,row] = min(Path(:,2*D+2));
[~,col] = find(Path(row,1:2*D)==1);
[~,k] = size(col);
bestroute=Path(row,1:col(end))-1;
[DisTraveled]=TextOutput(dist,CVRP(:,4),bestroute,volume);  %��ʾ����·��
fprintf('�ܾ��� = %s km \n',num2str(DisTraveled))
plot(Gbest,'LineWidth',2);
xlabel('��������')
ylabel('�ܳɱ�')
title('�Ŵ��㷨�Ż�����')
DrawPath(bestroute,CVRP(:,2:3))
toc;








