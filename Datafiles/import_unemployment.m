function [Unemployment, Unemployment_years] = import_unemployment

%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /isgucu_genel_2004_2013.xlsx
%    Worksheet: Sheet1
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2020/05/12 11:16:52

%% Import the data
[~, ~, raw] = xlsread('workforce_2004_2013.xlsx','Sheet1');
raw = raw(10:end,1:14);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
workforce20042013 = reshape([raw{:}],size(raw));

x = fliplr(1:30:271);
y = x + 25;

A = zeros(26, length(x));
for i = 1:length(x)
    A(:, i) = x(i):y(i);
end
a = A(:);

workforce20042013 = workforce20042013(a, 2:end);

%% Clear temporary variables
clearvars raw R x y A a i;

%% Import the data
[~, ~, raw] = xlsread('unemployment_2014_2019.xlsx','Sheet0');
raw = raw(5:10,4:29);

%% Create output variable
unemployment20142019 = reshape([raw{:}],size(raw));

load('external_data.mat', 'Il_abc_2_Duzey', 'bolge_adlari_1_to_2');

unemployment20142019 = unemployment20142019(:, bolge_adlari_1_to_2);

%% Clear temporary variables
clearvars raw;

Unemployment_1 = reshape(workforce20042013(:, 9), 26, 10);
Unemployment_2 = unemployment20142019';

Unemployment = [Unemployment_1 Unemployment_2];
Unemployment_years = 2004:2019;


Unemployment = Unemployment(Il_abc_2_Duzey, :);
