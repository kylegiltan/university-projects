%idk how to do this with multiple attributes for x
%how to test for significance
%[h, p] = ttest(x,y)

data = load('dataR2.csv');
x = data(:,1:9);
  w = 0; b = 0;
  for rep=1:100
      w = w + 0.001*sum(x.*(data(:,10)-sigma(w*x + b)));
      b = b + 0.001*sum(data(:,10)-sigma(w*x + b));
  end
ksdensity(data(data(:,10)==1,10));
hold on;
ksdensity(data(data(:,10)==2,10));
plot(x, sigma(w*x + b));
[w,b]