function x = mutation(N,D,Pm,GA)
%����
x = GA;
for i = 1:N
    if rand <= Pm%�����С�ڱ����������б������
        point1 = 0;
        point2 = 0;
        while point1 == point2%���������������ͬ
            point = randi([1,D],1,2);%����2-D֮���������ͬ���������
            point1 = min(point);
            point2 = max(point);%�����������ݴ�С��ֵ
        end
        temp = x(i,point1);
        x(i,point1) = x(i,point2);
        x(i,point2) = temp;%��������㻥��λ��
    end
end
end