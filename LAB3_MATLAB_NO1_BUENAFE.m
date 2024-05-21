% Clear
clear
clc
close all

%% Number 1
% Define G1, G2, G3, H1, H2 AND H3

G1_num = [1];
G1_den = [1 0 0];
G1 = tf(G1_num,G1_den)

G2_num = [1];
G2_den = [1 1];
G2 = tf(G2_num,G2_den)

G3_num = [1];
G3_den = [1 0];
G3 = tf(G3_num,G3_den)

H1_num = [1];
H1_den = [1 0];
H1 = tf(H1_num,H1_den)

H2_num = [1];
H2_den = [1 -1];
H2 = tf(H2_num,H2_den)

H3_num = [1];
H3_den = [1 -2];
H3 = tf(H3_num,H3_den)

%% Reduced Version
%% USING THE MANUAL BLOCK ARRANGEMENT
%% For Numerator

TF_numA_up = conv(G1_num,G3_num);
TF_numB_up = G2_num + G2_den
TF_num_up = conv(TF_numA_up,TF_numB_up)

TF_numA_down = conv(G1_den,G2_den)
TF_num_down = conv(TF_numA_down,G3_den)

%% For Denominator

TF_denA_up = conv(G2_num,H2_num)
TF_denB_up = conv(G1_num,G2_num)
TF_denBB_up = conv(TF_denB_up,H1_num)

TF_denA_down =  conv(G2_den,H2_den)
TF_denB_down = conv(G1_den,G2_den)
TF_denBB_down = conv(TF_denB_down,H1_den)
TF_denC_down = conv(TF_denA_down,TF_denBB_down)
TF_denD_down = conv(G3_den,H3_den)
TF_den_down = conv(TF_denC_down,TF_denD_down)

TF_denC_up = conv(TF_denA_up,TF_denBB_down)
TF_denD_up = conv(TF_denBB_up,TF_denA_down)
TF_denE_up = [1 1 0 0 1 0 -1]
TF_denF_up = conv(G3_num,H3_num)
TF_denG_up = [1 -2 1]
TF_den_up = conv(TF_denE_up,TF_denG_up)

TF_num = conv(TF_num_up,TF_den_down)
TF_den = conv(TF_num_down,TF_den_up)

TF_reduced = tf(TF_num, TF_den);

%% STEP RESPONSE
step(TF_reduced,0:0.1:10)
