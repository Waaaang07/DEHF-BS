function [class_results_SVM] = func_SVM(DS,band_set,train_num,indexes)
    no_train= train_num;%注意是总样本数，不是每类
    beta             = 1e-8; 
%% 1. Read Data
[img3D img2D map r c d N K]=Read_data(DS);
img3D = img3D(:,:,band_set);
no_classes=max(map(:));%imshow(img3D(:,:,1),[]),figure,imagesc(map)

trainall=[];
for k=1:no_classes
    location=find(map==k);
    classall=zeros(size(location,1),2);
    classall(:,1)=location;
    classall(:,2)=k;
    trainall=[trainall;classall];
end
trainall=trainall';

%%
[no_lines, no_rows, no_bands] = size(img3D);
no_samples = no_lines*no_rows;%每波段数据数
img = ToVector(img3D);%3D转平面
img = img';

train_select = trainall;
% indexes=train_test_random_new(train_select(2,:),fix(no_train/no_classes),no_train);
train_samples = train_select(:,indexes);
train_vectors = img(:,train_samples(1,:));

% the remaining used for test
test_samples = trainall;
test_samples(:,indexes) = [];

%% SVM Classifier

for k=1:no_bands
    XX(k,:) = (img(k,:)-min(img(k,:)))/(max(img(k,:))-min(img(k,:))); %按波段全图归一化
end

model = svmtrain(train_samples(2,:)',double(XX(:,train_samples(1,:))'),'-s 0 -c 125 -g 2^(-6) -b 1'); %训练SVM，按理说用train_vectors就行吧
                                                                                        %不知道为啥这块非得归一化，后面再训练又不归一化了
    
groupX = randi(no_classes,no_samples,1); %生成一个21025（no_samples）行，1列的，元素值介于（0，16之间）得矩阵
[predict_label_old, accuracy_old, prob_estimates_old] = svmpredict(double(groupX),double(XX'),model,'-b 1'); %用训练的模型对全图做预测

[m lab] = max(prob_estimates_old'); %可以省略的一步，因为后面都是直接用的prob_estimates这个量
test_prob = nnz(predict_label_old-lab'); %也是没啥用的一步，可以省略

class_results_SVM.map=predict_label_old';
[class_results_SVM.OA,class_results_SVM.kappa,class_results_SVM.AA,class_results_SVM.CA] =...
    calcError( test_samples(2,:)-1, class_results_SVM.map(test_samples(1,:))-1, 1: no_classes);

class=reshape(class_results_SVM.map,no_lines,no_rows);
% figure,imshow(class,[]),colormap(jet);

end
 