mydata = load('dataR2.csv');
data=mydata(:,1:9);
class=mydata(:,10);
model = mnrfit(data,class);
pihat = mnrval(model,data);
predictions=zeros(116,1);
for i=1:116
        if pihat(i,1)>0.5
            predictions(i,1)=1;
        else
            predictions(i,1)=2;
        end
end
accuracy=classperf(class,predictions)

%try different function instead of sigmoid
%nb = fitcsvm(data, class,'CrossVal', 'on', 'KFold', 4);
%nb = perform(net,b(10,:),y,'CrossVal', 'on', 'KFold', 4);
%nb.kfoldLoss
