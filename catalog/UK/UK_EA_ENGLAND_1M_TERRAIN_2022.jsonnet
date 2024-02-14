local id = 'UK/EA/ENGLAND_1M_TERRAIN/2022';
local subdir = 'UK';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary {
  reference: 'https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/',
};

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'England 1m Composite DTM/DSM (Environment Agency)',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The LIDAR Composite DTM/DSM is a raster terrain model covering ~99% of
    England at 1m spatial resolution, produced by the UK Environment Agency in
    2022. The model contains 3 bands of terrain data: a Digital Terrain Model
    (DTM), a first return Digital Surface Model (DSM), and a last return DSM.

    The DTM is produced from the last or only laser pulse returned to the
    sensor. Surface objects are removed from the DSM, using bespoke algorithms
    and manual editing of the data, to produce a terrain model of just the
    surface. The DTM is derived from a combination of EA Time Stamped archive
    and National LIDAR Program surveys, which have been merged and re-sampled
    to give the best possible coverage. Where repeat surveys have been
    undertaken the newest, best resolution data is used. Where data was
    resampled a bilinear interpolation was used before being merged. The 2022
    LIDAR Composite contains surveys undertaken between 6th June 2000 and 2nd
    April 2022.

    The first return DSM is produced from the first or only laser pulse returned
    to the sensor and includes heights of objects, such as vehicles, buildings
    and vegetation, as well as the terrain surface where the first or only
    return was the ground. The first return DSM is derived from data captured as
    part of the National LIDAR Program between 11 November 2016 and 5th May
    2022. This program divided England into ~300 blocks for survey over
    continuous winters from 2016 onwards. These surveys are merged together to
    create the first return LIDAR composite using a feathering technique along
    the overlaps to remove any small differences in elevation between surveys.
    Please refer to the data provider's metadata index catalogs which show for
    any location which survey was used in the production of the LIDAR composite.
    The first return DSM will not match in coverage or extent of the last return
    DSM, as the last return DSM composite is produced from both the National
    LIDAR Program and Timeseries surveys.

    The last return DSM is produced from the last or only laser pulse returned
    to the sensor and includes heights of objects, such as vehicles, buildings
    and vegetation, as well as the terrain surface. The last return DTM is
    derived from a combination of EA Time Stamped archive and National LIDAR
    Program surveys, which have been merged and re-sampled to give the best
    possible coverage. Where repeat surveys have been undertaken the newest,
    best resolution data is used. Where data was resampled a bilinear
    interpolation was used before being merged. The 2022 LIDAR Composite
    contains surveys undertaken between 6th June 2000 and 2nd April 2022. Please
    refer to the data provider's metadata index catalogs which show for any
    location which survey was used in the production of the LIDAR composite.

    The data is aligned to the OS National grid and presented in metres,
    referenced to Ordinance Survey Newlyn and using the OSTN'15 transformation
    method. All individual LIDAR surveys going into the production of the
    composites had a vertical accuracy of +/-15cm root-mean-square error.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.data.gov.uk/dataset/01b3ee39-da3f-47b6-83da-dc98e73a461f/lidar-composite-digital-terrain-model-dtm-1m',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://www.data.gov.uk/dataset/92534f24-0b92-4b28-9986-347cf6678b39/lidar-composite-first-return-digital-surface-model-fz_dsm-1m',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://environment.data.gov.uk/dataset/9ba4d5ac-d596-445a-9056-dae3ddec0178',
    },
  ],
  keywords: [
    // 'uk',
    'lidar',
    'elevation',
    'dem',
  ],
  providers: [
    ee.producer_provider('UK Environment Agency', 'https://www.data.gov.uk/dataset/f0db0249-f17b-4036-9e65-309148c97ce4/national-lidar-programme'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-06-06T00:00:00Z', '2022-04-02T00:00:00Z'),
  summaries: {
    gsd: [1],
    'eo:bands': [
      {
        name: 'dtm',
        description: 'Digital Terrain Model',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_first',
        description: 'First Return Digital Surface Model',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_last',
        description: 'Last Return Digital Surface Model',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'DEM of Manchester, England',
        lookat: {lon: -1.99, lat: 53.61, zoom: 10},
        image_visualization: {
          band_vis: {
            min: [-142],
            max: [313],
            bands: ['dtm', 'dsm_first', 'dsm_last'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    You are free to: copy, publish, distribute and transmit the Information;
    adapt the Information; exploit the Information commercially and
    non-commercially for example, by combining it with other Information, or
    by including it in your own product or application.

    You must acknowledge the source of the Information in your product or
    application by including or linking to any attribution statement specified
    by the Information Provider(s) and, where possible, provide a link to the
    [license]
    (https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
    Attribution statement: Environment Agency copyright and/or database right
    2022. All rights reserved.
  |||,
}