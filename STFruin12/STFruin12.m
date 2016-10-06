% ------------------------------------------------------------------------------
% Book:         STF
% ------------------------------------------------------------------------------
% Quantlet:     STFruin12
% ------------------------------------------------------------------------------
% Description:  STFruin12 produces the ruin probability in infinite time for 
%               mixture of 2 exponentials distribution claims given by heavy
%               traffic approximation.
% ------------------------------------------------------------------------------
% Usage:        moments.m
% ------------------------------------------------------------------------------
% Inputs:       -  
% ------------------------------------------------------------------------------
% Output:       Ruin probability in infinite time for mixture of 2 exponentials
%               distribution claims given by heavy traffic approximation.
% ------------------------------------------------------------------------------
% Example:      
% ------------------------------------------------------------------------------
% Author:       Zografia Anastasiadou 20110720
% ------------------------------------------------------------------------------

clear all;
close all,
clc;
format long;

u=[0;10^9;5*10^9;10^10;2*10^10;5*10^10]; % initial capital of insurance company (in USD)
theta=0.3                                % relative safety loading
dparameters1=[0.0584 , 3.5900e-10 ; 0.9416 , 7.5088e-09]; % weights (first column) and exponential parameters (second column)

m=moments(1,dparameters1)  % 1st raw moment
m2=moments(2,dparameters1) % 2nd raw moment

% the heavy traffic approximation for mixture of 2 exponentials claims with beta1=3.5900e-10, beta2=7.5088e-09, alpha=0.0584 and theta=0.3 (u in USD) 
psi=exp((-2*theta*m*u)/m2)