function y = fitness(path,D,dist,C0,C1,V,CVRP)
global p1 p2
y = 0;%����·������
pathlong = path(2*D+1)+1+D;
t=0;
for i = 1:pathlong-1
    y = y + dist(path(i),path(i+1));
    %λ�� 1 ����������Ч��������������Ϊ���������߼�ֵ��
    if path(i+1)>1
        t=t+dist(path(i),path(i+1))/V;
        if t>CVRP(path(i+1),6)
            y=y+(t-CVRP(path(i+1),6))*p2;
        end
        
        if t<CVRP(path(i+1),5)
            y=y+(CVRP(path(i+1),5)-t)*p1;
        end
        t=t+CVRP(path(i+1),7);
    else
        t=0;
    end
end
y = C1*y + C0*path(2*D+1);
end