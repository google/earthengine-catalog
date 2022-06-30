local ahn = import 'ahn.libsonnet';

local id = 'AHN/AHN2_05M_RUW';
local description_type = 'Raw Samples';
local description_detail = |||
  This version contains both ground level samples and items above ground level
  (such as buildings, bridges, trees etc). The point cloud was converted to a
  0.5m grid using an squared inverse distance weighting method.
|||;

ahn.ahn_dataset(id, description_type, description_detail)
