local id = 'projects/planet-nicfi/assets/basemaps/africa';
local subdir = 'planet-nicfi';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local common = import 'planet-nicfi.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

std.mergePatch(common, {
  id: id,
  title: 'Planet & NICFI Basemaps for Tropical Forest Monitoring - Tropical Africa',
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
  extent: ee.extent(-25.5, -30.4, 58.0, 25.6,
                    '2015-12-01T00:00:00Z', null),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'True color',
        lookat: {
          lon: 23.35,
          lat: -2.4,
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
