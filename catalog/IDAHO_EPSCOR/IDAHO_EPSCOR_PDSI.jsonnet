local id = 'IDAHO_EPSCOR/PDSI';
local successor_id = 'GRIDMET/DROUGHT';
local subdir = 'IDAHO_EPSCOR';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'PDSI: University of Idaho Palmer Drought Severity Index [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Palmer Drought Severity Index dataset provides
    high spatial resolution (~4-km) thrice-monthly estimates of this
    widely used measure of integrated water supply and demand anomalies
    across the contiguous United States from 1979-present. The PDSI
    is calculated using precipitation and potential evapotranspiration
    derived from the gridded meteorological dataset of Abatzoglou (2013).

    Potential evapotranspiration is computed using the Penman-Montieth
    equation for a reference grass surface. Available soil water holding
    capacity in the top 2.5m of the soil was derived from the STATSGO
    soils database and used in the computations. Whereas PDSI has typically
    been computed on monthly timescales, we compute these data three-times
    a month to provide more timely updates. Due to the spin-up of PDSI
    calculations, data for the first year of record should be used
    sparingly.

    This dataset contains provisional products that are replaced with
    updated versions when the complete source data become available.
    Products can be distinguished by the value of the 'status' property.
    At first, assets are ingested with status='early'. After several
    days, they are replaced by assets with status='provisional'.
    After about 2 months, they are replaced by the final assets with
    status='permanent'.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, ee_const.catalog_base + 'GRIDMET/GRIDMET_DROUGHT.json'),
  ],
  keywords: [
    'climate',
    'conus',
    'crop',
    'drought',
    'geophysical',
    'merced',
    'palmer',
    'pdsi',
  ],
  providers: [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/gridmet.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.9, 24.9, -66.8, 49.6,
                    '1979-03-01T00:00:00Z', '2020-06-20T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'early', 'provisional', or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'pdsi',
        description: |||
          Possible values: 4.0 or more (extremely wet), 3.0
          to 3.99 (very wet), 2.0 to 2.99 (moderately wet), 1.0 to 1.99
          (slightly wet), 0.5 to 0.99 (incipient wet spell), 0.49 to -0.49
          (near normal), -0.5 to -0.99 (incipient dry spell), -1.0 to -1.99
          (mild drought), -2.0 to -2.99 (moderate drought), -3.0 to -3.99
          (severe drought), or -4.0 or less (extreme drought).
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'PDSI',
        lookat: {
          lat: 38.686,
          lon: -115.356,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              -5.0,
            ],
            max: [
              10.0,
            ],
            palette: [
              'red',
              'yellow',
              'green',
              'cyan',
              'blue',
            ],
            bands: [
              'pdsi',
            ],
          },
        },
      },
    ],
    pdsi: {
      minimum: -11.94,
      maximum: 17.92,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Abatzoglou J.T., R. Barbero, J.W. Wolf, Z. Holden (2014), Tracking
    interannual streamflow variability with drought indices in the
    Pacific Northwest, US, Journal of Hydrometeorology, 15, 1900-1912.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 10,
  },
  'gee:terms_of_use': |||
    This work (METDATA, by John Abatzoglou) is in the public
    domain and is free of known copyright restrictions. Users should
    properly cite the source used in the creation of any reports and
    publications resulting from the use of this dataset and note the
    date when the data was acquired.
  |||,
  version: ee_const.version_unknown,
}
