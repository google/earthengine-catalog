local id = 'TOMS/MERGED';
local subdir = 'TOMS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  ],
  id: id,
  title: 'TOMS and OMI Merged Ozone Data',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Total Ozone Mapping Spectrometer (TOMS) data represent the primary
    long-term, continuous record of satellite-based observations available for
    use in monitoring global and regional trends in total ozone over the past
    25 years. The data are produced by the Laboratory for Atmospheres at NASA's
    Goddard Space Flight Center. Version 8 TOMS data products include level 3
    gridded data (1.0 x 1.25 deg). The Ozone Monitoring Instrument (OMI), aboard
    the Aura satellite (July 2004 - current), has a higher resolution
    (1.0 x 1.0 deg).

    These data represent a merged ozone product from TOMS/EarthProbe,
    TOMS/Nimbus-7, TOMS/Meteor-3, OMI/Aura and USGS-interpolated data for dates
    with no data.

    [Additional TOMS and OMI information](https://ozoneaq.gsfc.nasa.gov/missions/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'atmosphere',
    'aura',
    'climate',
    'geophysical',
    'ges_disc',
    'goddard',
    'nasa',
    'omi',
    'ozone',
    'toms',
  ],
  providers: [
    ee.producer_provider('NASA / GES DISC', 'https://disc.gsfc.nasa.gov/information?page=1&keywords=acdisc'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1978-11-01T00:00:00Z', null),
  summaries: {
    gsd: [
      // OMI images are 1x1 degrees, but earlier ones are 1x1.25 degrees.
      // We don't have a way to represent mixed resolution, so we list
      // 1 degree as the resoilution.
      111000,
    ],
    platform: [
      'Aura',
      'EarthProbe',
      'Meteor-3',
      'Nimbus-7',
    ],
    instruments: [
      'OMI',
      'TOMS',
    ],
    'eo:bands': [
      {
        name: 'ozone',
        description: 'Total column ozone',
        'gee:units': units.dobson,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Column Ozone',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              100.0,
            ],
            max: [
              500.0,
            ],
            palette: [
              'blue',
              'cyan',
              'green',
              'yellow',
              'orange',
              'red',
            ],
            bands: [
              'ozone',
            ],
          },
        },
      },
    ],
    ozone: {
      minimum: 73.0,
      maximum: 983.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    The data set source should be properly cited when the data are used.
    A formal reference of the form: \\<authors\\>, 2012, last updated 2013:
    \\<dataset name\\>. NASA/GSFC, Greenbelt, MD, USA, NASA Goddard Earth Sciences
    Data and Information Services Center (GES DISC). Accessed
    \\<enter user data access date\\> at \\<DOI\\> is suggested following
    Parsons et al. (2010),
    [doi:10.1029/2010EO340001](https://doi.org/10.1029/2010EO340001)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Distribution of data from the Goddard Earth Sciences Data and
    Information Services Center (GES DISC) is funded by NASA's Science Mission
    Directorate (SMD). Consistent with NASA
    [Earth Science Data and Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy/),
    data from the GES DISC archive are available free to the user community.
    For more information visit the GES DISC
    [Data Policy](https://disc.sci.gsfc.nasa.gov/citing) page.
  |||,
}
