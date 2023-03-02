local id = 'NOAA/CDR/GRIDSAT-B1/V2';
local subdir = 'NOAA/CDR';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NOAA CDR GRIDSAT-B1: Geostationary IR Channel Brightness Temperature',
  version: 'V2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides a high quality Climate Data
    Record (CDR) of global infrared measurements from geostationary satellites.

    The geostationary satellite data (GridSat-B1) provides data from 3
    channels: the CDR-quality infrared window (IRWIN) channel (near 11μm),
    the visible channel (near 0.6μm) and the infrared water vapor (IRWVP)
    channel (near 6.7μm). The GridSat-B1 data is projected onto a global
    0.07 degree latitude equal-angle grid with date coverage spanning from
    1980-present. This data is sourced from the 3-hourly International Satellite
    Cloud Climatology Project (ISCCP) B1 data. The satellites included in this
    dataset with their longitudinal coverage over time can be seen [here](https://www.ncdc.noaa.gov/gridsat/images/isccp_coverage_VZA60_nolegend.png).
    In regions of overlap the CDR methodology merges satellites by selecting
    the nadir-most observations for each grid point.

    Notes:

    - Mappings from satid to satellite name are contained in the image's
      properties as satid_number: \"satellite_name\", e.g. satid_0: GOES-13,
      satid_1: GOES-15, and satid_2: GOES-16.

    - IRWIN data has been corrected for view zenith angle, but this correction
      is not perfect. It also treats all satellites the same way, whereas the
      view zenith angle dependence will vary by satellite. Some VZA residual
      will be apparent.

    - IRWVP data has no view zenith angle correction and is not CDR quality.

    - VSCHN data has no view zenith angle corrections and is not CDR quality.

    - Removing the View Zenigth Angle correction for the IRWIN channels can be
      done with the following:
      Original_temperature_observed = irwin_cdr - irwin_vza_adj
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V59P2ZKR',
    },
  ],
  keywords: [
    'brightness',
    'cdr',
    'fundamental',
    'geostationary',
    'infrared',
    'isccp',
    'noaa',
    'reflectance',
    'sr',
  ],
  providers: [
    ee.producer_provider(
      'NOAA',
      'https://www.ncei.noaa.gov/products/climate-data-records/geostationary-IR-channel-brightness-temperature'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1980-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'satid_0',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'satid_1',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'satid_2',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'satid_3',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'satid_4',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'satid_5',
        description: 'Satellite name (see notes)',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      7792.0,
    ],
    'eo:bands': [
      {
        name: 'irwin_cdr',
        description: 'Brightness temperature near 11μm, nadir-most observation',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 200.0,
      },
      {
        name: 'irwin_2',
        description: 'Brightness temperature near 11μm, second-best observation\n(based on view zenith angle)',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 200.0,
      },
      {
        name: 'irwin_3',
        description: 'Brightness temperature, third-best observation based on\nview zenith angle',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 200.0,
      },
      {
        name: 'irwvp',
        description: 'Brightness temperature near 6.7μm, nadir-most observation',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 200.0,
      },
      {
        name: 'irwvp_2',
        description: 'Brightness temperature near 6.7μm, second-best observation\nbased on view zenith angle',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 200.0,
      },
      {
        name: 'vschn',
        description: 'Visible reflectance near 0.6μm, nadir-most observation',
        'gee:scale': 4e-05,
        'gee:offset': 1.0,
      },
      {
        name: 'vschn_2',
        description: 'Visible reflectance near 0.6μm, second-best observation\nbased on view zenith angle',
        'gee:scale': 4e-05,
        'gee:offset': 1.0,
      },
      {
        name: 'irwin_vza_adj',
        description: |||
          Adjustment made to all IRWIN channels. Provided to allow
          users to reverse the view zenith correction for the irwin_cdr variable.
        |||,
        'gee:units': units.kelvin,
        'gee:scale': 0.25,
        'gee:offset': -10.0,
      },
      {
        name: 'satid_ir1',
        description: |||
          satid values for irwin_cdr. For this and other satid bands,
          the mappings of satid to satellite name are given in the properties for
          each image
        |||,
      },
      {
        name: 'satid_ir2',
        description: 'satid values per pixel for irwin_2',
      },
      {
        name: 'satid_ir3',
        description: 'satid values per pixel for irwin_3',
      },
      {
        name: 'satid_wv1',
        description: 'satid values per pixel for irwvp',
      },
      {
        name: 'satid_wv2',
        description: 'satid values per pixel for irwvp2',
      },
      {
        name: 'satid_vs1',
        description: 'satid values per pixel for vischn',
      },
      {
        name: 'satid_vs2',
        description: 'satid values per pixel for vischn2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Brightness Temperature / Visible Reflectance',
        lookat: {
          lat: 17.93,
          lon: 7.71,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              500.0,
            ],
            max: [
              10000.0,
            ],
            bands: [
              'irwin_cdr',
              'vschn',
              'irwvp',
            ],
          },
        },
      },
    ],
    irwin_cdr: {
      minimum: -2093.0,
      maximum: 13615.0,
      'gee:estimated_range': true,
    },
    irwin_2: {
      minimum: -4123.0,
      maximum: 13579.0,
      'gee:estimated_range': true,
    },
    irwin_3: {
      minimum: -1624.0,
      maximum: 14240.0,
      'gee:estimated_range': true,
    },
    irwvp: {
      minimum: -5907.0,
      maximum: 10219.0,
      'gee:estimated_range': true,
    },
    irwvp_2: {
      minimum: -5081.0,
      maximum: 10260.0,
      'gee:estimated_range': true,
    },
    vschn: {
      minimum: -25000.0,
      maximum: 4275.0,
      'gee:estimated_range': true,
    },
    vschn_2: {
      minimum: -25000.0,
      maximum: 3800.0,
      'gee:estimated_range': true,
    },
    irwin_vza_adj: {
      minimum: 36.0,
      maximum: 171.0,
      'gee:estimated_range': true,
    },
    satid_ir1: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_ir2: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_ir3: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_wv1: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_wv2: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_vs1: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
    satid_vs2: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V59P2ZKR',
  'sci:citation': |||
    Kenneth R. Knapp, and NOAA CDR Program (2014): NOAA Climate Data Record
    (CDR) of Gridded Satellite Data from ISCCP B1 (GridSat-B1) 11 micron
    Brightness Temperature, Version 2. [indicate subset used]. NOAA National
    Climatic Data Center. [doi:10.7289/V59P2ZKR](https://doi.org/10.7289/V59P2ZKR)
    [access date].
  |||,
  'sci:publications': [
    {
      citation: |||
        Knapp, K. R., S. Ansari, C. L. Bain, M. A. Bourassa, M. J. Dickinson,
        C. Funk, C. N. Helms, C. C. Hennon, C. D. Holmes, G. J. Huffman, J. P.
        Kossin, H.-T. Lee, A. Loew, and G. Magnusdottir, 2011: Globally gridded
        satellite (GridSat) observations for climate studies. Bulletin of the
        American Meteorological Society, 92, 893-907.
        [doi:10.1175/2011BAMS3039.1](https://doi.org/10.1175/2011BAMS3039.1)
      |||,
      doi: '10.1175/2011BAMS3039.1',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
