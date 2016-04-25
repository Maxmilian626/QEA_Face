function res = faceclass()

load classdata.mat;

image1 = classdata(:,:,1);
image2 = classdata(:,:,90);
image3 = classdata(:,:,120);
image4 = classdata(:,:,145);
image5 = classdata(:,:,175);

[m,n] = size(image1);

image1 = reshape(image1, m*n,1);
image2 = reshape(image2, m*n,1);
image3 = reshape(image3, m*n,1);
image4 = reshape(image4, m*n,1);
image5 = reshape(image5, m*n,1);

%Array for picture to picture correlation
%Concatenated horizontally into matrix A
A = [image1 image2 image3 image4 image5];
mean_pixelsA = (mean(A'))';

% size(A)
% size(mean_pixelsA)
maxrow = size(A(1,:));

for row = 1:maxrow(2)
%     size(A(:,row))
%     size(mean_pixelsA)
    A(:,row) = A(:,row) - mean_pixelsA;
end

At = transpose(A);


cov = At*A;
[vec,eigen] = eig(cov);
% vec(:,1)

newvec = A * vec;

for row = 1:92160
    for column = 1:5
    newvec(row, column) = norm(newvec(row, column));
    end
end

eigfaces = newvec + repmat(mean_pixelsA,1,5);

image1 = reshape(eigfaces(:,1), m,n);
% imshow(image1)

%%
%Image Recognition

input = classdata(:,:,90);
input = reshape(input, m*n,1);

difference = input - mean_pixelsA;

% for column = 1:5
    
% weight = transpose(newvec) * repmat(difference,1,5) * newvec
size(newvec)
size(difference)

% M = min(newvec,[],1)
% % size (difference)
% % size(newface)
% 
% %Finding Euclidean distance
% distance = abs(newface - repmat(difference,1,5));
% threshhold = 1e-6;

% size(distance)
% M = min(distance,[],1)
% 
% maxrow = size(M');
% for column = 1:maxrow(1)
%     if M(column) <= threshhold
%         column
%     end
% end
end