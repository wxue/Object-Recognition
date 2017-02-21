# Object-Recognition

### About

> This is a contest project I practiced on [Professor Hua's](http://www.cs.stevens.edu/~ghua/) 2014 Spring [Computer Vision Class ](http://www.cs.stevens.edu/~ghua/ghweb/Teaching/CS558Spring2014.htm) at Stevens Institute of Technology.

### Data Set

This object recognition project was trained and tested by the database: [GRAZ-02 database](http://www.emt.tugraz.at/~pinz/data/GRAZ_02/)

More about the database: [About GRAZ-02](http://www.emt.tugraz.at/~pinz/data/GRAZ_02/README.txt)

### File System

* main.m (Feature Extraction, Feature Description, Dictionary Computation, Compute Taining Image Representation)
  * validationprefix.m (Compute Validation Dataset Image Representation)
  * testprefix.m (Compute Test Dataset Image Representation)

* Classfier.m (SVM Classifier Training & Recognition Quality Computation)
  * multisvm.m (Extend Matlab SVM toolbox to support multigroups SVM training)

### Control Flags

* main.m
  * calculate_kdp_flag (Set to 1 for first time run, and set to 0 if not needed.)
  * dictionary_kmeans_flag  (Set to 1 for first time run, and set to 0 if not needed.)

* validationprefix.m
  * calculate_kdp_flag (Set to 1 for first time run, and set to 0 if not needed.)
  * dictionary_kmeans_flag (Always set to 0 in this file)

* testprefix.m
  * calculate_kdp_flag (Set to 1 for first time run, and set to 0 if not needed.)
  * dictionary_kmeans_flag (Always set to 0 in this file)

* Classfier.m
  * TrainData_accuracytest_flag (Set to 1 to calculate this dataset, and set to 0 to ignore.)
  * ValidationData_accuracytest_flag (Set to 1 to calculate this dataset, and set to 0 to ignore.)
  * TestData_accuracytest_flag (Set to 1 to calculate this dataset, and set to 0 to ignore.)

### How to run the code

1. main.m         This always goes first when you just start to run the code. You can set k to the value you like. I compared both k=500 and k=1000. After about 24~33 hours running of the code(it depends on the k value you set and your computer speed), you will get the imrp.txt file which we need in the next step, and intermediate .txt files which store keypointdescriptors, centers, IDX.

2. validationprefix.m   This is a prefix of the validation dataset images to compute their image representations. The results will be store in imrp_validation.txt.

3. testprefix.m   This is a refix of the test dataset images to compute their image representations. The results will be store in imrp_test.txt.

4. multisvm.m     This is a third party function to extend Matlab SVM toolbox to support mutigroup SVM. You do not to run this code alone, just put this in the same folder with others would be fine.

5. Classfier.m    Classfier Training and recognition accuracy computation. If you do not want to run the previous steps considering the long running time, you can just use imrp.txt, imrp_validation, and imrp_test.txt I submit in the zip file and put them in the same folder with other files. Both k=500 and k=1000 imrp(image representation) files are provided. 

* All the files should be in the same folder, and so do the "Train", "Validation", and "Test" folders.

### Acknowledgements

All the code in my project were written by Weiyu Xue. However, the two parts listed below were the parts I have checked online, and they inspired my thinking and my code. I appreciated their ideas and work.

> SIFT Algorithm:
  Cheggoju Naveen's SIFT Algorithm from MATLAB CENTRAL is really a mind lighter for me after I read lots of related papers and hesitated.

> MultiSVM Extend
  This is a third party function, it described it self by its own in the file.(by Cody Neuburger cneuburg@fau.edu) Although it only has 20 lines and very simple, it is really useful. 

### License

The MIT License (MIT)

Copyright (c) 2014 Weiyu Xue

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
