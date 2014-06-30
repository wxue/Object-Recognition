% Matlab R2013a

clc; clear all; close all;

%% Settings
TrainData_accuracytest_flag = 1;            %  recognition accuracy on train dataset
ValidationData_accuracytest_flag = 1;       %  recognition accuracy on validation dataset
TestData_accuracytest_flag = 1;             %  recognition accuracy on test dataset

load imrp.txt
imrp_training = imrp';
imrp_group = zeros(676,1);
imrp_group(1:165,1) = 1;        % bike
imrp_group(166:385,1) = 2;      % car
imrp_group(386:565,1) = 3;      % none
imrp_group(566:676,1) = 4;      % person

%% Train Data Accuracy Test
if TrainData_accuracytest_flag == 1
    Result = multisvm(imrp_training, imrp_group, imrp_training);
    % bike
    miss = 0;
    accuracy = 0;
    for n = 1:165
        if Result(n) ~= 1;
            miss = miss + 1;
        end
    end
    accuracy = (165-miss)/165;
    fprintf('Recognition accuracy on train dataset -- Bike : %d\n', accuracy);
    % car
    miss = 0;
    accuracy = 0;
    for n = 166:385
        if Result(n) ~= 2;
            miss = miss + 1;
        end
    end
    accuracy = (220-miss)/220;
    fprintf('Recognition accuracy on train dataset -- Car : %d\n', accuracy);
    % none
    miss = 0;
    accuracy = 0;
    for n = 386:565
        if Result(n) ~= 3;
            miss = miss + 1;
        end
    end
    accuracy = (180-miss)/180;
    fprintf('Recognition accuracy on train dataset -- None : %d\n', accuracy);
    % person
    miss = 0;
    accuracy = 0;
    for n = 566:676
        if Result(n) ~= 4;
            miss = miss + 1;
        end
    end
    accuracy = (111-miss)/111;
    fprintf('Recognition accuracy on train dataset -- Person : %d\n', accuracy);
end

%% Validation Data Accuracy Test
if ValidationData_accuracytest_flag == 1
    load imrp_validation.txt;
    imrp_validation = imrp_validation';
    Result = multisvm(imrp_training, imrp_group, imrp_validation);
    % bike
    miss = 0;
    accuracy = 0;
    for n = 1:100
        if Result(n) ~= 1;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on validation dataset -- Bike : %d\n', accuracy);
    % car
    miss = 0;
    accuracy = 0;
    for n = 101:200
        if Result(n) ~= 2;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on validation dataset -- Car : %d\n', accuracy);
    % none
    miss = 0;
    accuracy = 0;
    for n = 201:300
        if Result(n) ~= 3;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on validation dataset -- None : %d\n', accuracy);
    % person
    miss = 0;
    accuracy = 0;
    for n = 301:400
        if Result(n) ~= 4;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on validation dataset -- Person : %d\n', accuracy);
end

%% Test Data Accuracy Test
if TestData_accuracytest_flag == 1
    load imrp_test.txt;
    imrp_test = imrp_test';
    Result = multisvm(imrp_training, imrp_group, imrp_test);
    % bike
    miss = 0;
    accuracy = 0;
    for n = 1:100
        if Result(n) ~= 1;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on test dataset -- Bike : %d\n', accuracy);
    % car
    miss = 0;
    accuracy = 0;
    for n = 101:200
        if Result(n) ~= 2;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on test dataset -- Car : %d\n', accuracy);
    % none
    miss = 0;
    accuracy = 0;
    for n = 201:300
        if Result(n) ~= 3;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on test dataset -- None : %d\n', accuracy);
    % person
    miss = 0;
    accuracy = 0;
    for n = 301:400
        if Result(n) ~= 4;
            miss = miss + 1;
        end
    end
    accuracy = (100-miss)/100;
    fprintf('Recognition accuracy on test dataset -- Person : %d\n', accuracy);
end