local template = import 'templates/S2.libsonnet';
local subdir = 'COPERNICUS';

template.s2_dataset('COPERNICUS/S2') {
  description: |||
  See also collection COPERNICUS/S2_HARMONIZED that shifts data with
  PROCESSING_BASELINE '04.00' or above (after 2022-01-25) to be in the same range
  as in older scenes.

||| + super.description
}
