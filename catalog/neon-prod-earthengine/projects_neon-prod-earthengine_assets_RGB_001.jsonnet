local id = 'projects/neon-prod-earthengine/assets/RGB/001';
local subdir = 'neon-prod-earthengine';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local units = import 'units.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'NEON RGB Camera Imagery',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    High resolution Red-Green-Blue (RGB) orthorectified camera images mosaicked
    and output onto a fixed, uniform spatial grid using nearest-neighbor resampling;
    spatial resolution is 0.1 m.  The digital camera is part of a suite of instruments
    on the NEON Airborne Observation Platform (AOP) that also includes a
    full-waveform LiDAR system and the NEON Imaging Spectrometer. In the
    orthorectification process, the digital imagery is re-mapped to the same
    geographic projection as the LiDAR and imaging spectrometer data that is
    acquired simultaneously. The resulting images share the same map projection
    grid space as the orthorectified spectrometer and LiDAR imagery. Since the
    digital camera imagery is acquired at higher spatial resolution than the
    imaging spectrometer data, it can aid in identifying features in the
    spectrometer images including manmade features (e.g., roads, fence lines,
    and buildings) that are indicative of land-use change.

    See [NEON Data Product
    DP3.30010.001](https://data.neonscience.org/data-products/DP3.30010.001) for
    more details.

    Documentation: [NEON DP3.30010.001 Camera imagery mosaic Quick Start
    Guide](https://data.neonscience.org/api/v0/documents/quick-start-guides/NEON.QSG.DP3.30010.001v1?inline=true&fallback=html)

    Tutorial: [Intro to AOP Data in Google Earth Engine Tutorial Series](
    https://www.neonscience.org/resources/learning-hub/tutorials/intro-aop-data-google-earth-engine-tutorial-series)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    // TODO(bhass-neon): Add doi link.
    // {
    //   rel: ee_const.rel.cite_as,
    //   href: '',
    //   type: ee_const.media_type.html,
    // },
  ],
  keywords: [
    'airborne',
    'forest',
    'highres',
    'neon',
    'orthophoto',
    'rgb',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NEON', 'https://data.neonscience.org/data-products/DP3.30010.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-170, 16, -66, 73, '2013-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'AOP_VISIT_NUMBER',
        description: 'Unique visit number to the NEON site.',
        type: ee_const.var_type.int,
      },
      {
        name: 'CITATION',
        description: 'Data citation. See ' +
        '[NEON Data Policies and Citation Guidelines]' +
        '(https://www.neonscience.org/data-samples/data-policies-citation).',
        type: ee_const.var_type.string,
      },
      {
        name: 'DOI',
        description: 'Digital Object Identifier. NEON data that have been released are assigned a DOI.',
        type: ee_const.var_type.string,
      },
      {
        name: 'FLIGHT_YEAR',
        description: 'Year the data were collected.',
        type: ee_const.var_type.int,
      },
      {
        name: 'NEON_DOMAIN',
        description:
          'NEON eco-climatic domain code, "D01" to "D20". See ' +
          '[NEON Field Sites and Domains]' +
          '(https://www.neonscience.org/field-sites/about-field-sites).',
        type: ee_const.var_type.string,
      },
      {
        name: 'NEON_SITE',
        description: 'NEON four-digit site code. See ' +
        '[NEON Field Sites](https://www.neonscience.org/field-sites/).',
        type: ee_const.var_type.string,
      },
      {
        name: 'NEON_DATA_PROD_URL',
        description: 'NEON data product url. Always set to: ' +
        '[https://data.neonscience.org/data-products/DP3.30010.001]' +
        '(https://data.neonscience.org/data-products/DP3.30010.001).',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_NAME',
        description:
          'Make and model of the camera sensor: ' +
          '"Phase One D8900", "Phase One IQ180", ' +
          '"Phase One iX-RS 1000", "Phase One iXM-RS 150F".',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_SERIAL',
        description:
          'Serial number of the camera sensor: ' +
          '"EH021537", "EH021656", "EH021554", "FT010031", ' +
          '"MM010175", "MM010176", "YC030119", "YC030129".',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROVISIONAL_RELEASED',
        description: 'Whether the data are Provisional or Released. See ' +
        '[NEON Data Revisions and Releases]' +
        '(https://www.neonscience.org/data-samples/data-management/data-revisions-releases).',
        type: ee_const.var_type.string,
      },
      {
        name: 'RELEASE_YEAR',
        description: 'If data are released, the year of the NEON Release Tag.',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [0.1],
    platform: ['NEON'],
    instruments: [
      'Phase One D8900',
      'Phase One IQ180',
      'Phase One iX-RS 1000',
      'Phase One iXM-RS 150F',
    ],
    'eo:bands': [
      {
        name: 'R',
        description: 'Red',
        'gee:units': units.dn,
      },
      {
        name: 'G',
        description: 'Green',
        'gee:units': units.dn,
      },
      {
        name: 'B',
        description: 'Blue',
        'gee:units': units.dn,
      },
    ],
    // TODO(bhass-neon): Check the range values for bands.
    R: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    G: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    B: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: { lon: -122.32, lat: 45.75, zoom: 12 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            bands: ['R', 'G', 'B'],
          },
        },
      },
    ],
  },
  'sci:citation': 'See [NEON citation guidelines](https://www.neonscience.org/data-samples/guidelines-policies/citing)',
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    All data collected by NEON and provided as data products, with the exception
    of data related to rare, threatened, or endangered (RTE) species, are
    released to the public domain under [Creative Commons CC0 1.0 "No Rights
    Reserved"](https://creativecommons.org/publicdomain/zero/1.0/). No
    copyright has been applied to NEON data; any person may copy, modify, or
    distribute the data, for commercial or non-commercial purposes, without
    asking for permission. NEON data may still be subject to other laws or
    rights such as for privacy, and NEON makes no warranties about the data and
    disclaims all liability. When using or citing NEON data, no implication
    should be made about endorsement by NEON. In most countries, data and facts
    are not copyrightable.  By putting NEON data into the public domain, we
    encourage broad use, particularly in scientific analyses and data
    aggregations. However, please be aware of the following scholarly norms:
    NEON data should be used in a way that is mindful of the limitations of the
    data, using the documentation associated with the data packages as a guide. 
    Please refer to [NEON Data Guidelines and Policies](https://www.neonscience.org/data-samples/guidelines-policies)
    for detailed information on how to properly use and cite NEON data, as well as
    best practices for publishing research that uses NEON data.
  |||,
}
