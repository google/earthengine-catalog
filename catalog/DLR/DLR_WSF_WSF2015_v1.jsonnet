local id = 'DLR/WSF/WSF2015/v1';
local subdir = 'DLR';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc0_1_0;

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
  title: 'World Settlement Footprint 2015',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The World Settlement Footprint (WSF) 2015 is a 10m resolution binary mask
    outlining the extent of human settlements globally derived by means of
    2014-2015 multitemporal Landsat-8 and Sentinel-1 imagery (of which ~217,000 and
    ~107,000 scenes have been processed, respectively).

    The temporal dynamics of human settlements over time are
    sensibly different than those of all other non-settlement information classes.
    Hence, given all the multitemporal images available over a region of interest
    in the selected time interval, key temporal statistics (i.e., temporal mean,
    minimum, maximum, etc.) are extracted for:

    * the original backscattering value
    in the case of radar data; and
    *  different spectral indices (e.g., vegetation
    index, built-up index, etc.) derived after performing cloud masking in the case
    of optical imagery.

    Next, different classification schemes based on Support
    Vector Machines (SVMs) are separately applied to the optical and radar temporal
    features, respectively, and, finally, the two outputs are properly combined
    together.

    To quantitatively assess the high accuracy and reliability of the
    layer, an extensive validation exercise has been carried out in collaboration
    with Google based on a huge amount of ground-truth samples (i.e., 900,000)
    labeled by crow-sourcing photo-interpretation. A statistically
    robust and transparent protocol has been defined following the state-of-the-art
    practices currently recommended in the literature.

    For all technical details, please refer to
    [the publication](https://www.nature.com/articles/s41597-020-00580-5)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://springernature.figshare.com/articles/dataset/World_Settlement_Footprint_WSF_2015/10048412',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1038/s41597-020-00580-5',
    },
  ],
  keywords: [
    'landcover',
    'landsat_derived',
    'sentinel1_derived',
    'settlement',
    'urban',
  ],
  providers: [
    ee.producer_provider('Deutsches Zentrum für Luft- und Raumfahrt (DLR)', 'https://www.dlr.de/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2015-01-01T00:00:00Z', '2016-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'settlement',
        description: 'A human settlement area',
        gsd: 10.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'A human settlement area',
        lookat: {
          lat: 23.7,
          lon: 90.45,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              255.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'settlement',
            ],
          },
        },
      },
    ],
    settlement: {
      minimum: 255.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.1038/s41597-020-00580-5',
  'sci:citation': |||
    Marconcini, M., Metz-Marconcini, A., Üreyen, S., Palacios-Lopez, D., Hanke, W., Bachofer, F.,
    Zeidler, J., Esch, T., Gorelick, N., Kakarla, A., Paganini, M., Strano, E. (2020).
    Outlining where humans live, the World Settlement Footprint 2015. Scientific Data, 7(1), 1-14.
    [doi:10.1038/s41597-020-00580-5](https://doi.org/10.1038/s41597-020-00580-5)
  |||,
  'gee:terms_of_use': 'CC0-1.0',
}
