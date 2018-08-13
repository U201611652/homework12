x=zeros(9,9);
x=[ 0 0 0 0 5 7 0 8 0;
    3 0 0 0 0 0 0 0 0;
    0 0 2 9 0 0 4 0 0;
    2 0 0 8 0 9 3 0 0;
    4 0 0 0 0 0 0 0 7;
    0 0 7 4 0 6 0 0 8;
    0 0 6 0 0 2 7 0 0;
    0 0 0 0 0 0 0 0 5;
    0 9 0 3 1 0 0 0 0]%在此输入需要解开的数独矩阵~待填的都填0
%或者是循环输入需要解开的数独矩阵
%x_temp=x;
%for xi=1:9
% for xj=1:9
% x(xi,xj)=input('');
% end
%end
x_temp=x;
%% 
while length(find(x_temp==0))>=1
x_flag=x_temp;%第一一个标志来判断依次循环后是否能填入数
a=find(x_temp==0);%找出未待填的位置
%%
j=ceil(a/9);%分别求出所在行和列
i=mod(a,9);
i(find(i==0))=9;
%%
%将待填的空可填入的数据存入ept_temp中，不能填的数据位填0
for k=1:length(a)
ept_temp(k,:)=1:9;
hang=find(x_temp(i(k),:)>0);
ept_temp(k,x_temp(i(k),hang))=0;
lie=find(x_temp(:,j(k))>0);
ept_temp(k,x_temp(lie,j(k)))=0;
zheng=x_temp(3*(ceil(i(k)/3)-1)+1:3*(ceil(i(k)/3)-1)+3,3*(ceil(j(k)/3)-1)+1:3*(ceil(j(k)/3)-1)+3);
num=zheng(find(zheng>0));
ept_temp(k,num)=0;
end
%%
%按行搜索找到具有唯一可填入数据的空格~并在那里填入这个数据
ept=ept_temp;
for k=1:9
hang_ept=ept(find(i==k),:);
temp1=sum(hang_ept,1);
for q=1:9
if(temp1(q)==q)
temp=find(i==k);
fprintf(1,'%d hang %d lie fill %d\n',k,j( temp(find(hang_ept(:,q)>0))),q);
x_temp(k,j( temp(find(hang_ept(:,q)>0))))=q;
end
end
end
%%
%按列搜索找到具有唯一可填入数据的空格~并在那里填入这个数据
for k=1:9
lie_ept=ept(find(j==k),:);
temp2=sum(lie_ept,1);
for q=1:9
if(temp2(q)==q)
temp=find(j==k);
fprintf(1,'%d hang %d lie fill %d\n',i(temp(find(lie_ept(:,q)>0))),k,q);
x_temp(i(temp(find(lie_ept(:,q)>0))),k)=q;
end
end
end
%%
%按小方块搜索找到具有唯一可填入数据的空格~并在那里填入这个数据 
for k=1:9
kj=ceil(k/3);
ki=mod(k,3);
ki(find(ki==0))=3;
zheng_ept=ept(find(i>=(3*(ki-1)+1)&i<=(3*(ki-1)+3)&j>=(3*(kj-1)+1)&j<=(3*(kj-1)+3)),:);
temp3=sum(zheng_ept,1);
for q=1:9
if(temp3(q)==q)
temp=find(i>=(3*(ki-1)+1)&i<=(3*(ki-1)+3)&j>=(3*(kj-1)+1)&j<=(3*(kj-1)+3));
fprintf(1,'%d hang %d lie fill %d\n',i(temp(find(zheng_ept(:,q)>0))),j(temp(find(zheng_ept(:,q)>0))),q);
x_temp(i(temp(find(zheng_ept(:,q)>0))),j(temp(find(zheng_ept(:,q)>0))))=q;
end
end
end
%%
%遍历所有空格的可填入数据，找到只有一个可填入数据的点并填入该数据
for k=1:length(a)
if(length(find(ept(k,:)>0))==1)
fprintf(1,'num %d fill %d\n',a(k),find(ept(k,:)>0));
x_temp(a(k))=find(ept(k,:)>0);
end 
end
%%
clear ept_temp;
%%
%经过一次循环如果x_temp没变化则不能填满数据~~报错
if(x_flag==x_temp)
error('Error!!Can not fill all block!!');
end
fprintf(1,'----------------------------------------------------------------------------\n');
end
fprintf(1,'Finish!!\n');
fprintf(1,'*******************************************************************************\n');
x=x_temp;
x