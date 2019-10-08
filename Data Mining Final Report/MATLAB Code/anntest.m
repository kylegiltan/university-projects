mydata = load('dataR2.csv');
b=transpose(mydata);
table=b(1:9,:);
class=b(10,:);
%table=mydata(:,1:9);
%class=mydata(:,10);

%indices = crossvalind('Kfold',class,10);
%cp=classperf(class);
%for i = 1:10
%    net=feedforwardnet(1);
%    net=train(net,table,class);
%    y=net(table);
%    test = (indices == i); 
%    train = ~test;
%    class_ = perform(net,class,y)
%    classperf(cp,class_,test);
%end
%cp.ErrorRate



% // Split up species into 3 binary dummy variables
S = unique(class);
O = [];
for s = 1:numel(S)
    O(:,end+1) = strcmp(class, S(s));
end

% // Crossvalidation
vals = crossval(@(XTRAIN, YTRAIN, XTEST, YTEST)fun(XTRAIN, YTRAIN, XTEST, YTEST), table,0);

function testval = fun(XTRAIN, YTRAIN, XTEST, YTEST)

    net = feedforwardnet(10);
    net = train(net, XTRAIN', YTRAIN');

    yNet = net(XTEST');
    %'// find which output (of the three dummy variables) has the highest probability
    [~,classNet] = max(yNet',[],2);

    %// convert YTEST into a format that can be compared with classNet
    [~,classTest] = find(YTEST);


    %'// Check the success of the classifier
    cp = classperf(classTest, classNet);
    testval = cp.CorrectRate; %// replace this with your preferred metric

end


%net=feedforwardnet(1);
%net=train(net,b(1:9,:),b(10,:));
%y=net(b(1:9,:));