local id = 'MODIS/061/MOD10A2';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD10A2.libsonnet';

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
  title: 'MOD10A2.061 Terra Snow Cover 8-Day L3 Global 500m',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    MOD10A2 is a snow cover dataset from the MODIS on the Terra satellite.
    The dataset reports the maximum snow cover extent during an eight-day
    period at the resolution of 500 m.

    An eight-day compositing period was chosen because that is the exact ground
    track repeat period of the Terra and Aqua platforms. Snow cover over eight
    days is mapped as maximum snow extent in one SDS and as a chronology of
    observations in the other SDS. Eight-day periods begin on the first day of
    the year and extend into the next year. The product can be produced with
    two to eight days of input. There may not always be eight days of input,
    because of various reasons, so the user should check the attributes to
    determine on what days observations were obtained.

    * [General documentation](https://doi.org/10.5067/MODIS/MOD10A2.061)
    * [User's Guide]( https://modis-snow-ice.gsfc.nasa.gov/uploads/snow_user_guide_C6.1_final_revised_april.pdf),
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD10A1.061',
    },
  ],
  keywords: [
    'daily',
    'geophysical',
    'global',
    'modis',
    'nasa',
    'nsidc',
    'snow',
    'terra',
  ],
  providers: [
    ee.producer_provider('NASA NSIDC DAAC at CIRES',
    'https://doi.org/10.5067/MODIS/MOD10A2.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1646610415-NSIDC_ECS',
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD10A2.061',
  'sci:citation': |||
    Hall, D. K., V. V. Salomonson, and G. A. Riggs. 2016. MODIS/Terra
    Snow Cover Daily L3 Global 500m Grid. Version 6. Boulder, Colorado
    USA: NASA National Snow and Ice Data Center Distributed Active
    Archive Center.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    You may download and use photographs, imagery, or text
    from the NSIDC web site, unless limitations for its use are specifically
    stated. For more information on usage and citing NSIDC datasets,
    please visit the
    [NSIDC 'Use and Copyright' page](https://nsidc.org/about/data-use-and-copyright).
  |||,
}
