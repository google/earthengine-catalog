local ahn = import 'ahn_new.libsonnet';

local id = 'AHN/AHN3';
local title = 'AHN3: Netherlands AHN 0.5m';
local description_detail = |||
  AHN3 Dataset contains the Netherlands AHN 0.5m DSM and DTM variables.
  The data cover the period between 2014 and 2019.
|||;
local extent_from = '2014-01-01T00:00:00Z';
local extent_to = '2019-01-01T00:00:00Z';
ahn.ahn_dataset(id, title, description_detail, extent_from, extent_to)