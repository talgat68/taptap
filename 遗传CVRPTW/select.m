function  x = select(N,D,GA)
%������
x = GA;
for i = 1:N
    candi = randperm(N,5);%������Ⱦɫ�������ѡȡ5������
    [fit,row] = min(GA(candi,D+1));%��·����̵ĸ���
    if fit<x(i,D+1)
        x(i,:) = GA(candi(row),:);%���5������С��Ⱦɫ������ľ���С��ԭ�����е�Ⱦɫ����룬�����ڸ�����Ⱦɫ��Ⱥ����
    end
end
end