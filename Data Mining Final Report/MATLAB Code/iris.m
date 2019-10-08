load 'iris.csv';

% // Split up species into 3 binary dummy variables
S = unique(species);
O = [];
for s = 1:numel(S)
    O(:,end+1) = strcmp(species, S{s});
end

% // Crossvalidation
vals = crossval(@(XTRAIN, YTRAIN, XTEST, YTEST)fun(XTRAIN, YTRAIN, XTEST, YTEST), meas, O);

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
