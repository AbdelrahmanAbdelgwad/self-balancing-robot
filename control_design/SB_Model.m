clc
clear
close all

M = 0.08 ; %wheel mass in kg
m = 0.75; % chassis mass in kg
l = 0.02; %center of graity in m
R = 0.035; % wheel radius in m
g = 9.8; 
u0 = 0.1; %coefficient of friction between wheel and ground
u1 = 0; 
% we considered the robot to be a rectangular cube for simplification
% when calculating the inertia
h = 0.09; % robot height in m
d = 0.12; % robot width in m
Ic = (1/12)*m*(h^2 + d^2); %kg.m2

Iw = 0.5*M*R^2; %kg.m2

den = (m+ 2*M + 2*(Iw/R^2))*(m*l^2 + Ic) - m*l^2;

A = [0 0 1 0;
    0 0 0 1;
    0 -((m*l^2)*g)/den -(2*u0*(m*l^2 + Ic)/den) (2*m*l*u1)/den;
    0 ((m+ 2*M + 2*(Iw/R^2))*m*g*l)/den (2*u0*m*l)/den -2*u1*(m+ 2*M + 2*(Iw/R^2))/den]

B = [0;
    0;
    -m*l/den;
    (m+ 2*M + 2*(Iw/R^2))/den]

C = [0 1 0 0]

D = [0]



