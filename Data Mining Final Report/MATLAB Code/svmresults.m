x=[1,2,3,4,5,6];
y=[64.82,68.77,67.89,69.20,68.13,68.02];
idxmax = find(y == max(y));
plot(x,y,'-s','MarkerIndices',[idxmax],...
    'MarkerFaceColor','red',...
    'MarkerSize',15)
title('SVM')
xlabel('Degree of Polynomial')
ylabel('% Accuracy')