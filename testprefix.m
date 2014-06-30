% Matlab R2013a

clc; clear all; close all;

%% Settings
calculate_kdp_flag = 1;     % set to zero if already got keypoint descriptors (set to 1 if first time running)
dictionary_kmeans_flag = 0; % set to zero if already got keypoint descriptors (set to 1 if first time running)
k = 500;                    % k in k-means

% Variables
kpd = [];

%% calculate the keypoint descriptors
if calculate_kdp_flag == 1
    % loop every train folder images
    for folder = 1:4
        if folder == 1      % bike folder
            folder_n = 100;
        end
        if folder == 2      % cars folder
            folder_n = 100;
        end
        if folder == 3      % none folder
            folder_n = 100;
        end
        if folder == 4      % person folder
            folder_n = 100;
        end
        for n = 1:folder_n
            %% Load images & Feature extraction(extract keypoints)
            tic         % TIMER -- start timer
            if folder == 1
                n_change = n + 165;
                fprintf('Now processing:\n -- Test/bike/bike_%03d.bmp\n', n_change);
                IMG = imread(sprintf('Test/bike/bike_%03d.bmp', n_change));
            end
            if folder == 2
                n_change = n + 320;
                fprintf('Now processing:\n -- Test/cars/carsgraz_%03d.bmp\n',n_change);
                IMG = imread(sprintf('Test/cars/carsgraz_%03d.bmp',n_change));
            end
            if folder == 3
                n_change = n + 280;
                fprintf('Now processing:\n -- Test/none/bg_graz_%03d.bmp\n',n_change);
                IMG = imread(sprintf('Test/none/bg_graz_%03d.bmp',n_change));
            end
            if folder == 4
                n_change = n + 211;
                fprintf('Now processing:\n -- Test/person/person_%03d.bmp\n',n_change);
                IMG = imread(sprintf('Test/person/person_%03d.bmp',n_change));
            end
            IMG_hsv = rgb2hsv(IMG);                 % convert image from RGB to HSV
            IMG_hsv_value = IMG_hsv(:,:,3);         % gray scale value
            [x,y] = size(IMG_hsv_value);            % x,y is the width and length of the image
            kp = 0;
            kpl_r = [];
            for r = 1:x/32
                kpl_r = [kpl_r r*32-16];
            end
            kpl_c = [];
            for c = 1:y/32
                kpl_c = [kpl_c c*32-16];
            end
            % TEST-- Plot the keypoints 
            for xRows = 1:r
                for yColumns = 1:c
                    IMG_hsv_value(kpl_r(xRows), kpl_c(yColumns)) = 1;
                    kp = kp+1;
                end
            end
            % kp
            % IMG_hsv(:,:,3) = IMG_hsv_value;
            % IMG = hsv2rgb(IMG_hsv);
            % figure;
            % imshow(IMG);
           %% Feature Description(SIFT)
            for i=1:x-1
                for j=1:y-1
                    mag(i,j) = sqrt(((IMG_hsv_value(i+1,j)-IMG_hsv_value(i,j))^2)+((IMG_hsv_value(i,j+1)-IMG_hsv_value(i,j))^2));
                    oric(i,j) = atan2(((IMG_hsv_value(i+1,j)-IMG_hsv_value(i,j))),(IMG_hsv_value(i,j+1)-IMG_hsv_value(i,j)))*(180/pi);
                end
            end

            % Forming key point Descriptors
            for xRows = 1:r
                for yColumns = 1:c
                    k1 = kpl_r(xRows);
                    j1 = kpl_c(yColumns);
                    p2 = mag(k1-7:k1+8, j1-7:j1+8);
                    q2 = oric(k1-7:k1+8, j1-7:j1+8);
                    kpmagd = [];
                    kporid = [];
                    % Dividing into 4x4 blocks
                    for k1 = 1:4
                        for j1 = 1:4
                            p1 = p2(1+(k1-1)*4:k1*4, 1+(j1-1)*4:j1*4);
                            q1 = q2(1+(k1-1)*4:k1*4, 1+(j1-1)*4:j1*4);  
                            [m1,n1] = size(p1);
                            magcounts = [];
                            for x = 0:45:359
                                magcount = 0;
                                for i = 1:m1
                                    for j = 1:n1
                                        ch1 = -180+x;                 
                                        ch2 = -180+45+x;
                                        if ch1<0 || ch2<0
                                        if abs(q1(i,j))<abs(ch1) && abs(q1(i,j))>=abs(ch2)
                                            magcount = magcount+p1(i,j);
                                        end
                                        else
                                        if abs(q1(i,j))>abs(ch1) && abs(q1(i,j))<=abs(ch2)
                                            magcount = magcount+p1(i,j);
                                        end
                                        end
                                    end
                                end
                                magcounts=[magcounts magcount];
                            end
                            kpmagd=[kpmagd magcounts];
                        end
                    end
                    kpd=[kpd kpmagd];
                end
            end
            toc;        % TIMER -- show elapsed time
        end             % end of the n loop in a folder
        save(sprintf('kpds_test_%01d.txt', folder),'kpd','-ascii');
        kpd = [];
    end                 % end of the folder for loop
end                     % end of calculate_kdp_flag determination

%% Dictionary Computation
clearvars -EXCEPT k dictionary_kmeans_flag;

fprintf('Now processing:\n -- read from kpds txt files to kpd[]\n');
kpd = [];
for n =1:4
    load (sprintf('kpds_test_%01d.txt',n));
    if n == 1 
        kpd_num_total = length(kpds_test_1)/128;   % each keypoint descriptor has 128 dimensions    
        kpd_temp = zeros(128, kpd_num_total);
        kpd_temp(:) = kpds_test_1(:);
    end
    if n == 2 
        kpd_num_total = length(kpds_test_2)/128;   % each keypoint descriptor has 128 dimensions 
        kpd_temp = zeros(128, kpd_num_total);
        kpd_temp(:) = kpds_test_2(:);
    end
    if n == 3 
        kpd_num_total = length(kpds_test_3)/128;   % each keypoint descriptor has 128 dimensions 
        kpd_temp = zeros(128, kpd_num_total);
        kpd_temp(:) = kpds_test_3(:);
    end
    if n == 4
        kpd_num_total = length(kpds_test_4)/128;   % each keypoint descriptor has 128 dimensions 
        kpd_temp = zeros(128, kpd_num_total);
        kpd_temp(:) = kpds_test_4(:);
    end
    kpd = [kpd kpd_temp];
    clear (sprintf('kpds_test_%01d',n));
end
clear kpds_test_1; clear kpds_test_2; clear kpds_test_3; clear kpds_test_4;

if dictionary_kmeans_flag == 1
    fprintf('Now processing:\n -- Dictionary Computation(K-means)\n');
    tic;        % TIMER -- start timer
    opts = statset('MaxIter',20000);    % default is 100, it's not enough obviously(maybe 500 times I guess)
    [IDX,C] = kmeans(kpd', k, 'Options', opts);
    toc;        % TIMER -- show elapsed time
    C = C';
    save('C.txt','C','-ascii');
    save('IDX.txt','IDX','-ascii');
end

%% Compute Image Representation
fprintf('Now processing:\n -- Compute Image Representation\n');
tic;    % TIMER -- start timer
if dictionary_kmeans_flag == 0
    load C.txt;
end
clearvars -EXCEPT k kpd C;

imrp = [];
for img_count = 1:(length(kpd)/300)     % loop each image
    imrp_temp = zeros(k,1);
    for n = 1:300                       % loop each patch in one image
        for Center_count = 1:k          % loop each centers to compare the distance between the centers and the very patch
            D_temp = pdist2(kpd(:, (img_count-1)*300+n)', C(:, Center_count)');
            if Center_count == 1
                D_min = D_temp;
                D_min_num = Center_count;
            elseif D_temp < D_min
                D_min = D_temp;
                D_min_num = Center_count;
            end
        end     % end of centers loop
        imrp_temp(D_min_num) = imrp_temp(D_min_num) + 1;
    end         % end of patch loop
    imrp = [imrp imrp_temp];
end             % end of image loop
save('imrp_test.txt','imrp','-ascii');
toc;        % TIMER -- show elapsed time