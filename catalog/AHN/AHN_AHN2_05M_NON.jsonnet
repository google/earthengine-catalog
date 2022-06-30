local ahn = import 'ahn.libsonnet';

local id = 'AHN/AHN2_05M_NON';
local description_type = 'Non-Interpolated';
local description_detail = |||
  It contains ground level samples with all other items above ground (such as
  buildings, bridges, trees etc.) removed. This version is non-interpolated; the
  areas where objects have been removed are left blank and not filled with
  interpolated values. The point cloud was converted to a 0.5m grid using a
  squared inverse distance weighting method.
|||;

ahn.ahn_dataset(id, description_type, description_detail)
