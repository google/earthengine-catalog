local id = 'ESA/CCI/FireCCI/5_1';
local subdir = 'ESA';

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
  title: 'FireCCI51: MODIS Fire_cci Burned Area Pixel Product, Version 5.1',
  version: '5.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Fire_cci Burned Area pixel product version 5.1 (FireCCI51)
    is a monthly global ~250m spatial resolution dataset
    containing information on burned area as well as ancillary data. It is based
    on surface reflectance in the Near Infrared (NIR) band from the MODIS
    instrument onboard the Terra satellite, as well as active fire information from
    the same sensor of the Terra and Aqua satellites.

    The burned area algorithm uses a two-phase hybrid approach. In a first step
    pixels with a high probability of being burned (called "seeds") are detected
    based on the active fires. In a second one, a contextual growing is applied to
    completely detect the fire patch. This growing phase is controlled by an
    adaptive thresholding, where thresholds are computed based on the specific
    characteristics of the area surrounding each seed. The variable used to guide
    the whole detection process is the NIR drop between pre- and post-fire images.

    The dataset includes for each pixel the estimated day of the first detection of
    the fire, the confidence level of that detection, and the land cover that has
    been burned (extracted from the ESA CCI Land Cover dataset v2.0.7). In addition,
    an observation flag is provided to identify the pixels that were not processed due
    to the lack of valid observations or because they belong to a non-burnable land
    cover.

    FireCCI51 was developed as part of the ESA Climate Change Initiative (CCI)
    Programme, and it is also part of the Copernicus Climate Change Service (C3S).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5285/58f00d8814064b79a0c49662ad3af537',
    },
  ],
  keywords: [
    'burn',
    'c3s',
    'cci',
    'climate_change',
    'copernicus',
    'esa',
    'fire',
    'firecci',
    'firecci51',
    'fragmentation',
    'gcos',
    'geophysical',
    'global',
    'human_modification',
    'landcover',
    'landscape_gradient',
    'modis',
    'monthly',
    'stressors',
  ],
  providers: [
    ee.producer_provider('European Space Agency (ESA) Climate Change Initiative (CCI) Programme, Fire ECV', 'https://climate.esa.int/en/projects/fire/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'BurnDate',
        description: 'Estimated day of the year of the first detection of the burn',
      },
      {
        name: 'ConfidenceLevel',
        description: |||
          Probability of detecting a pixel as burned, expressing the uncertainty of
          the detection for all pixels, even if they are classified as unburned.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'LandCover',
        description: |||
          Land cover category of the burned pixels, extracted from the CCI LandCover
          v2.0.7 product. See Defourny, P., Lamarche, C., Bontemps, S., De Maet, T.,
          Van Bogaert, E., Moreau, I., Brockmann, C., Boettcher, M., Kirches, G.,
          Wevers, J., Santoro, M., Ramoino, F., &amp; Arino, O.  (2017). Land Cover
          Climate Change Initiative - Product User Guide v2. Issue 2.0. [online]
          Available at: [https://maps.elie.ucl.ac.be/CCI/viewer/download/ESACCI-LC-Ph2-PUGv2_2.0.pdf](https://maps.elie.ucl.ac.be/CCI/viewer/download/ESACCI-LC-Ph2-PUGv2_2.0.pdf)
          accessed: July 2020. &copy; ESA Climate Change Initiative - Land Cover led by UCLouvain (2017).
        |||,
        'gee:classes': [
          {
            color: '000000',
            description: 'No Data',
            value: 0,
          },
          {
            color: 'ffff64',
            description: 'Cropland, rainfed',
            value: 10,
          },
          {
            value: 20,
            color: 'aaf0f0',
            description: 'Cropland, irrigated or post-flooding',
          },
          {
            value: 30,
            color: 'dcf064',
            description: 'Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%)',
          },
          {
            value: 40,
            color: 'c8c864',
            description: 'Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%)',
          },
          {
            value: 50,
            color: '006400',
            description: 'Tree cover, broadleaved, evergreen, closed to open (>15%)',
          },
          {
            value: 60,
            color: '00a000',
            description: 'Tree cover, broadleaved, deciduous, closed to open (>15%)',
          },
          {
            value: 70,
            color: '003c00',
            description: 'Tree cover, needleleaved, evergreen, closed to open (>15%)',
          },
          {
            value: 80,
            color: '285000',
            description: 'Tree cover, needleleaved, deciduous, closed to open (>15%)',
          },
          {
            value: 90,
            color: '788200',
            description: 'Tree cover, mixed leaf type (broadleaved and needleleaved)',
          },
          {
            value: 100,
            color: '8ca000',
            description: 'Mosaic tree and shrub (>50%) / herbaceous cover (<50%)',
          },
          {
            value: 110,
            color: 'be9600',
            description: 'Mosaic herbaceous cover (>50%) / tree and shrub (<50%)',
          },
          {
            value: 120,
            color: '966400',
            description: 'Shrubland',
          },
          {
            value: 130,
            color: 'ffb432',
            description: 'Grassland',
          },
          {
            value: 140,
            color: 'ffdcd2',
            description: 'Lichens and mosses',
          },
          {
            value: 150,
            color: 'ffebaf',
            description: 'Sparse vegetation (tree, shrub, herbaceous cover) (<15%)',
          },
          {
            value: 170,
            color: '009678',
            description: 'Tree cover, flooded, saline water',
          },
          {
            value: 180,
            color: '00dc82',
            description: 'Shrub or herbaceous cover, flooded, fresh/saline/brakish water',
          },
        ],
      },
      {
        name: 'ObservedFlag',
        description: |||
          Flags indicating why a pixel was not processed.

          * -2: the pixel is not burnable (water bodies, bare areas, urban areas,
          permanent snow and ice)
          * -1: the pixel has not been observed during the month (due to clouds,
          cloud shadows or sensor failure)
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Burn Date',
        lookat: {
          lon: 0,
          lat: 18,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              366.0,
            ],
            palette: [
              'ff0000',
              'fd4100',
              'fb8200',
              'f9c400',
              'f2ff00',
              'b6ff05',
              '7aff0a',
              '3eff0f',
              '02ff15',
              '00ff55',
              '00ff99',
              '00ffdd',
              '00ddff',
              '0098ff',
              '0052ff',
              '0210ff',
              '3a0dfb',
              '7209f6',
              'a905f1',
              'e102ed',
              'ff00cc',
              'ff0089',
              'ff0047',
              'ff0004',
            ],
            bands: [
              'BurnDate',
            ],
          },
        },
      },
    ],
    BurnDate: {
      minimum: 1.0,
      maximum: 366.0,
      'gee:estimated_range': false,
    },
    ConfidenceLevel: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5285/58f00d8814064b79a0c49662ad3af537',
  'sci:citation': |||
    Product: Chuvieco, E.; Pettinari, M.L.; Lizundia-Loiola, J.; Storm, T.;
    Padilla Parellada, M. (2018): ESA Fire Climate Change Initiative
    (Fire_cci): MODIS Fire_cci Burned Area Pixel product, version 5.1. Centre for
    Environmental Data Analysis, 01 November 2018.
    [https://doi.org/10.5285/58f00d8814064b79a0c49662ad3af537](https://doi.org/10.5285/58f00d8814064b79a0c49662ad3af537).
  |||,
  'sci:publications': [
    {
      citation: |||
        Related publication: Lizundia-Loiola, J., Ot&oacute;n, G., Ramo, R., Chuvieco, E.
        (2020): A spatio-temporal active-fire clustering approach for global burned
        area mapping at 250m from MODIS data. Remote Sensing of Environment, 236,
        111493. [https://doi.org/10.1016/j.rse.2019.111493](https://doi.org/10.1016/j.rse.2019.111493)
      |||,
      doi: '10.1016/j.rse.2019.111493',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is free and open to all users for any purpose, with the following
    terms and conditions:

    * Users of the data are required to acknowledge the ESA
    Climate Change Initiative and the Fire CCI project together with the individual
    data providers if the data are used in a presentation or publication. Please
    also cite any relevant dataset DOIs.

    * Intellectual property rights (IPR) in the CCI data lie with the researchers and
    organisations producing the data.

    * Liability: no warranty is given as to the quality or the accuracy of the CCI
    data or its suitability for any use. All implied conditions relating to the
    quality or suitability of the information, and all liabilities arising from the
    supply of the information (including any liability arising in negligence) are
    excluded to the fullest extent permitted by law.
  |||,
  'gee:user_uploaded': true,
}
