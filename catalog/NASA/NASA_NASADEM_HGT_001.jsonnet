local id = 'NASA/NASADEM_HGT/001';
local subdir = 'NASA';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NASADEM: NASA NASADEM Digital Elevation 30m',
  version: '1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    NASADEM is a reprocessing of SRTM data, with improved accuracy by incorporating auxiliary data
    from ASTER GDEM, ICESat GLAS, and PRISM datasets.

    The most significant processing improvements involve void reduction through improved
    phase unwrapping and using ICESat GLAS data for control.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/592/NASADEM_User_Guide_V1.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'nasa',
    'nasadem',
    'srtm',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA / USGS / JPL-Caltech', 'https://lpdaac.usgs.gov/products/nasadem_hgtv001/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2763264762-LPCLOUD',
  ],
  extent: ee.extent(-180.0, -56.0, 180.0, 60.0,
                    '2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    platform: [
      'Space Shuttle Endeavour',
    ],
    instruments: [
      'Shuttle Imaging Radar-C (SIR-C)',
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'elevation',
        description: |||
          Integer heights in the merged void-free DEM files are relative to the
          EGM96 geoid (whereas the floating-point heights in the SRTM-only DEM files are relative to
          the WGS84 ellipsoid).
        |||,
        'gee:units': units.meter,
      },
      {
        // TODO(b/198646525): Convert to use gee:classes
        name: 'num',
        description: |||
          Index indicating the data source and the number of source scenes.

            * 0: Water in corrected SRTM water body data
            * 1-23: SRTM 1-23 (max known is 23)
            * 41-94: PRISM 1-50 (54 max polar, 37 max elsewhere)
            * 110-160: GDEM3 (saturated at 50)
            * 170-220: GDEM2 (saturated at 50)
            * 231: SRTMv3 from GDEM3
            * 232: SRTMv2 from GDEM3
            * 233: SRTMv2 from GDEM2
            * 234: SRTM-with-NGA-fill from GDEM2
            * 241: NED from GDEM2 (USA)
            * 242: NED from GDEM3 (USA)
            * 243: CDED from GDEM2 (Canada)
            * 244: CDED from GDEM3 (Canada)
            * 245: Alaska from GDEM2 (Alaska)
            * 246: Alaska from GDEM3 (Alaska)
            * 250: Interpolation
            * 251: Quad edge averaged where two neighboring quads disagreed (generally a GDEM error)
            * 255: ERROR (if NUM IS MISSING - none known to exist)
        |||,
      },
      {
        name: 'swb',
        description: 'Updated SRTM water body data\n\n  * 0: Land\n  * 255: Water',
        'gee:classes': [
          {value: 0, description: 'Land', color: 'brown'},
          {value: 255, description: 'Water', color: 'cadetblue'}
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              6000.0,
            ],
            gamma: [
              1.6,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -512.0,
      maximum: 8768.0,
      'gee:estimated_range': true,
    },
    num: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    swb: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    NASA JPL (2020). NASADEM Merged DEM Global 1 arc second V001 [Data set]. NASA EOSDIS Land
    Processes DAAC. Accessed 2020-12-30 from [doi:10.5067/MEaSUREs/NASADEM/NASADEM_HGT.001](https://doi.org/10.5067/MEaSUREs/NASADEM/NASADEM_HGT.001)
  |||,
  'gee:terms_of_use': |||
    Unless otherwise noted, all NASA-produced data may be used for any purpose without
    prior permission. For more information and exceptions visit the
    [NASA Data & Information Policy page](https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy).
  |||,
}
