function x = crossover(N,D,Pc,GA,Parent1,Parent2)
%˳�򽻲�
x = GA;
for i = 1:N
    parent1 = Parent1(i,:);
    parent2 = Parent2(i,:);%�ֱ�ѡ����������Ⱥ�еĵ�i��Ⱦɫ����н���
    if rand>Pc
        x(i,:) = parent1;
        if parent1(D+1)>parent2(D+1)
            x(i,:) = parent2;%����������ڽ�����ʣ�ѡ�����������о�����̵��Ǹ��̳�������
        end
    else%�������С�ڽ������ʱ�����н������
        point = randperm(D,2);
        point1 = min(point);
        point2 = max(point);%ָ����С�����
        while max(point)-min(point)>29||max(point)==min(point)
            %�����֮��ľ����5�򽻲治������仯
            point = randperm(D,2);%���ѡ��1-D��Χ�ڵ�������ͬ������
            point1 = min(point);
            point2 = max(point);%ָ����С�����
        end
        x(i,point1:point2) = parent1(point1:point2);%�Ӵ������֮���Ǹ���1�����֮������
        parent2_1 = [parent2(point2+1:D) parent2(1:point2)];%����2�ӽ����2��һλ��ʼѭ��һ�ֵ��ý����
        for cross = point1:point2
            parent2_1(parent2_1==x(i,cross)) = [];%��parent2_1�����Ӵ����ظ������ȥ��
        end
        if point1 == 1
            x(i,point2+1:D) = parent2_1;%��������1�ǵڶ�λ����ֱ�Ӹ�ֵ
        elseif point2 ==D
            x(i,1:point1-1) = parent2_1;%��������2�����һλ��Ҳ����ֱ�Ӹ�ֵ
        else
            x(i,1:point1-1) = parent2_1(1:point1-1);%�����ǰ��һ����Ÿ�ֵ
            x(i,point2+1:D) = parent2_1(point1:end);%�������һ����Ÿ�ֵ
        end
    end
end
end