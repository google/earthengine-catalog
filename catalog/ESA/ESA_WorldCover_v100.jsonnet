local worldcover = import 'worldcover.libsonnet';

local citation = |||
  Zanaga, D., Van De Kerchove, R., De Keersmaecker, W., Souverijns, N.,
  Brockmann, C., Quast, R., Wevers, J., Grosu, A., Paccini, A., Vergnaud, S.,
  Cartus, O., Santoro, M., Fritz, S., Georgieva, I., Lesiv, M., Carter, S.,
  Herold, M., Li, Linlin, Tsendbazar, N.E., Ramoino, F., Arino, O., 2021.
  ESA WorldCover 10 m 2020 v100.
  ([doi:10.5281/zenodo.5571936](https://doi.org/10.5281/zenodo.5571936))
|||;

worldcover.catalog_entry('v100', 2020, citation)
