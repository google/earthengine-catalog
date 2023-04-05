local template = import 'templates/WWF_HydroATLAS_v1_Basins.libsonnet';
local id = 'WWF/HydroATLAS/v1/Basins/level10';

template.hydroatlas_dataset(id) {
  title: super.title + '10',
  id: id,
}