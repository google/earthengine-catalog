local id = 'ESA/WorldCereal/2021/MODELS/v100';
local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'ESA WorldCereal 10 m v100',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The European Space Agency (ESA) WorldCereal 10 m 2021 product suite consists of global-scale annual and seasonal crop maps and their related confidence. They were generated as part of the [ESA-WorldCereal project](https://esa-worldcereal.org/). More information on the content of these products and the methodology used to generate them is described in [1].

    This collection contains up to 106 agro-ecological zone (AEZ) [2] images for each product which were all processed with respect to their own regional seasonality and should be considered as independent products. These seasons are described in the list below and were developed in [3] as part of the project. Note that cereals as described by WorldCereal include wheat, barley, and rye, which belong to the *Triticeae* tribe.

    WorldCereal seasons description:

    - tc-annual: a one-year cycle being defined in an AEZ by the end of the last considered growing season
    - tc-wintercereals: the main cereals season defined in an AEZ
    - tc-springcereals: optional springcereals season, only defined in certain AEZ
    - tc-maize-main: the main maize season defined in an AEZ
    - tc-maize-second: optional second maize season, only defined in certain AEZ

    The available products in this collection are:

    - temporarycrops
    - maize
    - wintercereals
    - springcereals
    - irrigation

    Each product (image) has a binary classification (0 or 100) and a confidence (0-100) band. Note that AEZs for which no irrigation product is available were not processed because of the unavailability of thermal Landsat data.

    The collection should be filtered using one or more of the following image properties:

    - aez_id, holding the ID of the AEZ to which the image belongs
    - product, describing the WorldCereal product name of the image
    - season, describing the season for which the image is valid.

    References:

    - [1] [WorldCereal methodology and products paper](https://doi.org/10.5194/essd-2023-184)
    - [2] Need to reference the AEZ FeatureCollection here.
    - [3] [WorldCereal global seasonality paper](https://doi.org/10.1080/15481603.2022.2079273)
  |||,
  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference)],
  keywords: ['agriculture', 'copernicus', 'crop', 'esa', 'global', 'landcover', 'landsat', 'sentinel1_derived', 'sentinel2_derived'],
  providers: [
    ee.producer_provider(
      'ESA WorldCereal Consortium',
      'https://esa-worldcereal.org/en'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2021-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'aez_id',
        description: 'ID of the agro-ecological zone (AEZ) to which the product belongs.',
        type: ee_const.var_type.int
      },
      {
        name: 'product',
        description: 'WorldCereal product name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'season',
        description: 'Season for which the product is valid.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [10],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Classification: 0 or 100'
      },
      {
        name: 'confidence',
        description: 'Confidence, 0 to 100'
      },
    ],
    classification: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
    confidence: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
    'gee:visualizations': [{
      display_name: 'Classification confidence',
      lookat: {lon: 5.02666, lat: 50.63096, zoom: 10},
      image_visualization: {
        band_vis: {
          min: [0],
          max: [100],
          palette: [
            'be0000','fff816','069711'
          ],
          bands: ['confidence'],
        },
      },
    }],
  },
  'sci:doi': '10.5194/essd-2023-184',
  'sci:citation': |||
    Van Tricht, K., Degerickx, J., Gilliams, S., Zanaga, D., Battude, M., Grosu, A., Brombacher, J., Lesiv, M., Bayas, J. C. L., Karanam, S., Fritz, S., Becker-Reshef, I., Franch, B., Mollà-Bononad, B., Boogaard, H., Pratihast, A. K., and Szantoi, Z.: WorldCereal: a dynamic open-source system for global-scale, seasonal, and reproducible crop and irrigation mapping, Earth Syst. Sci. Data Discuss. [preprint], [doi:10.5194/essd-2023-184](https://doi.org/10.5194/essd-2023-184), in review, 2023.,
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
