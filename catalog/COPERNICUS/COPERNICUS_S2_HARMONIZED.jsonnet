local harmonized = import 'templates/harmonized.libsonnet';
local subdir = 'COPERNICUS';
local template = import 'templates/S2.libsonnet';

template.s2_dataset('COPERNICUS/S2_HARMONIZED') {
  title: 'Harmonized ' + super.title,
  description: harmonized.description + super.description,
}
