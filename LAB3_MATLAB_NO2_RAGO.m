%Clear
clear
clc
close all

%%LABORATORY 3, NUMBER 2
%% DEFINE G1, G2, G3, G4, H1, H2, and H3

G1_num = [1];
G1_den = [1 0 0];
G1 = tf(G1_num,G1_den)

G2_num = [1];
G2_den = [1 1];
G2 = tf(G2_num,G2_den)

G3_num = [1];
G3_den = [1 0];
G3 = tf(G3_num,G3_den)

G4_num = [1];
G4_den = [2 0];
G4 = tf(G4_num,G4_den)

H1_num = [1];
H1_den = [1 0];
H1 = tf(H1_num,H1_den)

H2_num = [1];
H2_den = [1 -1];
H2 = tf(H2_num,H2_den)

H3_num = [1];
H3_den = [1 -2];
H3 = tf(H3_num,H3_den)

%%Reduced Version

%%down
TF_denA_down = conv(G3_den,G4_den)
TF_denB_down = conv(TF_denA_down,H3_den)

TF_denC_down = conv(G2_den,G3_den)
TF_denD_down = conv(TF_denA_down,H2_den)

TF_denE_down = conv(G1_den,G2_den)
TF_denF_down = conv(TF_denA_down,G3_den)
TF_denG_down = conv(TF_denA_down,H1_den)
TF_denN_up = conv(TF_denB_down,TF_denD_down)
TF_denO_up = conv(TF_denN_up,TF_denG_down)
TF_den_down = TF_denO_up

TF_numA_up = conv(G1_num,G2_num)
TF_numB_up = conv(TF_numA_up,G3_num)
TF_num_up = conv(TF_numB_up,G4_num)

%%down
TF_numA_down = conv(G1_den,G2_den)
TF_numB_down = conv(TF_numA_down,G3_den)
TF_num_down = conv(TF_numB_down,G4_den)

TF_denA_up = conv(G3_num,G4_num)
TF_denB_up = conv(TF_denA_up,H3_num)
TF_denH_up = conv(TF_denB_up,TF_denD_down)
TF_denI_up = conv(TF_denH_up,TF_denG_down)

TF_denC_up = conv(G2_num,G3_num)
TF_denD_up = conv(TF_denA_up,H2_num)
TF_denJ_up = conv(TF_denD_up,TF_denB_down)
TF_denK_up = conv(TF_denJ_up,TF_denG_down)

TF_denE_up = conv(G1_num,G2_num)
TF_denF_up = conv(TF_denA_up,G3_num)
TF_denG_up = conv(TF_denA_up,H1_num)
TF_denL_up = conv(TF_denG_up,TF_denB_down)
TF_denM_up = conv(TF_denL_up,TF_denD_down)

TF_denN_up = conv(TF_denB_down,TF_denD_down)
%TF_den_up = TF_denO_up + TF_denI_up + TF_denK_up + TF_denM_up
TF_den_up = [2 -6 4 3 -7 6 -5 2]


TF_num = conv(TF_num_up,TF_den_down)
TF_den = conv(TF_num_down,TF_den_up)

TF_reduced = tf(TF_num, TF_den);

%%STEP RESPONSE

step(TF_reduced,0:0.1:10)