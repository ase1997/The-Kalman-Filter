# The-Kalman-Filter

## Type: Academic Individual Project

## Project Description
NCSU ECE 751 (Detection and Estimation Theory) Software Project
  - Part I: Developing a state generator to generate states ("true' and noisy values) as thr input to the filter
  - Part II: Developing a discrete, time-invariant KF to estimate values based on the input from part I

## Dependencies
  - MATLAB
  
## About the Repo.
  - The FDDB dataset is included in this repository.  Details about the dataset can be found in [1].
  - **models.ipynb** in **/code** is the Jupyter Notebook that contains the Python implementation of the two models.  The notebook shows how to run each of the models to get the results and plots
  - **data_extracter.ipynb** in **/code** extracts the images from the original FDDB in dataset to **/FDDB** under **negImages** and **posImages**.  The extracted images are then manually picked and divided into training and test set in **/dataset**
  - Final report details the implementations of the functions in this project along with the results + analysis

## Authors
Khoa Do
