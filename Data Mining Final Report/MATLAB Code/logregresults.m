x=[1.0E-8,0.2,0.4,0.6,0.8,1.0];
y=[74.05,74.49,74.84,74.76,74.84,74.50];
idxmax = find(y == max(y));
plot(x,y,'-s','MarkerIndices',[idxmax],...
    'MarkerFaceColor','red',...
    'MarkerSize',15)
title('Logistic Regression')
xlabel('Ridge Penalty')
ylabel('% Accuracy')