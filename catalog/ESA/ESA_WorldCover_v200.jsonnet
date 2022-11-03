local worldcover = import 'worldcover.libsonnet';

local citation = |||
  Zanaga, D., Van De Kerchove, R., Daems, D., De Keersmaecker, W., Brockmann,
  C., Kirches, G., Wevers, J., Cartus, O., Santoro, M., Fritz, S., Lesiv, M.,
  Herold, M., Tsendbazar, N.E., Xu, P., Ramoino, F., Arino, O., 2022. ESA
  WorldCover 10 m 2021 v200.
  ([doi:10.5281/zenodo.7254221](https://doi.org/10.5281/zenodo.7254221))
|||;

worldcover.catalog_entry('v200', citation)
