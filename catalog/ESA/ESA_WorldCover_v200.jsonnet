local worldcover = import 'worldcover.libsonnet';

local year_description = |||
  The European Space Agency (ESA) WorldCover 10 m 2021 product provides a
  global land cover map for 2021 at 10 m resolution based on Sentinel-1 and
  Sentinel-2 data.
|||;
local citation = |||
  Zanaga, D., Van De Kerchove, R., Daems, D., De Keersmaecker, W., Brockmann,
  C., Kirches, G., Wevers, J., Cartus, O., Santoro, M., Fritz, S., Lesiv, M.,
  Herold, M., Tsendbazar, N.E., Xu, P., Ramoino, F., Arino, O., 2022. ESA
  WorldCover 10 m 2021 v200.
  ([doi:10.5281/zenodo.7254221](https://doi.org/10.5281/zenodo.7254221))
|||;

worldcover.catalog_entry('v200', year_description, citation)
