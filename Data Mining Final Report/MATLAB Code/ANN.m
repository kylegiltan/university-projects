mydata = load('dataR2.csv');
b=transpose(mydata);
table=b(1:9,:);
class=b(10,:);
net=feedforwardnet(1);
net=train(net,b(1:9,:),b(10,:));
view(net)
y=net(b(1:9,:));

perform_hidden_node=perform(net,b(10,:),y)
%wb=getwb(net)
%[b,IW,LW] = separatewb(net,wb)
%indices = crossvalind('Kfold',class,4);
%cp=classperf(class);
%for i = 1:4
%    test = (indices == i); 
%    train = ~test;
%    class_ = classify(table(test,:),table(train,:),class(train,:));
%    classperf(cp,class_,test);
%end

%nb = fitcsvm(data, class,'CrossVal', 'on', 'KFold', 4);
%nb = perform(net,b(10,:),y,'CrossVal', 'on', 'KFold', 4);
%nb.kfoldLoss

net_4=feedforwardnet(4);
net_4=train(net_4,b(1:9,:),b(10,:));
view(net_4)
y_4=net_4(b(1:9,:));
perform_4_hidden_nodes=perform(net_4,b(10,:),y_4)
