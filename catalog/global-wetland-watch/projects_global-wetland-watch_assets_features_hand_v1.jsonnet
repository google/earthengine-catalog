local id = 'projects/global-wetland-watch/assets/features/hand/v1';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local gww = import 'gww.libsonnet';

local subdir = gww.subdir;
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local hand_band(threshold, label, scale) = {
  name: 'hand_' + threshold,
  description: 'Height above nearest drainage relative to ' + scale + ': the drainage network is all cells with at least ' + label + ' upstream cells. Scaled by 10.',
  'gee:units': units.meter,
  'gee:scale': 0.1,
};

{
  id: id,
  title: 'Global Wetland Watch Height Above Nearest Drainage (HAND) v' + version,
  version: version,
  description: |||
    The Global Wetland Watch Height Above Nearest Drainage (HAND) layer
    gives the vertical distance, in meters, between each pixel and the nearest
    drainage channel it flows into ([Nobre et al., 2011](https://doi.org/10.1016/j.jhydrol.2011.03.051)), at 1 arc-second
    (about 30 m) resolution. It provides drainage-relative elevation context
    for wetland hydrology: low HAND values indicate terrain that is close in
    height to the drainage network and therefore more likely to be wet or
    flooded.

    HAND is derived from FABDEM (Forest And Buildings removed Copernicus DEM;
    [Hawker et al., 2022](https://doi.org/10.1088/1748-9326/ac4d4f);
    FABDEM V1-2, [Neal & Hawker, 2023](https://doi.org/10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn)),
    a version of the Copernicus GLO-30 digital elevation model (DEM)
    ([European Space Agency, 2022](https://doi.org/10.5270/ESA-c5d3d65)) with
    forests and buildings removed. Where FABDEM is not available (north of
    80&deg;N and in parts of the Caucasus, e.g. Armenia and Azerbaijan), the
    Copernicus GLO-30 DEM is used directly.

    Each image has three bands, one per drainage network definition:
    `hand_100` (small streams), `hand_1000` (medium rivers) and `hand_100000`
    (major rivers), where the drainage network is all cells with at least
    100, 1,000 or 100,000 upstream cells respectively.

    Values are stored as integers scaled by 10: multiply by 0.1 to obtain
    meters.

    **Possible Uses:**

    * **Wetland and floodplain mapping:** As a predictor of where water
      accumulates, for wetland classification and floodplain delineation.
    * **Hydrological screening:** Identifying low-lying areas connected to
      rivers for flood exposure and restoration planning.
    * **Scale-dependent analysis:** Comparing thresholds to separate areas
      near small streams from those connected to large river systems.

    **Limitations:**

    * **FABDEM licence:** This dataset is released under CC-BY 4.0 with the
      permission of the FABDEM authors. The underlying FABDEM data remain
      under their original CC BY-NC-SA 4.0 licence and are not covered by
      this dataset's CC BY 4.0 licence.
    * **Relative indicator:** HAND describes position relative to the
      drainage network. It is not a measure of inundation depth or flood
      frequency.
    * **DEM quality:** HAND inherits errors from the input DEM, including
      residual vegetation and building artifacts (more pronounced where
      GLO-30 is used without FABDEM corrections) and reduced accuracy in very
      flat terrain, where small elevation errors change drainage paths.
    * **Coverage:** Global, excluding Antarctica.
  |||,
  'gee:categories': ['elevation-topography', 'surface-ground-water'],
  keywords: [
    'dem',
    'drainage',
    'elevation',
    'hydrology',
    'topography',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  // Static layer: the temporal extent is the acquisition period of the
  // underlying Copernicus GLO-30 DEM (via FABDEM), matching the catalog entry
  // for COPERNICUS/DEM/GLO30.
  extent: ee.extent_global('2010-12-01T00:00:00Z', '2015-01-31T00:00:00Z'),
  summaries: {
    gsd: [30.0],
    'eo:bands': [
      hand_band('100', '100', 'small streams'),
      hand_band('1000', '1,000', 'medium rivers'),
      hand_band('100000', '100,000', 'major rivers'),
    ],
    'gee:visualizations': [
      {
        display_name: 'HAND, 1,000-cell drainage threshold (m x 10)',
        lookat: {lon: 102.13, lat: 19.88, zoom: 12},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [500],
            palette: ['260d40', '3e2e5e', '544d7b', '71618c', '93658f', 'bd6992',
                      'd586aa', 'dfabc9', 'e9cee4', 'f0eafa'],
            bands: ['hand_1000'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'tile',
        description: '10-degree grid tile, named by its north-west corner, e.g. N55E000',
        type: ee_const.var_type.string,
      },
      {
        name: 'dem',
        description: 'Source DEM(s) of the basins in the tile: FABDEM, COP30 (Copernicus GLO-30) or both, e.g. COP30,FABDEM',
        type: ee_const.var_type.string,
      },
      {
        name: 'version',
        description: 'Product version',
        type: ee_const.var_type.string,
      },
    ],
  },
  'sci:citation': gww.citation,
  // FABDEM credited as requested by its authors when granting CC-BY release.
  'sci:publications': [
    {
      citation: |||
        Hawker, L., Uhe, P., Paulo, L., Sosa, J., Savage, J., Sampson, C. and
        Neal, J. (2022). A 30 m global map of elevation with forests and
        buildings removed. Environmental Research Letters, 17, 024016.
        [doi:10.1088/1748-9326/ac4d4f](https://doi.org/10.1088/1748-9326/ac4d4f)
      |||,
      doi: '10.1088/1748-9326/ac4d4f',
    },
    {
      citation: |||
        Neal, J. and Hawker, L. (2023). FABDEM V1-2. University of Bristol.
        [doi:10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn](https://doi.org/10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn)
      |||,
      doi: '10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn',
    },
  ],
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "Global Wetland Watch (DHI, UNEP-DHI, UNEP), 2026".

    It is derived from FABDEM
    ([Hawker et al., 2022](https://doi.org/10.1088/1748-9326/ac4d4f); FABDEM
    V1-2, [doi:10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn](https://doi.org/10.5523/bris.s5hqmjcdj8yo2ibzi9b4ew3sn)),
    released under CC-BY 4.0 here with the permission of the FABDEM authors.
    The underlying FABDEM data remain under their original
    [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
    licence and are not covered by this dataset's CC BY 4.0 licence. Please
    credit FABDEM in any publication using this dataset.
  |||,
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
