function res = faceclass()
load classdata.mat;
%%% Import set of faces, reshape/size
Test_set = [classdata(:,:,1), classdata(:,:,90), classdata(:,:,120), classdata(:,:,145), classdata(:,:,175)];

%TestFaces = [];

%for imagenum = 1:5
 %   image = Test_set(:,imagenum);
  %  [m,n] = size(image);
   % image = reshape(image, m*n,1);
    %TestFaces(:,imagenum) = image;
%end
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
TestFaces = [image1 image2 image3 image4 image5];


%%% Image Recognition input
input = classdata(:,:,175);
imshow(input)
[column,row] = size(input);
input = reshape(input, column*row,1);


%%% Actual pixel by pixel comparison

TD_Array = [];
for images = 1:5
    %[m,n] = size(TestFaces(images));
    picture = TestFaces(:,images);
    total_difference = 0;
    for pixel = 1:m
        difference = abs(input(pixel) - picture(pixel))/255;
        weighted_difference = difference/m;
        total_difference = total_difference + weighted_difference;
    end
    TD_Array(images) = total_difference;
end
    [Minimum_difference, Ind] = min(TD_Array)
    match = Test_set(Ind);
    imshow(match)

end
