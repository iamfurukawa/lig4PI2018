# LIG4
Projeto de PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL Turma A - 2018/1 - UFSCar Sorocaba

Para executar use o arquivo "Trabalho_PI.m" e altere as seguintes variáveis de controle para melhorar a segmentação:

%Canais!

y_channel_r = 125; y_channel_g = 125; y_channel_b = 100;

b_channel_r = 150; b_channel_g = 200; b_channel_b = 150;

r_channel_r = 230; r_channel_g = 230; r_channel_b = 230;

%bwareaopen e strel!
    
y_processing_bwr = 30;  y_processing_str = 5;

b_processing_bwr = 30;  b_processing_str = 10;

r_processing_bwr = 800; r_processing_str = 5;

%Normal!
    
normal = 20;

%Areas!
    
minArea = 1000;

maxArea = 10000;

Para  mais informações leia o slide.
