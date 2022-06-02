local template = import 'templates/S2_SR.libsonnet';
local subdir = 'COPERNICUS';

template.s2_dataset('COPERNICUS/S2_SR') {
  description: |||
  See also collection COPERNICUS/S2_SR_HARMONIZED that shifts data with
  PROCESSING_BASELINE '04.00' or above (after 2022-01-25) to be in the same range
  as in older scenes.

||| + super.description
}
