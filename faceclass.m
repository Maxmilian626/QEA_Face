function res = faceclass()

load classdata.mat;
% 
% image1 = classdata(:,:,1);
% image2 = classdata(:,:,90);
% image3 = classdata(:,:,120);
% image4 = classdata(:,:,145);
% image5 = classdata(:,:,175);
% 
% [m,n] = size(image1);
% 
% image1 = reshape(image1, m*n,1);
% image2 = reshape(image2, m*n,1);
% image3 = reshape(image3, m*n,1);
% image4 = reshape(image4, m*n,1);
% image5 = reshape(image5, m*n,1);

%Array for picture to picture correlation
%Concatenated horizontally into matrix A
% TestFaces = [image1 image2 image3 image4 image5];

TestFaces = []

for imagenum = 1:343
    image = classdata(:,:,imagenum);
    [m,n] = size(image);
    image = reshape(image, m*n,1);
    TestFaces(:,imagenum) = image;
end

numpics = size(TestFaces);
numpics = numpics(:,2)

mean_pixels = (mean(TestFaces'))';
maxrow = size(TestFaces(1,:));

% Normalize test faces
for row = 1:maxrow(2)
    normA(:,row) = TestFaces(:,row) - mean_pixels;
end

normAt = transpose(normA);

% Find covariance matrix, eigenvalues, and eigenvectors
cov = normAt*normA;
[vec,eigen] = eig(cov);

% Find eigenfaces
newvec = normA * vec;

% Normalizing eigenfaces?
for row = 1:92160
    for column = 1:numpics
    newvec(row, column) = norm(newvec(row, column));
    end
end

%Re-adding mean face
eigfaces = newvec + repmat(mean_pixels,1,numpics);

% image1 = reshape(eigfaces(:,1), m,n);
% imshow(image1);

%%
% Finding weights of training sets

% TestFaces;

testweight = transpose(normA) * eigfaces;
size(TestFaces)
% size()

%%
% Image Recognition

input = classdata(:,:,344);
imshow(input)
input = reshape(input, m*n,1);

difference = input - mean_pixels;

figure

weight = transpose(repmat(difference, 1,numpics)) * eigfaces;

%Finding Euclidean distance

distance = abs(weight - testweight);
threshhold = 500;

[M,I] = min(distance, [], 1);

match = reshape(TestFaces(:,I(1)),m,n);
imshow(match)
end