local ahn = import 'ahn.libsonnet';

local id = 'AHN/AHN2_05M_INT';
local description_type = 'Interpolated';
local description_detail = |||
  It contains ground level samples with all other items above ground (such as
  buildings, bridges, trees etc.) removed. This version is interpolated; the
  areas where objects have been removed are filled with interpolated values. The
  point cloud was converted to a 0.5m grid using a squared inverse distance
  weighting method.

  Note: This dataset does not include a small number of tiles listed in the
  manifest that are only available at a lower resolution.
|||;

ahn.ahn_dataset(id, description_type, description_detail)