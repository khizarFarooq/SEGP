function [net] = trainNN (input , output);

net = newff([min(input)'  max(input)'] , [8 3],{'tansig' 'tansig'} , 'traingd' , 'trainlm' , 'mse');

net.trainParam.show = 50;
net.trainParam.lr = 0.03;
net.trainParam.mc = 0.7;
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.01;

net = train(net , input' , output');
end