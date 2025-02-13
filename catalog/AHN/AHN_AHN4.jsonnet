local ahn = import 'ahn_new.libsonnet';

local id = 'AHN/AHN4';
local title = 'AHN4: Netherlands AHN 0.5m';
local description_detail = |||
  AHN4 Dataset contains the Netherlands AHN 0.5m DSM and DTM variables.
  The data cover the period between 2020 and 2022.
|||;
local extent_from = '2020-01-01T00:00:00Z';
local extent_to = '2022-01-01T00:00:00Z';

ahn.ahn_dataset(id, title, description_detail, extent_from, extent_to)