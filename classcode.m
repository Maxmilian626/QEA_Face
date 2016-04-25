function res = classcode()

load classdata.mat;

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
% 
% %Array for picture to picture correlation
% %Concatenated horizontally into matrix A
% A = [image1 image2 image3 image4 image5];

TestFaces = []

for imagenum = 1:343
    image = classdata(:,:,imagenum);
    [m,n] = size(image);
    image = reshape(image, m*n,1);
    TestFaces(:,imagenum) = image;
end

numpics = size(TestFaces);
numpics = numpics(:,2)

%Mean value of each pixel.
mean_pixels = mean(TestFaces');
std_pixels = std(TestFaces');

%Make a matrix to store normalized values from A
Anorm = zeros(size(TestFaces));

for i = 1:numpics
    %Find the mean for each picture for image i
    Anorm(:,1) = TestFaces(:,i) - mean_pixels';
    %Divide by the standard deviation of each pixel
    Anorm(:,i) = Anorm(:,1)./std_pixels';
end
    
FirstRowofCorrelationMatrix = 0.25 * Anorm(1,:)*Anorm';
FirstRowofCorrelationMatrix = reshape(FirstRowofCorrelationMatrix, m,n);
imshow(FirstRowofCorrelationMatrix)

end