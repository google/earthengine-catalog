local worldcover = import 'worldcover.libsonnet';

local year_description = |||
  The European Space Agency (ESA) WorldCover 10 m 2020 product provides a
  global land cover map for 2020 at 10 m resolution based on Sentinel-1 and
  Sentinel-2 data.
|||;
local citation = |||
  Zanaga, D., Van De Kerchove, R., De Keersmaecker, W., Souverijns, N.,
  Brockmann, C., Quast, R., Wevers, J., Grosu, A., Paccini, A., Vergnaud, S.,
  Cartus, O., Santoro, M., Fritz, S., Georgieva, I., Lesiv, M., Carter, S.,
  Herold, M., Li, Linlin, Tsendbazar, N.E., Ramoino, F., Arino, O., 2021.
  ESA WorldCover 10 m 2020 v100.
  ([doi:10.5281/zenodo.5571936](https://doi.org/10.5281/zenodo.5571936))
|||;

worldcover.catalog_entry('v100', year_description, citation)
