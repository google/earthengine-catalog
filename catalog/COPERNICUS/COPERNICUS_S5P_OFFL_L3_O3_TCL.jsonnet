local id = 'COPERNICUS/S5P/OFFL/L3_O3_TCL';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local s5p_desc = importstr 'COPERNICUS_S5P_description.md';
local COPERNICUS_S5P = import 'COPERNICUS_S5P.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Sentinel-5P OFFL O3 TCL: Offline Tropospheric Ozone',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_O3_TCL

    This dataset provides offline tropospheric high-resolution imagery of ozone
    concentrations between 20N and 20S. See also `COPERNICUS/S5P/OFFL/L3_O3` and
    `COPERNICUS/S5P/NRTI/L3_O3` for the total column data.

    In the stratosphere, the ozone layer shields the biosphere from dangerous
    solar ultraviolet radiation. In the troposphere, it acts as an efficient
    cleansing agent, but at high concentration it also becomes harmful to the
    health of humans, animals, and vegetation. Ozone is also an important
    greenhouse-gas contributor to ongoing climate change. Since the discovery
    of the Antarctic ozone hole in the 1980s and the subsequent Montreal Protocol
    regulating the production of chlorine-containing ozone-depleting substances,
    ozone has been routinely monitored from the ground and from space.

    For this product, the convective cloud differential (ccd) and
    cloud slicing (csa) algorithm were used.
    [Product user manual.](https://sentinel.esa.int/documents/247904/2474726/Sentinel-5P-Level-2-Product-User-Manual-Ozone-Tropospheric-Column).
    [More information.](http://www.tropomi.eu/data-products/tropospheric-ozone-column).

    Unlike all other S5P products, this product was ingested directly without using
    `harpconvert`, as it is already a gridded product. Pixels with qa_value<70
    are masked out.

  ||| + s5p_desc,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'air_quality',
    'copernicus',
    'esa',
    'eu',
    'o3',
    'ozone',
    'pollution',
    's5p',
    'sentinel',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-04-30T10:50:26Z', null),
  summaries: {
    'gee:schema': COPERNICUS_S5P.schema(),
    gsd: [
      111320.0,
      55660.0,
    ],
    platform: [
      'Sentinel-5P',
    ],
    instruments: [
      'TROPOMI',
    ],
    'eo:bands': [
      {
        name: 'ozone_tropospheric_mixing_ratio',
        description: 'Average tropospheric ozone mixing ratio based on CCD algorithm.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'ozone_tropospheric_mixing_ratio_precision',
        description: 'Standard deviation of tropospheric ozone mixing ratio based on CCD algorithm.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'ozone_tropospheric_vertical_column',
        description: 'Average tropospheric ozone column based on CCD algorithm.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'ozone_tropospheric_vertical_column_precision',
        description: 'Standard deviation of tropospheric ozone column based on CCD algorithm.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'qa_value',
        description: |||
          A continuous quality descriptor, varying between 0 (no data) and 100
          (full quality data). Pixels with qa_value <= 70 are masked out.
        |||,
        'gee:units': 'mol/m^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lon: 7.0,
          lat: -1.1,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.02,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'ozone_tropospheric_vertical_column',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 2,
  },
  'gee:terms_of_use': COPERNICUS_S5P.terms_of_use,
}
