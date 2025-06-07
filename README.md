# DEHF-BS
**This is a hyperspectral band selection method based on Dynamic Graph Convolutional Network and AutoEncoder.**

DEHF.ipynb is the source code for the band selection model. After running it, a file named selected_bands.txt will be generated in the current directory. The new_SVM folder contains MATLAB code for hyperspectral image classification. Once you have the selected_bands.txt file, run .\new_SVM\packages\svm\run.m to generate the overall accuracy (OA) results for 5 to 50 bands in result.xlsx.
