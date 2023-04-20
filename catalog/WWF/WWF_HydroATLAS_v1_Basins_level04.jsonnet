local template = import 'templates/WWF_HydroATLAS_v1_Basins.libsonnet';
local id = 'WWF/HydroATLAS/v1/Basins/level04';

template.hydroatlas_dataset(id) {
  title: super.title + '04',
  id: id,
}