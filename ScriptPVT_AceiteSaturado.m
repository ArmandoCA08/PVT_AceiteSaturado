%% PVT_AceiteSaturado.m
% Script de ejemplo para calcular propiedades PVT de aceite saturado.
% Calcula Pb, Rs y Bo con varias correlaciones y genera tres gráficas.

clear; clc; close all;

%% Datos de entrada
% Unidades principales:
% Tsep, T, Tb: °F | Psep, p, PbLab: psia | Rsfb: pies^3/bl | Bo: bl/bl

d.Tsep  = 100.00;    % Temperatura del separador [°F]
d.Psep  = 120.00;    % Presión del separador [psia]
d.Bofb  = 1.45;      % Factor de volumen del aceite a Pb [bl/bl]
d.Rsfb  = 750.00;    % Relación gas disuelto-aceite a Pb [pies^3/bl]
d.PbLab = 3300.00;   % Presión de burbuja experimental [psia]
d.Tb    = 220.00;    % Temperatura a Pb [°F]
d.p     = 2000.00;   % Presión de evaluación [psia]
d.T     = 200.00;    % Temperatura de evaluación [°F]
d.API   = 30.00;     % Gravedad API [°API]
d.yg    = 0.85;      % Densidad relativa del gas [adim.]
d.Mo    = 336.41;    % Peso molecular del aceite muerto [lb/lbmol]

% Variables auxiliares
d.TsepR = d.Tsep + 459.67;             % Temperatura del separador [°R]
d.yo    = 141.5 / (131.5 + d.API);    % Densidad relativa del aceite muerto

%% Cálculo de correlaciones
correlaciones = { ...
    'M. B. Standing', ...
    'Vázquez-Beggs', ...
    'Oinstein - Glaso', ...
    'J.A. Lasater', ...
    'TOTAL', ...
    'Al-Marhoun', ...
    'Kartoatmodjo y Schmidt', ...
    'Petrosky-Farshad', ...
    'Dokla-Osman', ...
    'De Ghetto, Paone y Villa'};

n = numel(correlaciones);
Pb = NaN(n,1);
Rs = NaN(n,1);
Bo = NaN(n,1);

for i = 1:n
    switch correlaciones{i}
        case 'M. B. Standing'
            r = calcStanding(d);
        case 'Vázquez-Beggs'
            r = calcVazquezBeggs(d);
        case 'Oinstein - Glaso'
            r = calcGlaso(d);
        case 'J.A. Lasater'
            r = calcLasater(d);
        case 'TOTAL'
            r = calcTotal(d);
        case 'Al-Marhoun'
            r = calcAlMarhoun(d);
        case 'Kartoatmodjo y Schmidt'
            r = calcKartoatmodjoSchmidt(d);
        case 'Petrosky-Farshad'
            r = calcPetroskyFarshad(d);
        case 'Dokla-Osman'
            r = calcDoklaOsman(d);
        case 'De Ghetto, Paone y Villa'
            r = calcDeGhettoPaoneVilla(d);
    end

    Pb(i) = r.Pb;
    Rs(i) = r.Rs;
    Bo(i) = r.Bo;
end

T = table(string(correlaciones(:)), Pb, Rs, Bo, ...
    'VariableNames', {'Correlacion','Pb_psia','Rs_pies3_bl','Bo_bl_bl'});

disp(T)

%% Gráfica de Pb
figure('Name','Presión de burbuja');
bar(categorical(T.Correlacion, T.Correlacion), T.Pb_psia);
grid on;
title('Presión de burbuja por correlación');
xlabel('Correlación');
ylabel('Pb [psia]');

%% Gráfica de Rs
figure('Name','Relación gas disuelto-aceite');
bar(categorical(T.Correlacion, T.Correlacion), T.Rs_pies3_bl);
grid on;
title('Relación gas disuelto-aceite por correlación');
xlabel('Correlación');
ylabel('Rs [pies^3/bl]');

%% Gráfica de Bo
figure('Name','Factor de volumen del aceite');
bar(categorical(T.Correlacion, T.Correlacion), T.Bo_bl_bl);
grid on;
title('Factor de volumen del aceite por correlación');
xlabel('Correlación');
ylabel('Bo [bl/bl]');

%% Funciones locales
function r = calcStanding(d)
A = 0.0125*d.API - 0.00091*d.T;
r.Pb = 18.2 * ((d.Rsfb/d.yg)^0.83) * 10^(0.00091*d.T - 0.0125*d.API);
r.Rs = d.yg * (((d.p/18.2) + 1.4) * 10^A)^1.2048;
r.Bo = 0.9759 + 0.00012 * ((r.Rs * ((d.yg/d.yo)^0.5) + 1.25*d.T)^1.2);
end

function r = calcVazquezBeggs(d)
Ygs = d.yg * (1 + 5.912e-5*d.API*(d.TsepR - 460)*log10(d.Psep/114.7));
if d.API <= 30
    C1 = 0.0362; C2 = 1.0937; C3 = 25.724; C4 = 4.677e-4; C5 = 1.751e-5; C6 = -1.8106e-8;
else
    C1 = 0.0178; C2 = 1.187; C3 = 23.931; C4 = 4.67e-4; C5 = 1.1e-5; C6 = 1.337e-9;
end
r.Pb = (d.Rsfb / (C1*Ygs*exp((C3*d.API)/(d.T + 459.67))))^(1/C2);
r.Rs = C1 * Ygs * (d.p^C2) * exp((C3*d.API)/(d.T + 459.67));
r.Bo = 1 + (C4*r.Rs) + (C5*(d.T - 60)*(d.API/Ygs)) + (C6*r.Rs*(d.T - 60)*(d.API/Ygs));
end

function r = calcGlaso(d)
A = ((d.Rsfb/d.yg)^0.816) * ((d.T^0.172)/(d.API^0.989));
r.Pb = 10^(1.7669 + 1.7447*log10(A) - 0.30218*(log10(A)^2));
rad = 14.1811 - 3.3093*log10(d.p);
if rad < 0
    r.Rs = NaN;
else
    X = 2.8869 - sqrt(rad);
    F = 10^X;
    r.Rs = d.yg * ((((d.API^0.989)/(d.T^0.172))*F)^1.2255);
end
Fo = (r.Rs*((d.yg/0.8761)^0.526)) + (0.968*d.T);
Abo = -6.58511 + 2.91329*log10(Fo) - 0.27683*(log10(Fo)^2);
r.Bo = 1 + 10^Abo;
end

function r = calcLasater(d)
MoCalc = 725.321 - 16.0333*d.API + 0.09524*(d.API^2);
YgLasater = (d.Rsfb/379.5) / ((d.Rsfb/350) + (350/MoCalc));
Pf = 0.3841 - 1.2008*YgLasater + 9.648*(YgLasater^2);
r.Pb = (Pf*(d.T + 459.67))/YgLasater;
r.Rs = (d.yo*132775*YgLasater)/(MoCalc*(1 - YgLasater));
r.Bo = NaN;
end

function r = calcTotal(d)
cPb = coefTotalPb(d.API);
cRs = coefTotalRs(d.API);
C1 = cPb(1); C2 = cPb(2); C3 = cPb(3); C4 = cPb(4);
r.Pb = C1 * ((d.Rsfb/d.yg)^C2) * 10^(C3*d.T - C4*d.API);
C1 = cRs(1); C2 = cRs(2); C3 = cRs(3); C4 = cRs(4);
r.Rs = d.yg * ((d.p/C1) * 10^(C2*d.API - C3*d.T))^C4;
r.Bo = 1.022 + (4.857e-4*r.Rs) - (2.009e-6*(d.T - 60)*(d.API/d.yg)) + ...
       (17.569e-9*r.Rs*(d.T - 60)*(d.API/d.yg));
end

function c = coefTotalPb(API)
if API <= 10
    c = [12.847, 0.9636, 0.000993, 0.03417];
elseif API <= 35
    c = [25.2755, 0.7617, 0.000835, 0.011292];
else
    c = [216.4711, 0.6922, -0.000427, 0.02314];
end
end

function c = coefTotalRs(API)
if API <= 10
    c = [12.2651, 0.030405, 0, 0.9669];
elseif API <= 35
    c = [15.0057, 0.0152, 4.484e-4, 1.095];
else
    c = [112.925, 0.0248, -1.469e-4, 1.129];
end
end

function r = calcAlMarhoun(d)
r.Pb = 5.38088e-3 * (d.Rsfb^0.715082) * (d.yg^-1.87784) * (d.yo^3.1437) * ((d.T + 459.67)^1.32657);
r.Rs = (185.84321*d.p*(d.yg^1.87784)*(d.yo^-3.1437)*((d.T + 459.67)^-1.32657))^1.3984;
F = (r.Rs^0.74239) * (d.yg^0.323294) * (d.yo^-1.20204);
r.Bo = 0.497069 + (0.862963e-3*d.T) + (0.182594e-2*F) + (0.318099e-5*(F^2));
end

function r = calcKartoatmodjoSchmidt(d)
Ygc = d.yg * (1 + 0.1595*(d.API^0.4078)*(d.Tsep^-0.2466)*log10(d.Psep/114.7));
if d.API <= 30
    C1 = 0.05958; C2 = 0.7972; C3 = 13.1405; C4 = 0.9986;
else
    C1 = 0.0315; C2 = 0.7587; C3 = 11.2895; C4 = 0.9143;
end
r.Pb = (d.Rsfb/(C1*(Ygc^C2)*10^((C3*d.API)/(d.T + 459.67))))^C4;
r.Rs = C1*(Ygc^C2)*(d.p^(1/C4))*10^((C3*d.API)/(d.T + 459.67));
F = (r.Rs^0.755)*(Ygc^0.25)*(0.87^-1.5) + 0.45*d.T;
r.Bo = 0.98496 + 1e-4*(F^1.5);
end

function r = calcPetroskyFarshad(d)
TR = d.T + 459.67;
TF = TR - 460;
x = (7.916e-4 * d.API^1.5410) - (4.561e-5 * TF^1.3911);
r.Pb = (112.727 * d.Rsfb^0.577421 / (d.yg^0.8439 * 10^x)) - 1391.051;
r.Rs = (((d.p + 1391.051) * d.yg^0.8439 * 10^x) / 112.727)^(1 / 0.577421);
F = (r.Rs^0.3738) * (d.yg^0.2914 / d.yo^0.6265) + 0.24626 * TF^0.5371;
r.Bo = 1.0113 + 7.2046e-5 * F^3.0936;
end

function r = calcDoklaOsman(d)
TR = d.T + 459.67;
a1 = 8363.86; a2 = -1.01049; a3 = 0.107991; a4 = 0.724047; a5 = -0.952584;
r.Pb = a1 * d.yg^a2 * d.yo^a3 * d.Rsfb^a4 * TR^a5;
r.Rs = (d.p / (a1 * d.yg^a2 * d.yo^a3 * TR^a5))^(1 / a4);
X = r.Rs^0.773572 * d.yg^0.404020 * d.yo^-0.882607;
r.Bo = 0.0431935 + 0.00156667 * TR + 0.00139775 * X - 3.80525e-6 * X^2;
end

function r = calcDeGhettoPaoneVilla(d)
r.Pb = 21.7429 * (d.Rsfb / d.yg)^0.7646 * 10^(0.00119 * d.T - 0.0101 * d.API);
r.Rs = d.yg * (d.p / (21.7429 * 10^(0.00119 * d.T - 0.0101 * d.API)))^(1 / 0.7646);
Ygs = d.yg * (1 + 5.912e-5 * d.API * (d.TsepR - 460) * log10(d.Psep / 114.7));
if d.API <= 30
    C4 = 4.677e-4; C5 = 1.751e-5; C6 = -1.8106e-8;
else
    C4 = 4.67e-4; C5 = 1.1e-5; C6 = 1.337e-9;
end
r.Bo = 1 + (C4 * r.Rs) + (C5 * (d.T - 60) * (d.API / Ygs)) + (C6 * r.Rs * (d.T - 60) * (d.API / Ygs));
end
