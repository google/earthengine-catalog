local id = 'NOAA/PERSIANN-CDR';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'PERSIANN-CDR: Precipitation Estimation From Remotely Sensed Information Using Artificial Neural Networks-Climate Data Record',
  version: 'Version 1 Revision 1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    PERSIANN-CDR is a daily quasi-global precipitation product
    that spans the period from 1983-01-01 to present.  The data is
    produced quarterly, with a typical lag of three months. The product
    is developed by the Center for Hydrometeorology and Remote Sensing
    at the University of California, Irvine (UC-IRVINE/CHRS) using
    Gridded Satellite (GridSat-B1) IR data that are derived from merging
    ISCCP B1 IR data, along with GPCP version 2.2.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'source',
      href: 'https://www.ncei.noaa.gov/data/precipitation-persiann/access/',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.7289/V51V5BWQ',
    },
  ],
  keywords: [
    'cdr',
    'climate',
    'geophysical',
    'ncdc',
    'noaa',
    'persiann',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA NCDC', 'https://doi.org/10.7289/V51V5BWQ'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0, '1983-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'precipitation',
        description: 'Estimated daily precipitation',
        'gee:units': 'mm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 3.34,
          lon: 113.03,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
            palette: [
              '3907ff',
              '03fff3',
              '28ff25',
              'fbff09',
              'ff1105',
            ],
            bands: [
              'precipitation',
            ],
          },
        },
      },
    ],
    precipitation: {
      minimum: 0.0,
      maximum: 718.62,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V51V5BWQ',
  'sci:citation': |||
    Cite this dataset when used as a source: Sorooshian, Soroosh;
    Hsu, Kuolin; Braithwaite, Dan; Ashouri, Hamed; and NOAA CDR Program
    (2014): NOAA Climate Data Record (CDR) of Precipitation Estimation
    from Remotely Sensed Information using Artificial Neural Networks
    (PERSIANN-CDR), Version 1 Revision 1. [indicate subset used]. NOAA
    National Centers for Environmental Information. doi:
    [doi:10.7289/V51V5BWQ](https://doi.org/10.7289/V51V5BWQ)
    [access date].
  |||,
  'sci:publications': [
    {
      citation: |||
        Publications using this dataset should also cite the following
        journal article: Ashouri H., K. Hsu, S. Sorooshian, D. K. Braithwaite,
        K. R. Knapp, L. D. Cecil, B. R. Nelson, and O. P. Prat, 2015: PERSIANN-CDR:
        Daily Precipitation Climate Data Record from Multi-Satellite Observations
        for Hydrological and Climate Studies. Bull. Amer. Meteor. Soc.,
        [doi:10.1175/BAMS-D-13-00068.1](https://doi.org/10.1175/BAMS-D-13-00068.1).
      |||,
      doi: '10.1175/BAMS-D-13-00068.1',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    CDR data sets are nonproprietary, publicly available,
    and no restrictions are placed upon their use. For additional information,
    see the [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www.ncdc.noaa.gov/sites/default/files/cdr-documentation/UseAgreement_0.pdf)
    document.
  |||,
}
