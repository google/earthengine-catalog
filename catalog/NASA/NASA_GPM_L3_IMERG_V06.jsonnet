local id = 'NASA/GPM_L3/IMERG_V06';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/IMERG_HHR_versions.libsonnet';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GPM: Global Precipitation Measurement (GPM) ' + version +
  ' [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Global Precipitation Measurement (GPM) is an international
    satellite mission to provide next-generation observations of
    rain and snow worldwide every three hours. The Integrated Multi-satellitE
    Retrievals for GPM (IMERG) is the unified algorithm that provides
    rainfall estimates combining data from all passive-microwave
    instruments in the GPM Constellation.

    This algorithm is intended to intercalibrate, merge, and interpolate
    all satellite microwave precipitation estimates, together with
    microwave-calibrated infrared (IR) satellite estimates, precipitation
    gauge analyses, and potentially other precipitation estimators at fine
    time and space scales for the TRMM and GPM eras over the entire globe.
    The system is run several times for each observation time, first
    giving a quick estimate and successively providing better estimates
    as more data arrive. The final step uses monthly gauge data to
    create research-level products. See [IMERG Technical Documentation](https://pmm.nasa.gov/sites/default/files/document_files/IMERG_doc.pdf)
    for more details on the algorithm.

    Documentation:

    * [Algorithm Theoretical Basis Document](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/IMERG_ATBD_V06.pdf)

    * [IMERG Quality Index](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/IMERGV06_QI.pdf)

    * [Caveats for IMERG extension into TRMM era](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/IMERGV06_TRMMera-caveats.pdf)

    * [IMERG Technical Documentation](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/IMERG_doc.06.pdf)

    * [Release notes; New Morphing algorithm](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/MorphingInV06IMERG.pdf)

    * [Remote-Sensing Reflectance](https://gpm1.gesdisc.eosdis.nasa.gov/data/doc/README.GPM.pdf)

    * [Anomalies](https://gpmweb2https.pps.eosdis.nasa.gov/tsdis/AB/docs/gpm_anomalous.html)

    This collection contains provisional
    products that are regularly replaced with updated versions when
    the data become available. The products are marked with a metadata
    property called 'status'. When a product is initially made available,
    the property value is 'provisional'. Once a provisional product
    has been updated with the final version, this value is updated
    to 'permanent'.

    This collection contains data from:

    * GPM_3IMERGHH_V06 [doi:10.5067/GPM/IMERG/3B-HH-L/06](https://doi.org/10.5067/GPM/IMERG/3B-HH-L/06)
    * GPM_3IMERGHH_06 [doi:10.5067/GPM/IMERG/3B-HH/06](https://doi.org/10.5067/GPM/IMERG/3B-HH/06)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'ftp://198.118.195.100/gpmallversions/V06',
    },
    {
      rel: ee_const.rel.source,
      href: 'ftp://198.118.195.61/data/imerg/late/',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/GPM/IMERG/3B-HH-L/06',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/GPM/IMERG/3B-HH/06',
    },
  ] + version_config.version_links,
  keywords: [
    'climate',
    'geophysical',
    'gpm',
    'half_hourly',
    'imerg',
    'jaxa',
    'nasa',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider(
      'NASA GES DISC at NASA Goddard Space Flight Center',
       'https://doi.org/10.5067/GPM/IMERG/3B-HH/06'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1598621093-GES_DISC',
  ],
  extent: ee.extent_global('2000-06-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: 'HQobservationTime',
        description: 'PMW source time',
        'gee:units': 'min. into half hour',
      },
      {
        name: 'HQprecipSource',
        description: 'PMW source sensor identifier',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'PMW source sensor identifier',
              bit_count: 4,
              values: [
                {
                  description: 'No observation',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'TMI',
                },
                {
                  value: 2,
                  description: '(unused)',
                },
                {
                  value: 3,
                  description: 'AMSR',
                },
                {
                  value: 4,
                  description: 'SSMI',
                },
                {
                  value: 5,
                  description: 'SSMIS',
                },
                {
                  value: 6,
                  description: 'AMSU',
                },
                {
                  value: 7,
                  description: 'MHS',
                },
                {
                  value: 8,
                  description: 'SAPHIR',
                },
                {
                  value: 9,
                  description: 'GMI',
                },
                {
                  value: 10,
                  description: '(unused)',
                },
                {
                  value: 11,
                  description: 'ATMS',
                },
                {
                  value: 12,
                  description: 'AIRS',
                },
                {
                  value: 13,
                  description: 'TOVS',
                },
                {
                  value: 14,
                  description: 'CRIS',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 4,
        },
      },
      {
        name: 'HQprecipitation',
        description: 'merged PMW precipitation',
        'gee:units': 'mm/hr',
      },
      {
        name: 'IRkalmanFilterWeight',
        description: 'Kalman filter weight for IR',
        'gee:units': units.percent,
      },
      {
        name: 'IRprecipitation',
        description: 'IR precipitation',
        'gee:units': 'mm/hr',
      },
      {
        name: 'precipitationCal',
        description: 'snapshot precipitation - calibrated',
        'gee:units': 'mm/hr',
      },
      {
        name: 'precipitationUncal',
        description: 'snapshot precipitation - uncalibrated',
        'gee:units': 'mm/hr',
      },
      {
        name: 'probabilityLiquidPrecipitation',
        description: 'probability of liquid precipitation phase',
        'gee:units': units.percent,
      },
      {
        name: 'randomError',
        description: 'calibrated-precipitation random error',
        'gee:units': 'mm/hr',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation (mm/hr)',
        lookat: {lon: -76, lat: 33, zoom: 3},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [15],
            bands: ['precipitationCal'],
          },
        },
      },
    ],
    HQobservationTime: {minimum: 0, maximum: 29, 'gee:estimated_range': true},
    HQprecipitation: {minimum: 0, maximum: 120, 'gee:estimated_range': true},
    IRkalmanFilterWeight: {
      minimum: 0, maximum: 100, 'gee:estimated_range': true},
    IRprecipitation: {minimum: 0.0, maximum: 79.5, 'gee:estimated_range': true},
    precipitationCal: {minimum: 0, maximum: 174, 'gee:estimated_range': true},
    precipitationUncal: {minimum: 0, maximum: 120, 'gee:estimated_range': true},
    probabilityLiquidPrecipitation: {
      minimum: 0, maximum: 100, 'gee:estimated_range': true},
    randomError: {minimum: 0.24, maximum: 250.00, 'gee:estimated_range': true},
  },
  'sci:doi': '10.5067/GPM/IMERG/3B-HH-L/06',
  'sci:citation': |||
    Huffman, G.J., E.F. Stocker, D.T. Bolvin, E.J. Nelkin, Jackson Tan (2019),
    GPM IMERG Final Precipitation L3 Half Hourly 0.1 degree x 0.1 degree V06,
    Greenbelt, MD, Goddard Earth Sciences Data and Information Services Center
    (GES DISC), Accessed: [Data Access Date],
    [doi:10.5067/GPM/IMERG/3B-HH/06](https://doi.org/10.5067/GPM/IMERG/3B-HH/06)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'minute',
    interval: 30,
  },
  'gee:terms_of_use':
    'All NASA-produced data from the GPM mission is made ' +
    'freely available for the public to use.',
}
