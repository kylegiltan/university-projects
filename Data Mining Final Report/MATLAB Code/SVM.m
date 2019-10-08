%how to test for significance
%[h, p] = ttest(x,y)

mydata = load('dataR2.csv');
data=mydata(:,1:9);
class=mydata(:,10);

%glyphplot(mydata,'glyph','face')

SVMModel = fitcsvm(data,class);

nb = fitcsvm(data, class,'KernelFunction','polynomial','PolynomialOrder',1, 'CrossVal', 'on', 'KFold', 4);
nb.kfoldLoss

%SVMModel = fitcsvm(data,class,'KernelFunction','polynomial','PolynomialOrder',2);

predictions=predict(SVMModel,data);
accuracy=classperf(class,predictions)

%indices = crossvalind('Kfold',class,4);
%cp=classperf(class);
%for i = 1:4
%    test = (indices == i); 
%    train = ~test;
%    class_ = classify(table(test,:),table(train,:),class(train,:));
%    classperf(cp,class_,test)
%end

%hold on
%gscatter(x,y,class)
%sv_1 = SVMModel_1.SupportVectors;
%plot(sv_1(:,1),sv_1(:,2),'ko','MarkerSize',10)
%legend('0','1','Support Vector')

    