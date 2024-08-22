local id = 'ACA/reef_habitat/v1_0';
local versions = import 'versions.libsonnet';
local version_table = import 'ACA_versions.libsonnet';

local subdir = 'ACA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

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
  title: 'Allen Coral Atlas (ACA) - Geomorphic Zonation and Benthic Habitat - v1.0 [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    The [Allen Coral Atlas](https://allencoralatlas.org/) dataset maps the
    geomorphic zonation and benthic habitat for the world's shallow coral reefs at
    5m pixel resolution. The underlying satellite image data are temporal
    composites of [PlanetScope satellite](https://www.planet.com/products/basemap/)
    imagery spanning 2018-2020. The habitat maps are created via a machine learning
    approach with contextual editing, using a range of imagery, bathymetry, and
    derived products as input data, trained via a globally consistent reference
    dataset. A global mask layer is also included for use when generating global
    reporting statistics. A full description of the methods and approaches can be
    found in the methods section of the [Allen Coral Atlas
    website](https://allencoralatlas.org/methods/).

    The Allen Coral Atlas was funded by [Vulcan Inc.](https://vulcan.com/) and
    is managed by the [Arizona State University Center for Global Discovery and
    Conservation Science](https://gdcs.asu.edu/). Partners include
    [Planet](https://www.planet.com/), the [University of
    Queensland](https://www.uq.edu.au/), and the [National Geographic
    Society](https://www.nationalgeographic.org/).

    Scientific background publications:

    - Lyons, M. B., Roelfsema, C. M., Kennedy, E. V., Kovacs, E. M., Borrego-Acevedo, R., Markey, K., ... & Murray, N. J. (2020). Mapping the world's coral reefs using a global multiscale earth observation framework. Remote Sensing in Ecology and Conservation, 6(4), 557-568. [doi:10.1002/rse2.157](https://doi.org/10.1002/rse2.157)

    - Kennedy, E. V., Roelfsema, C. M., Lyons, M. B., Kovacs, E. M., Borrego-Acevedo, R., Roe, M., ... & Tudman, P. (2021). Reef Cover, a coral reef classification for global habitat mapping from remote sensing. Scientific Data, 8(1), 1-20. [doi:10.1038/s41597-021-00958-z](https://doi.org/10.1038/s41597-021-00958-z)

    - Roelfsema, C. M., Lyons, M., Murray, N., Kovacs, E. M., Kennedy, E., Markey, K., ... & Phinn, S. R. (2021). Workflow for the generation of expert-derived training and validation data: a view to global scale habitat mapping. Frontiers in Marine Science.  [doi:10.3389/fmars.2021.643381](https://doi.org/10.3389/fmars.2021.643381)

    - Li, J., Knapp, D. E., Lyons, M., Roelfsema, C., Phinn, S., Schill, S. R., & Asner, G. P. (2021). Automated global shallow water bathymetry mapping using Google Earth Engine. Remote Sensing, 13(8), 1469. [doi:10.3390/rs13081469](https://doi.org/10.3390/rs13081469)

    - Li, J., Knapp, D. E., Fabina, N. S., Kennedy, E. V., Larsen, K., Lyons, M. B., ... & Asner, G. P. (2020). A global coral reef probability map generated using convolutional neural networks. Coral Reefs, 39(6), 1805-1815. [doi:10.1007/s00338-020-02005-6](https://doi.org/10.1007/s00338-020-02005-6)

    Allen Coral Atlas maps, bathymetry and map statistics are &copy; 2020 Allen
    Coral Atlas Partnership and Vulcan, Inc.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://storage.googleapis.com/coral-atlas-user-downloads-prod/Global-Dataset-20211006223100.zip',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.3833242',
    },
  ] + version_config.version_links,
  keywords: [
    'coral',
    'ocean',
    'planet_derived',
    'reef',
    'seagrass',
    'sentinel2_derived',
  ],
  providers: [
    ee.producer_provider(
      'Allen Coral Atlas Partnership (ACA)', 'https://allencoralatlas.org/'),
    ee.host_provider(self_ee_catalog_url),
    {
      name: 'University of Queensland (UQ)',
      roles: ['licensor', 'producer'],
      url: 'https://www.uq.edu.au/',
    },
    {
      name: 'Arizona State University Center for Global Discovery and ' +
        'Conservation Science (ASU GDCS)',
      roles: ['licensor', 'producer'],
      url: 'https://gdcs.asu.edu/',
    },
    {
      name: 'National Geographic Society (NGS)',
      roles: ['licensor', 'producer'],
      url: 'https://www.nationalgeographic.org/',
    },
    {
      name: 'Vulcan Inc. (Vulcan)',
      roles: ['licensor', 'producer'],
      url: 'https://vulcan.com/',
    },
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -33.0, 180.0, 33.0,
                    '2018-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      5.0,
    ],
    'eo:bands': [
      {
        name: 'geomorphic',
        description: 'Classification of geomorphic zonation.',
        'gee:classes': [
          {
            color: '000000',
            description: 'Unmapped',
            value: 0,
          },
          {
            value: 11,
            color: '77d0fc',
            description: |||
              Shallow Lagoon - Shallow Lagoon is any closed to semi-enclosed, sheltered, flat-bottomed shallow sediment-dominated lagoon area.
            |||,
          },
          {
            value: 12,
            color: '2ca2f9',
            description: |||
              Deep Lagoon - Deep Lagoon is any sheltered broad body of water semi-enclosed to enclosed by reef, with a variable depth (but shallower than surrounding ocean) and a soft bottom dominated by reef-derived sediment.
            |||,
          },
          {
            value: 13,
            color: 'c5a7cb',
            description: |||
              Inner Reef Flat - Inner Reef Flat is a low energy, sediment-dominated, horizontal to gently sloping platform behind the Outer Reef Flat.
            |||,
          },
          {
            value: 14,
            color: '92739d',
            description: |||
              Outer Reef Flat - Adjacent to the seaward edge of the reef, Outer Reef Flat is a level (near horizontal), broad and shallow platform that displays strong wave-driven zonation
            |||,
          },
          {
            value: 15,
            color: '614272',
            description: |||
              Reef Crest - Reef Crest is a zone marking the boundary between the reef flat and the reef slope, generally shallow and characterized by highest wave energy absorbance.
            |||,
          },
          {
            value: 16,
            color: 'fbdefb',
            description: |||
              Terrestrial Reef Flat - Terrestrial Reef Flat is a broad, flat, shallow to semi-exposed area of fringing reef found directly attached to land at one side, and subject to freshwater run-off, nutrients and sediment.
            |||,
          },
          {
            value: 21,
            color: '10bda6',
            description: |||
              Sheltered Reef Slope - Sheltered Reef Slope is any submerged, sloping area extending into Deep Water but protected from strong directional prevailing wind or current, either by land or by opposing reef structures.
            |||,
          },
          {
            value: 22,
            color: '288471',
            description: |||
              Reef Slope - Reef Slope is a submerged, sloping area extending seaward from the Reef Crest (or Flat) towards the shelf break. Windward facing, or any direction if no dominant prevailing wind or current exists.
            |||,
          },
          {
            value: 23,
            color: 'cd6812',
            description: |||
              Plateau - Plateau is any deeper submerged, hard-bottomed, horizontal to gently sloping seaward facing reef feature.
            |||,
          },
          {
            value: 24,
            color: 'befbff',
            description: |||
              Back Reef Slope - Back Reef Slope is a complex, interior, - often gently sloping - reef zone occurring behind the Reef Flat. Of variable depth (but deeper than Reef Flat and more sloped), it is sheltered, sediment-dominated and often punctuated by coral outcrops.
            |||,
          },
          {
            value: 25,
            color: 'ffba15',
            description: |||
              Patch Reef - Patch Reef is any small, detached to semi-detached lagoonal coral outcrop arising from sand-bottomed area.
            |||,
          },
        ],
      },
      {
        name: 'benthic',
        description: 'Classification of dominant benthic composition.',
        'gee:classes': [
          {
            color: '000000',
            description: 'Unmapped',
            value: 0,
          },
          {
            value: 11,
            color: 'ffffbe',
            description: 'Sand - Sand is any soft-bottom area dominated by fine unconsolidated sediments.',
          },
          {
            value: 12,
            color: 'e0d05e',
            description: 'Rubble - Rubble is any habitat featuring loose, rough fragments of broken reef material.',
          },
          {
            value: 13,
            color: 'b19c3a',
            description: 'Rock - Rock is any exposed area of hard bare substrate.',
          },
          {
            value: 14,
            color: '668438',
            description: 'Seagrass - Seagrass is any habitat where seagrass is the dominant biota.',
          },
          {
            value: 15,
            color: 'ff6161',
            description: 'Coral/Algae - Coral/Algae is any hard-bottom area supporting living coral and/or algae.',
          },
          {
            value: 18,
            color: '9bcc4f',
            description: |||
              Microalgal Mats - Microalgal Mats are any visible accumulations of microscopic algae in sandy sediments.
            |||,
          },
        ],
      },
      {
        name: 'reef_mask',
        description: |||
          Globally standardized reef mask using an amalgamation of a global reef
          classification and bathymetry products. Its intended use is as a mask, not a
          map, for standardizing global reporting on the global geomorphic/benthic maps.
        |||,
        'gee:classes': [
          {
            color: '000000',
            description: 'Not reef',
            value: 0,
          },
          {
            value: 1,
            color: 'ffffff',
            description: 'Reef',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Benthic Map',
        lookat: {
          lat: -17.00872,
          lon: -149.56194,
          zoom: 13,
        },
        image_visualization: {
          band_vis: {
            min: [
              11.0,
            ],
            max: [
              16.0,
            ],
            palette: [
              'ffffbe',
              'e0d05e',
              'b19c3a',
              '668438',
              'ff6161',
              '9bcc4f',
            ],
            bands: [
              'benthic',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5281/zenodo.3833242',
  'sci:citation': |||
    Allen Coral Atlas (2020). Imagery, maps and monitoring of the world's tropical coral reefs. Zenodo. [doi:10.5281/zenodo.3833242](https://doi.org/10.5281/zenodo.3833242)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
