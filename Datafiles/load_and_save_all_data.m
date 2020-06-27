% load and save all the data;

load('external_data', 'ilmesafe_abc_abc', 'Iller');
[Election2004, Election2009, Election2014] = import_election;
[GDP, GDP_years] = import_gdp;
[Population, Population_years] = import_population;
[Migration, Migration_years] = import_migration;
% NAN cells in the migration data are converted to 0.
Migration(isnan(Migration)) = 0;
[Unemployment, Unemployment_years] = import_unemployment;
[AKP, AKP_years] = import_AKP;
[Kurd] = import_Kurd;
[Betweenness, Betweenness_years] = import_betweenness;
[Correlations, Correlations_years] = import_correlations;


save All_Data_Migration;