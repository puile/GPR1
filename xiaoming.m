clc
clear all
m=2
f=10e6
t=0:0.000000001:m/f
A=-cos(2*pi*f*t).*(1-cos(2*pi*f*t/m))