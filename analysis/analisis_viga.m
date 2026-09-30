% Análisis Reproducible: Deflexión de Viga Simplemente Apoyada
clear; clc; close all;

%% 1. Definición de Parámetros y Conversiones de Unidades
% Geometría (datos extraídos de parametros_viga.xlsx)
L = 4.0;       % Luz de la viga [m]
b = 0.2;       % Ancho de la sección [m]
h = 0.4;       % Altura de la sección [m]

% Material
E_GPa = 25;    % Módulo de elasticidad [GPa]
% CONVERSIÓN: 1 GPa = 1e6 kN/m^2. Esto es crucial para operar con la carga en kN.
E = E_GPa * 1e6; % [kN/m^2]

%% 2. Cálculo de Inercia
I = (b * h^3) / 12; % [m^4]
fprintf('Inercia calculada: I = %.6f m^4\n', I);

%% 3. Importación de Datos
% Se leen los datos originales sin modificarlos
datos = readtable('../data/datos_viga.csv');
P_kN = datos.carga_kN;                  % [kN]
def_medida_mm = datos.deflexion_medida_mm; % [mm]

%% 4. Deflexión Teórica (Euler-Bernoulli)
% Fórmula: delta = P * L^3 / (48 * E * I)
% Las unidades ingresadas (kN y m) darán un resultado en metros.
def_teo_m = (P_kN .* L^3) ./ (48 .* E .* I);

% CONVERSIÓN: Pasar de metros a milímetros para poder comparar con el CSV
def_teo_mm = def_teo_m .* 1000;

%% 5. Comparación y Verificación Adicional
n_datos = length(P_kN);
error_relativo = zeros(n_datos, 1);
verificacion_adicional = zeros(n_datos, 1);

for i = 1:n_datos
    if P_kN(i) > 0
        % Medida de diferencia relativa (%)
        error_relativo(i) = abs(def_medida_mm(i) - def_teo_mm(i)) / def_teo_mm(i) * 100;

        % Verificación adicional: Constancia de Delta/P en rango lineal
        % En un modelo lineal elástico, deflexion/carga debe ser constante.
        verificacion_adicional(i) = def_teo_mm(i) / P_kN(i); % [mm/kN]
    end
end

% Mostrar tabla resumen en la Command Window
Resultados = table(P_kN, def_medida_mm, def_teo_mm, error_relativo, verificacion_adicional)

%% 6. Generación de Figura
figure('Name', 'Curva Carga vs Deflexión', 'Position', [100, 100, 800, 500]);
plot(P_kN, def_medida_mm, 'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
hold on;
plot(P_kN, def_teo_mm, 'b.--', 'LineWidth', 1.5, 'MarkerSize', 12);
hold off;

% Formato exigido por la rúbrica (ejes, unidades, leyenda)
title('Curva Carga vs Deflexión en Centro de la Luz');
xlabel('Carga Aplicada [kN]');
ylabel('Deflexión [mm]');
legend('Medida (Experimental)', 'Teórica (Euler-Bernoulli)', 'Location', 'northwest');
grid on;

% Exportar automáticamente la figura a la carpeta correspondiente
saveas(gcf, '../figures/carga_deflexion.png');
fprintf('\nAnálisis finalizado. Gráfico guardado en: figures/carga_deflexion.png\n');