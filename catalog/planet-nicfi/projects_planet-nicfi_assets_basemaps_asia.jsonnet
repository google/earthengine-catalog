local id = 'projects/planet-nicfi/assets/basemaps/asia';
local subdir = 'planet-nicfi';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local common = import 'planet-nicfi.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

std.mergePatch(common, {
  id: id,
  title: 'NICFI Satellite Data Program Basemaps for Tropical Forest Monitoring - Asia',
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.license,
      href: 'https://assets.planet.com/docs/Planet_ParticipantLicenseAgreement_NICFI.pdf',
      type: ee_const.media_type.pdf,
    },
  ],
  providers: [
    ee.producer_provider('Planet', 'https://planet.com/nicfi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -27.5, 180.0, 30.2,
                    '2015-12-01T00:00:00Z', null),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'True color',
        lookat: {
          lat: 1.35,
          lon: 118.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [64.0],
            max: [5454.0],
            gamma: [1.855],
            bands: ['R', 'G', 'B'],
          },
        },
      },
    ],
  }
})
