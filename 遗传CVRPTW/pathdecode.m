function path = pathdecode(CVRP,dist,D,volume,x)
%����
path = inf(1,2*D+2);%��Ž�����·��
k = 1;%·�������еĽڵ����
path(k) = 1;%��һ���ڵ�����������
heavy = 0;%��ʼ�ĳ�������Ϊ0
numcar = 0;%��������ʼΪ0
d = 0;%��ʼ��������ʻ����
for j = 1:D
    k = k + 1;%���еĽڵ������1
    if (heavy+CVRP(x(j),4)<volume)
        path(k) = x(j);
        heavy = heavy + CVRP(x(j),4);%�ۼƳ���������
        d = d + dist(path(k-1),x(j));%�ۼƳ�������ʻ����
    else
        heavy = CVRP(x(j),4);%���ó������ػ���
        path(k) = 1;%���һ���������Ľڵ����
        k = k + 1;
        path(k) = x(j);%��һ������·���Ľڵ�
        d = dist(path(k-1),path(k));%���ó�������ʻ����
        numcar = numcar + 1;%��������1
    end
end
k = k + 1;
numcar = numcar + 1;
path(k) = 1;%�����ص���������
path(2*D+1) = numcar;%��¼������
end