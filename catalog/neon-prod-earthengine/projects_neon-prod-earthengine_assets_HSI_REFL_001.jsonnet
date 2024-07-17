local id = 'projects/neon-prod-earthengine/assets/HSI_REFL/001';
local subdir = 'neon-prod-earthengine';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'NEON Directional Surface Reflectance',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NEON AOP surface directional reflectance data is an orthorectified 
    hyperspectral VSWIR (visible to shortwave infrared) data product, containing 
    426 bands spanning wavelengths from ~380 nm to 2510 nm. Wavelengths 
    between 1340-1445 nm and 1790-1955 nm are set to -100; these are water vapor 
    absorption bands without valid values. The dataset also contains additional 
    QA and raster bands (B427 - B442). Data are collected by one of three NEON 
    Imaging Spectrometer units, AVIRIS-NG sensors built by NASA's Jet Propulsion 
    Lab (JPL). Major corrections include calibration, orthorectification, and 
    atmospheric correction. Reflectance is converted to a mosaic from flightlines 
    using the nadir-most pixels from the flight lines observed with the least 
    cloud cover. Spatial resolution is 1 m and spectral resolution is ~5 nm. 

    See [NEON Data Product
    DP3.30006.001](https://data.neonscience.org/data-products/DP3.30006.001) for
    more details.

    Documentation: [NEON DP3.30006.001 Spectrometer orthorectified surface directional reflectance - mosaic Quick Start
    Guide](https://data.neonscience.org/api/v0/documents/quick-start-guides/NEON.QSG.DP3.30006.001v1?inline=true&fallback=html)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'airborne',
    'canopy',
    'ecology',
    'forest',
    'hyperspectral',
    'neon',
    'reflectance'
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NEON', 'https://data.neonscience.org/data-products/DP3.30006.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-170, 16, -66, 73, '2013-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'AOP_VISIT_NUMBER',
        description: 'Unique visit number to the NEON site',
        type: ee_const.var_type.int,
      },
      {
        name: 'CITATION',
        description: 'Data citation. See ' +
        '[NEON Data Policies and Citation Guidelines]' +
        '(https://www.neonscience.org/data-samples/data-policies-citation)',
        type: ee_const.var_type.string,
      },
      {
        name: 'DOI',
        description: 'Digital Object Identifier. NEON data that have been released are assigned a DOI.',
        type: ee_const.var_type.string,
      },      
      {
        name: 'FLIGHT_YEAR',
        description: 'Year the data were collected',
        type: ee_const.var_type.int,
      },
      {
        name: 'NEON_DOMAIN',
        description:
          'NEON eco-climatic domain code, "D01" to "D20". See ' +
          '[NEON Field Sites and Domains]' +
          '(https://www.neonscience.org/field-sites/about-field-sites)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NEON_SITE',
        description: 'NEON four-digit site code. See ' +
        '[NEON Field Sites](https://www.neonscience.org/field-sites/)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NEON_DATA_PROD_ID',
        description: 'NEON data product identification code. Always set to: "DP3.30006.001"',
        type: ee_const.var_type.string,
      },
      {
        name: 'NEON_DATA_PROD_URL',
        description: 'NEON data product url. Always set to: ' +
        '[https://data.neonscience.org/data-products/DP3.30010.001]' +
        '(https://data.neonscience.org/data-products/DP3.30010.001)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROVISIONAL_RELEASED',
        description: 'Whether the data are Provisional or Released. See ' +
        '[https://www.neonscience.org/data-samples/data-management/data-revisions-releases]' +
        '(https://www.neonscience.org/data-samples/data-management/data-revisions-releases)',
        type: ee_const.var_type.string,
      },
      {
        name: 'RELEASE_YEAR',
        description: 'If data are released, the year of the NEON Release Tag.',
        type: ee_const.var_type.int,
      },
      {
        name: 'SCALE_FACTOR',
        description: 'Reflectance scale factor used',
        type: ee_const.var_type.double,
      },
      {
        name: 'SENSOR_ID',
        description: 'ID of NEON Imaging Spectrometer (NIS). The Global Airborne Observatory (GAO) sensor has also been used to collect the NEON D20 site: "NIS1", "NIS2", "NIS3", "GAO"',
        type: ee_const.var_type.double,
      },
    ],
    platform: [
      'NEON',
    ],
    instruments: [
      'NIS1, NIS2, NIS3, GAO',
    ],
    'eo:bands': [
     {
      name:'B001',
      center_wavelength_mean:382.2586975098,
      center_wavelength_stdev:0.9419999719,
      fwhm_mean:5.6785001755,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 001'
     },
     {
      name:'B002',
      center_wavelength_mean:387.267364502,
      center_wavelength_stdev:0.9419999719,
      fwhm_mean:5.6773562431,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 002'
     },
     {
      name:'B003',
      center_wavelength_mean:392.2760925293,
      center_wavelength_stdev:0.9409999847,
      fwhm_mean:5.6762280464,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 003'
     },
     {
      name:'B004',
      center_wavelength_mean:397.2847595215,
      center_wavelength_stdev:0.9409999847,
      fwhm_mean:5.6751112938,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 004'
     },
     {
      name:'B005',
      center_wavelength_mean:402.2934875488,
      center_wavelength_stdev:0.9399999976,
      fwhm_mean:5.6740121841,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 005'
     },
     {
      name:'B006',
      center_wavelength_mean:407.3021850586,
      center_wavelength_stdev:0.9399999976,
      fwhm_mean:5.6729240417,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 006'
     },
     {
      name:'B007',
      center_wavelength_mean:412.3108825684,
      center_wavelength_stdev:0.9390000105,
      fwhm_mean:5.6718511581,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 007'
     },
     {
      name:'B008',
      center_wavelength_mean:417.3194885254,
      center_wavelength_stdev:0.9390000105,
      fwhm_mean:5.6707940102,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 008'
     },
     {
      name:'B009',
      center_wavelength_mean:422.3282165527,
      center_wavelength_stdev:0.9380000234,
      fwhm_mean:5.6697487831,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 009'
     },
     {
      name:'B010',
      center_wavelength_mean:427.3369140625,
      center_wavelength_stdev:0.9380000234,
      fwhm_mean:5.6687188148,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 010'
     },
     {
      name:'B011',
      center_wavelength_mean:432.3455200195,
      center_wavelength_stdev:0.9380000234,
      fwhm_mean:5.6677031517,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 011'
     },
     {
      name:'B012',
      center_wavelength_mean:437.3542480469,
      center_wavelength_stdev:0.9369999766,
      fwhm_mean:5.6667032242,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 012'
     },
     {
      name:'B013',
      center_wavelength_mean:442.3629455566,
      center_wavelength_stdev:0.9369999766,
      fwhm_mean:5.6657156944,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 013'
     },
     {
      name:'B014',
      center_wavelength_mean:447.3716430664,
      center_wavelength_stdev:0.9359999895,
      fwhm_mean:5.6647410393,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 014'
     },
     {
      name:'B015',
      center_wavelength_mean:452.3803405762,
      center_wavelength_stdev:0.9359999895,
      fwhm_mean:5.6637825966,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 015'
     },
     {
      name:'B016',
      center_wavelength_mean:457.3890075684,
      center_wavelength_stdev:0.9350000024,
      fwhm_mean:5.6628370285,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 016'
     },
     {
      name:'B017',
      center_wavelength_mean:462.3977661133,
      center_wavelength_stdev:0.9350000024,
      fwhm_mean:5.6619086266,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 017'
     },
     {
      name:'B018',
      center_wavelength_mean:467.4064025879,
      center_wavelength_stdev:0.9340000153,
      fwhm_mean:5.6609940529,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 018'
     },
     {
      name:'B019',
      center_wavelength_mean:472.4150695801,
      center_wavelength_stdev:0.9340000153,
      fwhm_mean:5.660089016,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 019'
     },
     {
      name:'B020',
      center_wavelength_mean:477.4237670898,
      center_wavelength_stdev:0.9330000281,
      fwhm_mean:5.6592059135,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 020'
     },
     {
      name:'B021',
      center_wavelength_mean:482.4324645996,
      center_wavelength_stdev:0.9330000281,
      fwhm_mean:5.6583304405,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 021'
     },
     {
      name:'B022',
      center_wavelength_mean:487.4411621094,
      center_wavelength_stdev:0.9319999814,
      fwhm_mean:5.6574721336,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 022'
     },
     {
      name:'B023',
      center_wavelength_mean:492.449798584,
      center_wavelength_stdev:0.9319999814,
      fwhm_mean:5.656627655,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 023'
     },
     {
      name:'B024',
      center_wavelength_mean:497.4584960938,
      center_wavelength_stdev:0.9319999814,
      fwhm_mean:5.655798912,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 024'
     },
     {
      name:'B025',
      center_wavelength_mean:502.4672241211,
      center_wavelength_stdev:0.9309999943,
      fwhm_mean:5.6549835205,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 025'
     },
     {
      name:'B026',
      center_wavelength_mean:507.4759216309,
      center_wavelength_stdev:0.9309999943,
      fwhm_mean:5.6541819572,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 026'
     },
     {
      name:'B027',
      center_wavelength_mean:512.4845581055,
      center_wavelength_stdev:0.9300000072,
      fwhm_mean:5.6533927917,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 027'
     },
     {
      name:'B028',
      center_wavelength_mean:517.4932250977,
      center_wavelength_stdev:0.9300000072,
      fwhm_mean:5.6526222229,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 028'
     },
     {
      name:'B029',
      center_wavelength_mean:522.501953125,
      center_wavelength_stdev:0.92900002,
      fwhm_mean:5.6518630981,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 029'
     },
     {
      name:'B030',
      center_wavelength_mean:527.5106201172,
      center_wavelength_stdev:0.92900002,
      fwhm_mean:5.6511216164,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 030'
     },
     {
      name:'B031',
      center_wavelength_mean:532.5193481445,
      center_wavelength_stdev:0.9279999733,
      fwhm_mean:5.6503911018,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 031'
     },
     {
      name:'B032',
      center_wavelength_mean:537.5279541016,
      center_wavelength_stdev:0.9279999733,
      fwhm_mean:5.6496763229,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 032'
     },
     {
      name:'B033',
      center_wavelength_mean:542.5366821289,
      center_wavelength_stdev:0.9269999862,
      fwhm_mean:5.6489758492,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 033'
     },
     {
      name:'B034',
      center_wavelength_mean:547.5453491211,
      center_wavelength_stdev:0.9269999862,
      fwhm_mean:5.6482892036,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 034'
     },
     {
      name:'B035',
      center_wavelength_mean:552.5541381836,
      center_wavelength_stdev:0.9269999862,
      fwhm_mean:5.6476149559,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 035'
     },
     {
      name:'B036',
      center_wavelength_mean:557.5627441406,
      center_wavelength_stdev:0.925999999,
      fwhm_mean:5.6469583511,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 036'
     },
     {
      name:'B037',
      center_wavelength_mean:562.571472168,
      center_wavelength_stdev:0.925999999,
      fwhm_mean:5.6463165283,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 037'
     },
     {
      name:'B038',
      center_wavelength_mean:567.5801391602,
      center_wavelength_stdev:0.9250000119,
      fwhm_mean:5.6456871033,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 038'
     },
     {
      name:'B039',
      center_wavelength_mean:572.5888061523,
      center_wavelength_stdev:0.9250000119,
      fwhm_mean:5.645072937,
      fwhm_stdev:0.0979999974,
      description:'VNIR Band 039'
     },
     {
      name:'B040',
      center_wavelength_mean:577.5974731445,
      center_wavelength_stdev:0.9240000248,
      fwhm_mean:5.6444735527,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 040'
     },
     {
      name:'B041',
      center_wavelength_mean:582.606262207,
      center_wavelength_stdev:0.9240000248,
      fwhm_mean:5.643887043,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 041'
     },
     {
      name:'B042',
      center_wavelength_mean:587.6148681641,
      center_wavelength_stdev:0.9229999781,
      fwhm_mean:5.6433148384,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 042'
     },
     {
      name:'B043',
      center_wavelength_mean:592.6235351562,
      center_wavelength_stdev:0.9229999781,
      fwhm_mean:5.6427588463,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 043'
     },
     {
      name:'B044',
      center_wavelength_mean:597.6322631836,
      center_wavelength_stdev:0.9229999781,
      fwhm_mean:5.6422181129,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 044'
     },
     {
      name:'B045',
      center_wavelength_mean:602.6409301758,
      center_wavelength_stdev:0.9219999909,
      fwhm_mean:5.6416897774,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 045'
     },
     {
      name:'B046',
      center_wavelength_mean:607.649597168,
      center_wavelength_stdev:0.9219999909,
      fwhm_mean:5.6411771774,
      fwhm_stdev:0.0989999995,
      description:'VNIR Band 046'
     },
     {
      name:'B047',
      center_wavelength_mean:612.6583251953,
      center_wavelength_stdev:0.9210000038,
      fwhm_mean:5.6406769753,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 047'
     },
     {
      name:'B048',
      center_wavelength_mean:617.6669311523,
      center_wavelength_stdev:0.9210000038,
      fwhm_mean:5.6401929855,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 048'
     },
     {
      name:'B049',
      center_wavelength_mean:622.6757202148,
      center_wavelength_stdev:0.9200000167,
      fwhm_mean:5.6397237778,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 049'
     },
     {
      name:'B050',
      center_wavelength_mean:627.684387207,
      center_wavelength_stdev:0.9200000167,
      fwhm_mean:5.6392683983,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 050'
     },
     {
      name:'B051',
      center_wavelength_mean:632.6930541992,
      center_wavelength_stdev:0.9190000296,
      fwhm_mean:5.6388268471,
      fwhm_stdev:0.1000000015,
      description:'VNIR Band 051'
     },
     {
      name:'B052',
      center_wavelength_mean:637.7017211914,
      center_wavelength_stdev:0.9190000296,
      fwhm_mean:5.6384005547,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 052'
     },
     {
      name:'B053',
      center_wavelength_mean:642.7104492188,
      center_wavelength_stdev:0.9190000296,
      fwhm_mean:5.6379880905,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 053'
     },
     {
      name:'B054',
      center_wavelength_mean:647.7191162109,
      center_wavelength_stdev:0.9179999828,
      fwhm_mean:5.6375880241,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 054'
     },
     {
      name:'B055',
      center_wavelength_mean:652.7278442383,
      center_wavelength_stdev:0.9179999828,
      fwhm_mean:5.6372056007,
      fwhm_stdev:0.1010000035,
      description:'VNIR Band 055'
     },
     {
      name:'B056',
      center_wavelength_mean:657.7365112305,
      center_wavelength_stdev:0.9169999957,
      fwhm_mean:5.6368379593,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 056'
     },
     {
      name:'B057',
      center_wavelength_mean:662.7451782227,
      center_wavelength_stdev:0.9169999957,
      fwhm_mean:5.6364827156,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 057'
     },
     {
      name:'B058',
      center_wavelength_mean:667.7538452148,
      center_wavelength_stdev:0.9160000086,
      fwhm_mean:5.6361422539,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 058'
     },
     {
      name:'B059',
      center_wavelength_mean:672.7625732422,
      center_wavelength_stdev:0.9160000086,
      fwhm_mean:5.6358156204,
      fwhm_stdev:0.1019999981,
      description:'VNIR Band 059'
     },
     {
      name:'B060',
      center_wavelength_mean:677.7711791992,
      center_wavelength_stdev:0.9150000215,
      fwhm_mean:5.6355056763,
      fwhm_stdev:0.1030000001,
      description:'VNIR Band 060'
     },
     {
      name:'B061',
      center_wavelength_mean:682.7799682617,
      center_wavelength_stdev:0.9150000215,
      fwhm_mean:5.6352105141,
      fwhm_stdev:0.1030000001,
      description:'VNIR Band 061'
     },
     {
      name:'B062',
      center_wavelength_mean:687.7886352539,
      center_wavelength_stdev:0.9150000215,
      fwhm_mean:5.6349258423,
      fwhm_stdev:0.1030000001,
      description:'VNIR Band 062'
     },
     {
      name:'B063',
      center_wavelength_mean:692.7973632812,
      center_wavelength_stdev:0.9139999747,
      fwhm_mean:5.6346588135,
      fwhm_stdev:0.1030000001,
      description:'VNIR Band 063'
     },
     {
      name:'B064',
      center_wavelength_mean:697.8060302734,
      center_wavelength_stdev:0.9139999747,
      fwhm_mean:5.6344065666,
      fwhm_stdev:0.1040000021,
      description:'VNIR Band 064'
     },
     {
      name:'B065',
      center_wavelength_mean:702.8147583008,
      center_wavelength_stdev:0.9129999876,
      fwhm_mean:5.6341662407,
      fwhm_stdev:0.1040000021,
      description:'VNIR Band 065'
     },
     {
      name:'B066',
      center_wavelength_mean:707.8233032227,
      center_wavelength_stdev:0.9129999876,
      fwhm_mean:5.6339411736,
      fwhm_stdev:0.1040000021,
      description:'VNIR Band 066'
     },
     {
      name:'B067',
      center_wavelength_mean:712.83203125,
      center_wavelength_stdev:0.9120000005,
      fwhm_mean:5.6337304115,
      fwhm_stdev:0.1049999967,
      description:'VNIR Band 067'
     },
     {
      name:'B068',
      center_wavelength_mean:717.8407592773,
      center_wavelength_stdev:0.9120000005,
      fwhm_mean:5.633535862,
      fwhm_stdev:0.1049999967,
      description:'VNIR Band 068'
     },
     {
      name:'B069',
      center_wavelength_mean:722.8494873047,
      center_wavelength_stdev:0.9120000005,
      fwhm_mean:5.6333551407,
      fwhm_stdev:0.1049999967,
      description:'VNIR Band 069'
     },
     {
      name:'B070',
      center_wavelength_mean:727.8580322266,
      center_wavelength_stdev:0.9110000134,
      fwhm_mean:5.6331887245,
      fwhm_stdev:0.1059999987,
      description:'VNIR Band 070'
     },
     {
      name:'B071',
      center_wavelength_mean:732.8667602539,
      center_wavelength_stdev:0.9110000134,
      fwhm_mean:5.633035183,
      fwhm_stdev:0.1059999987,
      description:'VNIR Band 071'
     },
     {
      name:'B072',
      center_wavelength_mean:737.8754272461,
      center_wavelength_stdev:0.9100000262,
      fwhm_mean:5.6328978539,
      fwhm_stdev:0.1059999987,
      description:'VNIR Band 072'
     },
     {
      name:'B073',
      center_wavelength_mean:742.8841552734,
      center_wavelength_stdev:0.9100000262,
      fwhm_mean:5.6327729225,
      fwhm_stdev:0.1070000008,
      description:'VNIR Band 073'
     },
     {
      name:'B074',
      center_wavelength_mean:747.8927612305,
      center_wavelength_stdev:0.9089999795,
      fwhm_mean:5.6326642036,
      fwhm_stdev:0.1070000008,
      description:'VNIR Band 074'
     },
     {
      name:'B075',
      center_wavelength_mean:752.901550293,
      center_wavelength_stdev:0.9089999795,
      fwhm_mean:5.6325697899,
      fwhm_stdev:0.1070000008,
      description:'VNIR Band 075'
     },
     {
      name:'B076',
      center_wavelength_mean:757.9102172852,
      center_wavelength_stdev:0.9089999795,
      fwhm_mean:5.6324896812,
      fwhm_stdev:0.1080000028,
      description:'VNIR Band 076'
     },
     {
      name:'B077',
      center_wavelength_mean:762.9188842773,
      center_wavelength_stdev:0.9079999924,
      fwhm_mean:5.6324238777,
      fwhm_stdev:0.1080000028,
      description:'VNIR Band 077'
     },
     {
      name:'B078',
      center_wavelength_mean:767.9276733398,
      center_wavelength_stdev:0.9079999924,
      fwhm_mean:5.6323714256,
      fwhm_stdev:0.1089999974,
      description:'VNIR Band 078'
     },
     {
      name:'B079',
      center_wavelength_mean:772.936340332,
      center_wavelength_stdev:0.9070000052,
      fwhm_mean:5.632335186,
      fwhm_stdev:0.1089999974,
      description:'VNIR Band 079'
     },
     {
      name:'B080',
      center_wavelength_mean:777.9450073242,
      center_wavelength_stdev:0.9070000052,
      fwhm_mean:5.632311821,
      fwhm_stdev:0.1089999974,
      description:'VNIR Band 080'
     },
     {
      name:'B081',
      center_wavelength_mean:782.9537353516,
      center_wavelength_stdev:0.9060000181,
      fwhm_mean:5.6323027611,
      fwhm_stdev:0.1099999994,
      description:'VNIR Band 081'
     },
     {
      name:'B082',
      center_wavelength_mean:787.9623413086,
      center_wavelength_stdev:0.9060000181,
      fwhm_mean:5.6323113441,
      fwhm_stdev:0.1099999994,
      description:'VNIR Band 082'
     },
     {
      name:'B083',
      center_wavelength_mean:792.9711303711,
      center_wavelength_stdev:0.9060000181,
      fwhm_mean:5.6323304176,
      fwhm_stdev:0.1099999994,
      description:'VNIR Band 083'
     },
     {
      name:'B084',
      center_wavelength_mean:797.9797973633,
      center_wavelength_stdev:0.9049999714,
      fwhm_mean:5.6323661804,
      fwhm_stdev:0.1110000014,
      description:'VNIR Band 084'
     },
     {
      name:'B085',
      center_wavelength_mean:802.9884033203,
      center_wavelength_stdev:0.9049999714,
      fwhm_mean:5.6324133873,
      fwhm_stdev:0.1110000014,
      description:'VNIR Band 085'
     },
     {
      name:'B086',
      center_wavelength_mean:807.9970092773,
      center_wavelength_stdev:0.9039999843,
      fwhm_mean:5.6324782372,
      fwhm_stdev:0.1120000035,
      description:'VNIR Band 086'
     },
     {
      name:'B087',
      center_wavelength_mean:813.0057373047,
      center_wavelength_stdev:0.9039999843,
      fwhm_mean:5.6325564384,
      fwhm_stdev:0.1120000035,
      description:'VNIR Band 087'
     },
     {
      name:'B088',
      center_wavelength_mean:818.0143432617,
      center_wavelength_stdev:0.9039999843,
      fwhm_mean:5.6326489449,
      fwhm_stdev:0.1120000035,
      description:'VNIR Band 088'
     },
     {
      name:'B089',
      center_wavelength_mean:823.0230712891,
      center_wavelength_stdev:0.9029999971,
      fwhm_mean:5.632753849,
      fwhm_stdev:0.112999998,
      description:'VNIR Band 089'
     },
     {
      name:'B090',
      center_wavelength_mean:828.0317382812,
      center_wavelength_stdev:0.9029999971,
      fwhm_mean:5.6328749657,
      fwhm_stdev:0.112999998,
      description:'VNIR Band 090'
     },
     {
      name:'B091',
      center_wavelength_mean:833.0404663086,
      center_wavelength_stdev:0.90200001,
      fwhm_mean:5.6330118179,
      fwhm_stdev:0.1140000001,
      description:'VNIR Band 091'
     },
     {
      name:'B092',
      center_wavelength_mean:838.0492553711,
      center_wavelength_stdev:0.90200001,
      fwhm_mean:5.6331605911,
      fwhm_stdev:0.1140000001,
      description:'VNIR Band 092'
     },
     {
      name:'B093',
      center_wavelength_mean:843.0579223633,
      center_wavelength_stdev:0.9010000229,
      fwhm_mean:5.6333260536,
      fwhm_stdev:0.1150000021,
      description:'VNIR Band 093'
     },
     {
      name:'B094',
      center_wavelength_mean:848.0665283203,
      center_wavelength_stdev:0.9010000229,
      fwhm_mean:5.633503437,
      fwhm_stdev:0.1150000021,
      description:'VNIR Band 094'
     },
     {
      name:'B095',
      center_wavelength_mean:853.0752563477,
      center_wavelength_stdev:0.9010000229,
      fwhm_mean:5.6336951256,
      fwhm_stdev:0.1150000021,
      description:'VNIR Band 095'
     },
     {
      name:'B096',
      center_wavelength_mean:858.083984375,
      center_wavelength_stdev:0.8999999762,
      fwhm_mean:5.6339030266,
      fwhm_stdev:0.1159999967,
      description:'VNIR Band 096'
     },
     {
      name:'B097',
      center_wavelength_mean:863.0926513672,
      center_wavelength_stdev:0.8999999762,
      fwhm_mean:5.634124279,
      fwhm_stdev:0.1159999967,
      description:'VNIR Band 097'
     },
     {
      name:'B098',
      center_wavelength_mean:868.1013793945,
      center_wavelength_stdev:0.898999989,
      fwhm_mean:5.6343622208,
      fwhm_stdev:0.1169999987,
      description:'VNIR Band 098'
     },
     {
      name:'B099',
      center_wavelength_mean:873.1099853516,
      center_wavelength_stdev:0.898999989,
      fwhm_mean:5.6346125603,
      fwhm_stdev:0.1169999987,
      description:'VNIR Band 099'
     },
     {
      name:'B100',
      center_wavelength_mean:878.1187133789,
      center_wavelength_stdev:0.898999989,
      fwhm_mean:5.6348767281,
      fwhm_stdev:0.1180000007,
      description:'VNIR Band 100'
     },
     {
      name:'B101',
      center_wavelength_mean:883.1273803711,
      center_wavelength_stdev:0.8980000019,
      fwhm_mean:5.6351542473,
      fwhm_stdev:0.1180000007,
      description:'VNIR Band 101'
     },
     {
      name:'B102',
      center_wavelength_mean:888.1361083984,
      center_wavelength_stdev:0.8980000019,
      fwhm_mean:5.635447979,
      fwhm_stdev:0.1180000007,
      description:'VNIR Band 102'
     },
     {
      name:'B103',
      center_wavelength_mean:893.1446533203,
      center_wavelength_stdev:0.8970000148,
      fwhm_mean:5.6357560158,
      fwhm_stdev:0.1190000027,
      description:'VNIR Band 103'
     },
     {
      name:'B104',
      center_wavelength_mean:898.1533813477,
      center_wavelength_stdev:0.8970000148,
      fwhm_mean:5.6360769272,
      fwhm_stdev:0.1190000027,
      description:'VNIR Band 104'
     },
     {
      name:'B105',
      center_wavelength_mean:903.162109375,
      center_wavelength_stdev:0.8970000148,
      fwhm_mean:5.6364126205,
      fwhm_stdev:0.1199999973,
      description:'VNIR Band 105'
     },
     {
      name:'B106',
      center_wavelength_mean:908.1707763672,
      center_wavelength_stdev:0.8960000277,
      fwhm_mean:5.6367621422,
      fwhm_stdev:0.1199999973,
      description:'VNIR Band 106'
     },
     {
      name:'B107',
      center_wavelength_mean:913.1795043945,
      center_wavelength_stdev:0.8960000277,
      fwhm_mean:5.6371278763,
      fwhm_stdev:0.1209999993,
      description:'VNIR Band 107'
     },
     {
      name:'B108',
      center_wavelength_mean:918.1881713867,
      center_wavelength_stdev:0.8949999809,
      fwhm_mean:5.6375041008,
      fwhm_stdev:0.1209999993,
      description:'VNIR Band 108'
     },
     {
      name:'B109',
      center_wavelength_mean:923.1968383789,
      center_wavelength_stdev:0.8949999809,
      fwhm_mean:5.6378984451,
      fwhm_stdev:0.1220000014,
      description:'VNIR Band 109'
     },
     {
      name:'B110',
      center_wavelength_mean:928.2056274414,
      center_wavelength_stdev:0.8939999938,
      fwhm_mean:5.6383056641,
      fwhm_stdev:0.1220000014,
      description:'VNIR Band 110'
     },
     {
      name:'B111',
      center_wavelength_mean:933.2142944336,
      center_wavelength_stdev:0.8939999938,
      fwhm_mean:5.6387267113,
      fwhm_stdev:0.1230000034,
      description:'VNIR Band 111'
     },
     {
      name:'B112',
      center_wavelength_mean:938.2229614258,
      center_wavelength_stdev:0.8939999938,
      fwhm_mean:5.6391611099,
      fwhm_stdev:0.1230000034,
      description:'VNIR Band 112'
     },
     {
      name:'B113',
      center_wavelength_mean:943.231628418,
      center_wavelength_stdev:0.8930000067,
      fwhm_mean:5.6396112442,
      fwhm_stdev:0.123999998,
      description:'VNIR Band 113'
     },
     {
      name:'B114',
      center_wavelength_mean:948.2402954102,
      center_wavelength_stdev:0.8930000067,
      fwhm_mean:5.6400752068,
      fwhm_stdev:0.123999998,
      description:'VNIR Band 114'
     },
     {
      name:'B115',
      center_wavelength_mean:953.2490234375,
      center_wavelength_stdev:0.8920000196,
      fwhm_mean:5.6405539513,
      fwhm_stdev:0.125,
      description:'VNIR Band 115'
     },
     {
      name:'B116',
      center_wavelength_mean:958.2577514648,
      center_wavelength_stdev:0.8920000196,
      fwhm_mean:5.6410446167,
      fwhm_stdev:0.125,
      description:'VNIR Band 116'
     },
     {
      name:'B117',
      center_wavelength_mean:963.2662963867,
      center_wavelength_stdev:0.8920000196,
      fwhm_mean:5.6415519714,
      fwhm_stdev:0.126000002,
      description:'VNIR Band 117'
     },
     {
      name:'B118',
      center_wavelength_mean:968.2749633789,
      center_wavelength_stdev:0.8909999728,
      fwhm_mean:5.6420750618,
      fwhm_stdev:0.126000002,
      description:'VNIR Band 118'
     },
     {
      name:'B119',
      center_wavelength_mean:973.2837524414,
      center_wavelength_stdev:0.8909999728,
      fwhm_mean:5.6426086426,
      fwhm_stdev:0.1270000041,
      description:'VNIR Band 119'
     },
     {
      name:'B120',
      center_wavelength_mean:978.2924194336,
      center_wavelength_stdev:0.8899999857,
      fwhm_mean:5.6431584358,
      fwhm_stdev:0.1270000041,
      description:'VNIR Band 120'
     },
     {
      name:'B121',
      center_wavelength_mean:983.3009643555,
      center_wavelength_stdev:0.8899999857,
      fwhm_mean:5.6437211037,
      fwhm_stdev:0.1280000061,
      description:'VNIR Band 121'
     },
     {
      name:'B122',
      center_wavelength_mean:988.309753418,
      center_wavelength_stdev:0.8899999857,
      fwhm_mean:5.6442975998,
      fwhm_stdev:0.1280000061,
      description:'VNIR Band 122'
     },
     {
      name:'B123',
      center_wavelength_mean:993.318359375,
      center_wavelength_stdev:0.8889999986,
      fwhm_mean:5.6448903084,
      fwhm_stdev:0.1289999932,
      description:'VNIR Band 123'
     },
     {
      name:'B124',
      center_wavelength_mean:998.3272094727,
      center_wavelength_stdev:0.8889999986,
      fwhm_mean:5.6454954147,
      fwhm_stdev:0.1289999932,
      description:'VNIR Band 124'
     },
     {
      name:'B125',
      center_wavelength_mean:1003.3358764648,
      center_wavelength_stdev:0.8889999986,
      fwhm_mean:5.646115303,
      fwhm_stdev:0.1299999952,
      description:'VNIR Band 125'
     },
     {
      name:'B126',
      center_wavelength_mean:1008.3444213867,
      center_wavelength_stdev:0.8880000114,
      fwhm_mean:5.6467499733,
      fwhm_stdev:0.1299999952,
      description:'VNIR Band 126'
     },
     {
      name:'B127',
      center_wavelength_mean:1013.3532104492,
      center_wavelength_stdev:0.8880000114,
      fwhm_mean:5.6473975182,
      fwhm_stdev:0.1309999973,
      description:'VNIR Band 127'
     },
     {
      name:'B128',
      center_wavelength_mean:1018.3619384766,
      center_wavelength_stdev:0.8870000243,
      fwhm_mean:5.648059845,
      fwhm_stdev:0.1309999973,
      description:'VNIR Band 128'
     },
     {
      name:'B129',
      center_wavelength_mean:1023.3706054688,
      center_wavelength_stdev:0.8870000243,
      fwhm_mean:5.6487350464,
      fwhm_stdev:0.1319999993,
      description:'VNIR Band 129'
     },
     {
      name:'B130',
      center_wavelength_mean:1028.3792724609,
      center_wavelength_stdev:0.8870000243,
      fwhm_mean:5.6494255066,
      fwhm_stdev:0.1319999993,
      description:'VNIR Band 130'
     },
     {
      name:'B131',
      center_wavelength_mean:1033.3879394531,
      center_wavelength_stdev:0.8859999776,
      fwhm_mean:5.6501302719,
      fwhm_stdev:0.1330000013,
      description:'VNIR Band 131'
     },
     {
      name:'B132',
      center_wavelength_mean:1038.3966064453,
      center_wavelength_stdev:0.8859999776,
      fwhm_mean:5.6508483887,
      fwhm_stdev:0.1330000013,
      description:'VNIR Band 132'
     },
     {
      name:'B133',
      center_wavelength_mean:1043.4053955078,
      center_wavelength_stdev:0.8849999905,
      fwhm_mean:5.6515803337,
      fwhm_stdev:0.1340000033,
      description:'VNIR Band 133'
     },
     {
      name:'B134',
      center_wavelength_mean:1048.4139404297,
      center_wavelength_stdev:0.8849999905,
      fwhm_mean:5.6523270607,
      fwhm_stdev:0.1340000033,
      description:'VNIR Band 134'
     },
     {
      name:'B135',
      center_wavelength_mean:1053.4227294922,
      center_wavelength_stdev:0.8849999905,
      fwhm_mean:5.6530871391,
      fwhm_stdev:0.1350000054,
      description:'VNIR Band 135'
     },
     {
      name:'B136',
      center_wavelength_mean:1058.4313964844,
      center_wavelength_stdev:0.8840000033,
      fwhm_mean:5.6538648605,
      fwhm_stdev:0.1350000054,
      description:'VNIR Band 136'
     },
     {
      name:'B137',
      center_wavelength_mean:1063.4400634766,
      center_wavelength_stdev:0.8840000033,
      fwhm_mean:5.6546521187,
      fwhm_stdev:0.1360000074,
      description:'VNIR Band 137'
     },
     {
      name:'B138',
      center_wavelength_mean:1068.4487304688,
      center_wavelength_stdev:0.8830000162,
      fwhm_mean:5.6554541588,
      fwhm_stdev:0.1360000074,
      description:'VNIR Band 138'
     },
     {
      name:'B139',
      center_wavelength_mean:1073.4573974609,
      center_wavelength_stdev:0.8830000162,
      fwhm_mean:5.6562695503,
      fwhm_stdev:0.1369999945,
      description:'VNIR Band 139'
     },
     {
      name:'B140',
      center_wavelength_mean:1078.4660644531,
      center_wavelength_stdev:0.8830000162,
      fwhm_mean:5.657099247,
      fwhm_stdev:0.1379999965,
      description:'VNIR Band 140'
     },
     {
      name:'B141',
      center_wavelength_mean:1083.4748535156,
      center_wavelength_stdev:0.8820000291,
      fwhm_mean:5.6579437256,
      fwhm_stdev:0.1379999965,
      description:'VNIR Band 141'
     },
     {
      name:'B142',
      center_wavelength_mean:1088.4836425781,
      center_wavelength_stdev:0.8820000291,
      fwhm_mean:5.6588025093,
      fwhm_stdev:0.1389999986,
      description:'VNIR Band 142'
     },
     {
      name:'B143',
      center_wavelength_mean:1093.4921875,
      center_wavelength_stdev:0.8820000291,
      fwhm_mean:5.659676075,
      fwhm_stdev:0.1389999986,
      description:'VNIR Band 143'
     },
     {
      name:'B144',
      center_wavelength_mean:1098.5008544922,
      center_wavelength_stdev:0.8809999824,
      fwhm_mean:5.6605639458,
      fwhm_stdev:0.1400000006,
      description:'VNIR Band 144'
     },
     {
      name:'B145',
      center_wavelength_mean:1103.5095214844,
      center_wavelength_stdev:0.8809999824,
      fwhm_mean:5.6614632607,
      fwhm_stdev:0.1400000006,
      description:'VNIR Band 145'
     },
     {
      name:'B146',
      center_wavelength_mean:1108.5181884766,
      center_wavelength_stdev:0.8799999952,
      fwhm_mean:5.6623773575,
      fwhm_stdev:0.1410000026,
      description:'VNIR Band 146'
     },
     {
      name:'B147',
      center_wavelength_mean:1113.5269775391,
      center_wavelength_stdev:0.8799999952,
      fwhm_mean:5.6633048058,
      fwhm_stdev:0.1410000026,
      description:'VNIR Band 147'
     },
     {
      name:'B148',
      center_wavelength_mean:1118.5356445312,
      center_wavelength_stdev:0.8799999952,
      fwhm_mean:5.6642465591,
      fwhm_stdev:0.1420000046,
      description:'VNIR Band 148'
     },
     {
      name:'B149',
      center_wavelength_mean:1123.5443115234,
      center_wavelength_stdev:0.8790000081,
      fwhm_mean:5.6652035713,
      fwhm_stdev:0.1430000067,
      description:'VNIR Band 149'
     },
     {
      name:'B150',
      center_wavelength_mean:1128.5529785156,
      center_wavelength_stdev:0.8790000081,
      fwhm_mean:5.6661725044,
      fwhm_stdev:0.1430000067,
      description:'VNIR Band 150'
     },
     {
      name:'B151',
      center_wavelength_mean:1133.5616455078,
      center_wavelength_stdev:0.8790000081,
      fwhm_mean:5.6671571732,
      fwhm_stdev:0.1439999938,
      description:'VNIR Band 151'
     },
     {
      name:'B152',
      center_wavelength_mean:1138.5704345703,
      center_wavelength_stdev:0.878000021,
      fwhm_mean:5.6681547165,
      fwhm_stdev:0.1439999938,
      description:'VNIR Band 152'
     },
     {
      name:'B153',
      center_wavelength_mean:1143.5791015625,
      center_wavelength_stdev:0.878000021,
      fwhm_mean:5.6691665649,
      fwhm_stdev:0.1449999958,
      description:'VNIR Band 153'
     },
     {
      name:'B154',
      center_wavelength_mean:1148.5877685547,
      center_wavelength_stdev:0.8769999743,
      fwhm_mean:5.6701898575,
      fwhm_stdev:0.1449999958,
      description:'VNIR Band 154'
     },
     {
      name:'B155',
      center_wavelength_mean:1153.5964355469,
      center_wavelength_stdev:0.8769999743,
      fwhm_mean:5.6712293625,
      fwhm_stdev:0.1459999979,
      description:'VNIR Band 155'
     },
     {
      name:'B156',
      center_wavelength_mean:1158.6051025391,
      center_wavelength_stdev:0.8769999743,
      fwhm_mean:5.6722803116,
      fwhm_stdev:0.1469999999,
      description:'VNIR Band 156'
     },
     {
      name:'B157',
      center_wavelength_mean:1163.6137695312,
      center_wavelength_stdev:0.8759999871,
      fwhm_mean:5.6733489037,
      fwhm_stdev:0.1469999999,
      description:'VNIR Band 157'
     },
     {
      name:'B158',
      center_wavelength_mean:1168.6224365234,
      center_wavelength_stdev:0.8759999871,
      fwhm_mean:5.674428463,
      fwhm_stdev:0.1480000019,
      description:'VNIR Band 158'
     },
     {
      name:'B159',
      center_wavelength_mean:1173.6312255859,
      center_wavelength_stdev:0.8759999871,
      fwhm_mean:5.6755232811,
      fwhm_stdev:0.1480000019,
      description:'VNIR Band 159'
     },
     {
      name:'B160',
      center_wavelength_mean:1178.6397705078,
      center_wavelength_stdev:0.875,
      fwhm_mean:5.6766324043,
      fwhm_stdev:0.1490000039,
      description:'VNIR Band 160'
     },
     {
      name:'B161',
      center_wavelength_mean:1183.6484375,
      center_wavelength_stdev:0.875,
      fwhm_mean:5.6777534485,
      fwhm_stdev:0.1490000039,
      description:'VNIR Band 161'
     },
     {
      name:'B162',
      center_wavelength_mean:1188.6571044922,
      center_wavelength_stdev:0.8740000129,
      fwhm_mean:5.6788892746,
      fwhm_stdev:0.150000006,
      description:'VNIR Band 162'
     },
     {
      name:'B163',
      center_wavelength_mean:1193.6657714844,
      center_wavelength_stdev:0.8740000129,
      fwhm_mean:5.6800374985,
      fwhm_stdev:0.1509999931,
      description:'VNIR Band 163'
     },
     {
      name:'B164',
      center_wavelength_mean:1198.6745605469,
      center_wavelength_stdev:0.8740000129,
      fwhm_mean:5.6812005043,
      fwhm_stdev:0.1509999931,
      description:'VNIR Band 164'
     },
     {
      name:'B165',
      center_wavelength_mean:1203.6833496094,
      center_wavelength_stdev:0.8730000257,
      fwhm_mean:5.6823773384,
      fwhm_stdev:0.1519999951,
      description:'VNIR Band 165'
     },
     {
      name:'B166',
      center_wavelength_mean:1208.6920166016,
      center_wavelength_stdev:0.8730000257,
      fwhm_mean:5.6835680008,
      fwhm_stdev:0.1519999951,
      description:'VNIR Band 166'
     },
     {
      name:'B167',
      center_wavelength_mean:1213.7005615234,
      center_wavelength_stdev:0.8730000257,
      fwhm_mean:5.6847720146,
      fwhm_stdev:0.1529999971,
      description:'VNIR Band 167'
     },
     {
      name:'B168',
      center_wavelength_mean:1218.7092285156,
      center_wavelength_stdev:0.871999979,
      fwhm_mean:5.685988903,
      fwhm_stdev:0.1539999992,
      description:'VNIR Band 168'
     },
     {
      name:'B169',
      center_wavelength_mean:1223.7180175781,
      center_wavelength_stdev:0.871999979,
      fwhm_mean:5.6872215271,
      fwhm_stdev:0.1539999992,
      description:'VNIR Band 169'
     },
     {
      name:'B170',
      center_wavelength_mean:1228.7266845703,
      center_wavelength_stdev:0.871999979,
      fwhm_mean:5.6884660721,
      fwhm_stdev:0.1550000012,
      description:'VNIR Band 170'
     },
     {
      name:'B171',
      center_wavelength_mean:1233.7354736328,
      center_wavelength_stdev:0.8709999919,
      fwhm_mean:5.689725399,
      fwhm_stdev:0.1550000012,
      description:'VNIR Band 171'
     },
     {
      name:'B172',
      center_wavelength_mean:1238.744140625,
      center_wavelength_stdev:0.8709999919,
      fwhm_mean:5.6909990311,
      fwhm_stdev:0.1560000032,
      description:'VNIR Band 172'
     },
     {
      name:'B173',
      center_wavelength_mean:1243.7528076172,
      center_wavelength_stdev:0.8700000048,
      fwhm_mean:5.692284584,
      fwhm_stdev:0.1570000052,
      description:'VNIR Band 173'
     },
     {
      name:'B174',
      center_wavelength_mean:1248.7615966797,
      center_wavelength_stdev:0.8700000048,
      fwhm_mean:5.6935839653,
      fwhm_stdev:0.1570000052,
      description:'VNIR Band 174'
     },
     {
      name:'B175',
      center_wavelength_mean:1253.7702636719,
      center_wavelength_stdev:0.8700000048,
      fwhm_mean:5.6948962212,
      fwhm_stdev:0.1580000073,
      description:'VNIR Band 175'
     },
     {
      name:'B176',
      center_wavelength_mean:1258.7789306641,
      center_wavelength_stdev:0.8690000176,
      fwhm_mean:5.696223259,
      fwhm_stdev:0.1580000073,
      description:'VNIR Band 176'
     },
     {
      name:'B177',
      center_wavelength_mean:1263.7874755859,
      center_wavelength_stdev:0.8690000176,
      fwhm_mean:5.6975641251,
      fwhm_stdev:0.1589999944,
      description:'VNIR Band 177'
     },
     {
      name:'B178',
      center_wavelength_mean:1268.7962646484,
      center_wavelength_stdev:0.8690000176,
      fwhm_mean:5.6989178658,
      fwhm_stdev:0.1599999964,
      description:'VNIR Band 178'
     },
     {
      name:'B179',
      center_wavelength_mean:1273.8049316406,
      center_wavelength_stdev:0.8679999709,
      fwhm_mean:5.7002868652,
      fwhm_stdev:0.1599999964,
      description:'VNIR Band 179'
     },
     {
      name:'B180',
      center_wavelength_mean:1278.8135986328,
      center_wavelength_stdev:0.8679999709,
      fwhm_mean:5.7016654015,
      fwhm_stdev:0.1609999985,
      description:'VNIR Band 180'
     },
     {
      name:'B181',
      center_wavelength_mean:1283.822265625,
      center_wavelength_stdev:0.8679999709,
      fwhm_mean:5.7030615807,
      fwhm_stdev:0.1620000005,
      description:'VNIR Band 181'
     },
     {
      name:'B182',
      center_wavelength_mean:1288.8310546875,
      center_wavelength_stdev:0.8669999838,
      fwhm_mean:5.7044701576,
      fwhm_stdev:0.1620000005,
      description:'VNIR Band 182'
     },
     {
      name:'B183',
      center_wavelength_mean:1293.8397216797,
      center_wavelength_stdev:0.8669999838,
      fwhm_mean:5.7058901787,
      fwhm_stdev:0.1630000025,
      description:'VNIR Band 183'
     },
     {
      name:'B184',
      center_wavelength_mean:1298.8485107422,
      center_wavelength_stdev:0.8669999838,
      fwhm_mean:5.7073259354,
      fwhm_stdev:0.1630000025,
      description:'VNIR Band 184'
     },
     {
      name:'B185',
      center_wavelength_mean:1303.8570556641,
      center_wavelength_stdev:0.8659999967,
      fwhm_mean:5.7087745667,
      fwhm_stdev:0.1640000045,
      description:'VNIR Band 185'
     },
     {
      name:'B186',
      center_wavelength_mean:1308.8656005859,
      center_wavelength_stdev:0.8659999967,
      fwhm_mean:5.7102365494,
      fwhm_stdev:0.1650000066,
      description:'VNIR Band 186'
     },
     {
      name:'B187',
      center_wavelength_mean:1313.8742675781,
      center_wavelength_stdev:0.8650000095,
      fwhm_mean:5.7117118835,
      fwhm_stdev:0.1650000066,
      description:'VNIR Band 187'
     },
     {
      name:'B188',
      center_wavelength_mean:1318.8829345703,
      center_wavelength_stdev:0.8650000095,
      fwhm_mean:5.7132005692,
      fwhm_stdev:0.1659999937,
      description:'VNIR Band 188'
     },
     {
      name:'B189',
      center_wavelength_mean:1323.8917236328,
      center_wavelength_stdev:0.8650000095,
      fwhm_mean:5.7147040367,
      fwhm_stdev:0.1669999957,
      description:'VNIR Band 189'
     },
     {
      name:'B190',
      center_wavelength_mean:1328.900390625,
      center_wavelength_stdev:0.8640000224,
      fwhm_mean:5.716219902,
      fwhm_stdev:0.1669999957,
      description:'VNIR Band 190'
     },
     {
      name:'B191',
      center_wavelength_mean:1333.9090576172,
      center_wavelength_stdev:0.8640000224,
      fwhm_mean:5.7177495956,
      fwhm_stdev:0.1679999977,
      description:'VNIR Band 191'
     },
     {
      name:'B192',
      center_wavelength_mean:1338.9178466797,
      center_wavelength_stdev:0.8640000224,
      fwhm_mean:5.7192921638,
      fwhm_stdev:0.1689999998,
      description:'VNIR Band 192'
     },
     {
      name:'B193',
      center_wavelength_mean:1343.9265136719,
      center_wavelength_stdev:0.8629999757,
      fwhm_mean:5.7208480835,
      fwhm_stdev:0.1689999998,
      description:'VNIR Band 193'
     },
     {
      name:'B194',
      center_wavelength_mean:1348.9351806641,
      center_wavelength_stdev:0.8629999757,
      fwhm_mean:5.7224164009,
      fwhm_stdev:0.1700000018,
      description:'VNIR Band 194'
     },
     {
      name:'B195',
      center_wavelength_mean:1353.9437255859,
      center_wavelength_stdev:0.8629999757,
      fwhm_mean:5.7239999771,
      fwhm_stdev:0.1710000038,
      description:'VNIR Band 195'
     },
     {
      name:'B196',
      center_wavelength_mean:1358.9527587891,
      center_wavelength_stdev:0.8619999886,
      fwhm_mean:5.7255959511,
      fwhm_stdev:0.1710000038,
      description:'VNIR Band 196'
     },
     {
      name:'B197',
      center_wavelength_mean:1363.9613037109,
      center_wavelength_stdev:0.8619999886,
      fwhm_mean:5.7272062302,
      fwhm_stdev:0.1720000058,
      description:'VNIR Band 197'
     },
     {
      name:'B198',
      center_wavelength_mean:1368.9699707031,
      center_wavelength_stdev:0.8619999886,
      fwhm_mean:5.728828907,
      fwhm_stdev:0.1720000058,
      description:'VNIR Band 198'
     },
     {
      name:'B199',
      center_wavelength_mean:1373.9787597656,
      center_wavelength_stdev:0.8610000014,
      fwhm_mean:5.7304649353,
      fwhm_stdev:0.172999993,
      description:'VNIR Band 199'
     },
     {
      name:'B200',
      center_wavelength_mean:1378.9873046875,
      center_wavelength_stdev:0.8610000014,
      fwhm_mean:5.7321157455,
      fwhm_stdev:0.173999995,
      description:'VNIR Band 200'
     },
     {
      name:'B201',
      center_wavelength_mean:1383.99609375,
      center_wavelength_stdev:0.8610000014,
      fwhm_mean:5.7337784767,
      fwhm_stdev:0.173999995,
      description:'VNIR Band 201'
     },
     {
      name:'B202',
      center_wavelength_mean:1389.0047607422,
      center_wavelength_stdev:0.8600000143,
      fwhm_mean:5.7354531288,
      fwhm_stdev:0.174999997,
      description:'VNIR Band 202'
     },
     {
      name:'B203',
      center_wavelength_mean:1394.0135498047,
      center_wavelength_stdev:0.8600000143,
      fwhm_mean:5.7371416092,
      fwhm_stdev:0.175999999,
      description:'VNIR Band 203'
     },
     {
      name:'B204',
      center_wavelength_mean:1399.0220947266,
      center_wavelength_stdev:0.8600000143,
      fwhm_mean:5.7388453484,
      fwhm_stdev:0.175999999,
      description:'VNIR Band 204'
     },
     {
      name:'B205',
      center_wavelength_mean:1404.0308837891,
      center_wavelength_stdev:0.8590000272,
      fwhm_mean:5.7405614853,
      fwhm_stdev:0.1770000011,
      description:'SWIR Band 205'
     },
     {
      name:'B206',
      center_wavelength_mean:1409.0394287109,
      center_wavelength_stdev:0.8590000272,
      fwhm_mean:5.7422904968,
      fwhm_stdev:0.1780000031,
      description:'SWIR Band 206'
     },
     {
      name:'B207',
      center_wavelength_mean:1414.0480957031,
      center_wavelength_stdev:0.8590000272,
      fwhm_mean:5.7440328598,
      fwhm_stdev:0.1790000051,
      description:'SWIR Band 207'
     },
     {
      name:'B208',
      center_wavelength_mean:1419.0568847656,
      center_wavelength_stdev:0.8579999804,
      fwhm_mean:5.7457880974,
      fwhm_stdev:0.1790000051,
      description:'SWIR Band 208'
     },
     {
      name:'B209',
      center_wavelength_mean:1424.0655517578,
      center_wavelength_stdev:0.8579999804,
      fwhm_mean:5.7475562096,
      fwhm_stdev:0.1800000072,
      description:'SWIR Band 209'
     },
     {
      name:'B210',
      center_wavelength_mean:1429.07421875,
      center_wavelength_stdev:0.8579999804,
      fwhm_mean:5.7493391037,
      fwhm_stdev:0.1809999943,
      description:'SWIR Band 210'
     },
     {
      name:'B211',
      center_wavelength_mean:1434.0830078125,
      center_wavelength_stdev:0.8569999933,
      fwhm_mean:5.7511329651,
      fwhm_stdev:0.1809999943,
      description:'SWIR Band 211'
     },
     {
      name:'B212',
      center_wavelength_mean:1439.0916748047,
      center_wavelength_stdev:0.8569999933,
      fwhm_mean:5.7529416084,
      fwhm_stdev:0.1819999963,
      description:'SWIR Band 212'
     },
     {
      name:'B213',
      center_wavelength_mean:1444.1003417969,
      center_wavelength_stdev:0.8569999933,
      fwhm_mean:5.75476408,
      fwhm_stdev:0.1829999983,
      description:'SWIR Band 213'
     },
     {
      name:'B214',
      center_wavelength_mean:1449.1087646484,
      center_wavelength_stdev:0.8560000062,
      fwhm_mean:5.7565979958,
      fwhm_stdev:0.1829999983,
      description:'SWIR Band 214'
     },
     {
      name:'B215',
      center_wavelength_mean:1454.1174316406,
      center_wavelength_stdev:0.8560000062,
      fwhm_mean:5.7584471703,
      fwhm_stdev:0.1840000004,
      description:'SWIR Band 215'
     },
     {
      name:'B216',
      center_wavelength_mean:1459.1263427734,
      center_wavelength_stdev:0.8560000062,
      fwhm_mean:5.7603063583,
      fwhm_stdev:0.1850000024,
      description:'SWIR Band 216'
     },
     {
      name:'B217',
      center_wavelength_mean:1464.1350097656,
      center_wavelength_stdev:0.8550000191,
      fwhm_mean:5.7621817589,
      fwhm_stdev:0.1850000024,
      description:'SWIR Band 217'
     },
     {
      name:'B218',
      center_wavelength_mean:1469.1435546875,
      center_wavelength_stdev:0.8550000191,
      fwhm_mean:5.7640676498,
      fwhm_stdev:0.1860000044,
      description:'SWIR Band 218'
     },
     {
      name:'B219',
      center_wavelength_mean:1474.1522216797,
      center_wavelength_stdev:0.8550000191,
      fwhm_mean:5.7659673691,
      fwhm_stdev:0.1870000064,
      description:'SWIR Band 219'
     },
     {
      name:'B220',
      center_wavelength_mean:1479.1610107422,
      center_wavelength_stdev:0.8539999723,
      fwhm_mean:5.7678799629,
      fwhm_stdev:0.1870000064,
      description:'SWIR Band 220'
     },
     {
      name:'B221',
      center_wavelength_mean:1484.1696777344,
      center_wavelength_stdev:0.8539999723,
      fwhm_mean:5.7698082924,
      fwhm_stdev:0.1879999936,
      description:'SWIR Band 221'
     },
     {
      name:'B222',
      center_wavelength_mean:1489.1784667969,
      center_wavelength_stdev:0.8539999723,
      fwhm_mean:5.7717471123,
      fwhm_stdev:0.1889999956,
      description:'SWIR Band 222'
     },
     {
      name:'B223',
      center_wavelength_mean:1494.1871337891,
      center_wavelength_stdev:0.8529999852,
      fwhm_mean:5.7736978531,
      fwhm_stdev:0.1899999976,
      description:'SWIR Band 223'
     },
     {
      name:'B224',
      center_wavelength_mean:1499.1959228516,
      center_wavelength_stdev:0.8529999852,
      fwhm_mean:5.7756624222,
      fwhm_stdev:0.1899999976,
      description:'SWIR Band 224'
     },
     {
      name:'B225',
      center_wavelength_mean:1504.2044677734,
      center_wavelength_stdev:0.8529999852,
      fwhm_mean:5.7776417732,
      fwhm_stdev:0.1909999996,
      description:'SWIR Band 225'
     },
     {
      name:'B226',
      center_wavelength_mean:1509.2135009766,
      center_wavelength_stdev:0.8519999981,
      fwhm_mean:5.779633522,
      fwhm_stdev:0.1920000017,
      description:'SWIR Band 226'
     },
     {
      name:'B227',
      center_wavelength_mean:1514.2219238281,
      center_wavelength_stdev:0.8519999981,
      fwhm_mean:5.7816381454,
      fwhm_stdev:0.1920000017,
      description:'SWIR Band 227'
     },
     {
      name:'B228',
      center_wavelength_mean:1519.2305908203,
      center_wavelength_stdev:0.8519999981,
      fwhm_mean:5.7836556435,
      fwhm_stdev:0.1930000037,
      description:'SWIR Band 228'
     },
     {
      name:'B229',
      center_wavelength_mean:1524.2393798828,
      center_wavelength_stdev:0.851000011,
      fwhm_mean:5.7856850624,
      fwhm_stdev:0.1940000057,
      description:'SWIR Band 229'
     },
     {
      name:'B230',
      center_wavelength_mean:1529.2479248047,
      center_wavelength_stdev:0.851000011,
      fwhm_mean:5.787727356,
      fwhm_stdev:0.1949999928,
      description:'SWIR Band 230'
     },
     {
      name:'B231',
      center_wavelength_mean:1534.2565917969,
      center_wavelength_stdev:0.851000011,
      fwhm_mean:5.7897839546,
      fwhm_stdev:0.1949999928,
      description:'SWIR Band 231'
     },
     {
      name:'B232',
      center_wavelength_mean:1539.2653808594,
      center_wavelength_stdev:0.851000011,
      fwhm_mean:5.7918543816,
      fwhm_stdev:0.1959999949,
      description:'SWIR Band 232'
     },
     {
      name:'B233',
      center_wavelength_mean:1544.2741699219,
      center_wavelength_stdev:0.8500000238,
      fwhm_mean:5.7939352989,
      fwhm_stdev:0.1969999969,
      description:'SWIR Band 233'
     },
     {
      name:'B234',
      center_wavelength_mean:1549.2828369141,
      center_wavelength_stdev:0.8500000238,
      fwhm_mean:5.7960314751,
      fwhm_stdev:0.1979999989,
      description:'SWIR Band 234'
     },
     {
      name:'B235',
      center_wavelength_mean:1554.2913818359,
      center_wavelength_stdev:0.8500000238,
      fwhm_mean:5.798137188,
      fwhm_stdev:0.1979999989,
      description:'SWIR Band 235'
     },
     {
      name:'B236',
      center_wavelength_mean:1559.3000488281,
      center_wavelength_stdev:0.8489999771,
      fwhm_mean:5.800260067,
      fwhm_stdev:0.199000001,
      description:'SWIR Band 236'
     },
     {
      name:'B237',
      center_wavelength_mean:1564.3088378906,
      center_wavelength_stdev:0.8489999771,
      fwhm_mean:5.8023934364,
      fwhm_stdev:0.200000003,
      description:'SWIR Band 237'
     },
     {
      name:'B238',
      center_wavelength_mean:1569.3175048828,
      center_wavelength_stdev:0.8489999771,
      fwhm_mean:5.8045392036,
      fwhm_stdev:0.200000003,
      description:'SWIR Band 238'
     },
     {
      name:'B239',
      center_wavelength_mean:1574.3260498047,
      center_wavelength_stdev:0.84799999,
      fwhm_mean:5.8066978455,
      fwhm_stdev:0.201000005,
      description:'SWIR Band 239'
     },
     {
      name:'B240',
      center_wavelength_mean:1579.3348388672,
      center_wavelength_stdev:0.84799999,
      fwhm_mean:5.808868885,
      fwhm_stdev:0.202000007,
      description:'SWIR Band 240'
     },
     {
      name:'B241',
      center_wavelength_mean:1584.3436279297,
      center_wavelength_stdev:0.84799999,
      fwhm_mean:5.8110542297,
      fwhm_stdev:0.2029999942,
      description:'SWIR Band 241'
     },
     {
      name:'B242',
      center_wavelength_mean:1589.3521728516,
      center_wavelength_stdev:0.8470000029,
      fwhm_mean:5.813252449,
      fwhm_stdev:0.2029999942,
      description:'SWIR Band 242'
     },
     {
      name:'B243',
      center_wavelength_mean:1594.3609619141,
      center_wavelength_stdev:0.8470000029,
      fwhm_mean:5.8154649734,
      fwhm_stdev:0.2039999962,
      description:'SWIR Band 243'
     },
     {
      name:'B244',
      center_wavelength_mean:1599.3695068359,
      center_wavelength_stdev:0.8470000029,
      fwhm_mean:5.8176870346,
      fwhm_stdev:0.2049999982,
      description:'SWIR Band 244'
     },
     {
      name:'B245',
      center_wavelength_mean:1604.3782958984,
      center_wavelength_stdev:0.8470000029,
      fwhm_mean:5.8199238777,
      fwhm_stdev:0.2060000002,
      description:'SWIR Band 245'
     },
     {
      name:'B246',
      center_wavelength_mean:1609.3869628906,
      center_wavelength_stdev:0.8460000157,
      fwhm_mean:5.8221731186,
      fwhm_stdev:0.2060000002,
      description:'SWIR Band 246'
     },
     {
      name:'B247',
      center_wavelength_mean:1614.3956298828,
      center_wavelength_stdev:0.8460000157,
      fwhm_mean:5.8244347572,
      fwhm_stdev:0.2070000023,
      description:'SWIR Band 247'
     },
     {
      name:'B248',
      center_wavelength_mean:1619.404296875,
      center_wavelength_stdev:0.8460000157,
      fwhm_mean:5.8267092705,
      fwhm_stdev:0.2080000043,
      description:'SWIR Band 248'
     },
     {
      name:'B249',
      center_wavelength_mean:1624.4129638672,
      center_wavelength_stdev:0.8450000286,
      fwhm_mean:5.8289957047,
      fwhm_stdev:0.2090000063,
      description:'SWIR Band 249'
     },
     {
      name:'B250',
      center_wavelength_mean:1629.4215087891,
      center_wavelength_stdev:0.8450000286,
      fwhm_mean:5.8312950134,
      fwhm_stdev:0.2090000063,
      description:'SWIR Band 250'
     },
     {
      name:'B251',
      center_wavelength_mean:1634.4302978516,
      center_wavelength_stdev:0.8450000286,
      fwhm_mean:5.8336081505,
      fwhm_stdev:0.2099999934,
      description:'SWIR Band 251'
     },
     {
      name:'B252',
      center_wavelength_mean:1639.4388427734,
      center_wavelength_stdev:0.8439999819,
      fwhm_mean:5.8359336853,
      fwhm_stdev:0.2109999955,
      description:'SWIR Band 252'
     },
     {
      name:'B253',
      center_wavelength_mean:1644.4475097656,
      center_wavelength_stdev:0.8439999819,
      fwhm_mean:5.8382716179,
      fwhm_stdev:0.2119999975,
      description:'SWIR Band 253'
     },
     {
      name:'B254',
      center_wavelength_mean:1649.4562988281,
      center_wavelength_stdev:0.8439999819,
      fwhm_mean:5.8406233788,
      fwhm_stdev:0.2129999995,
      description:'SWIR Band 254'
     },
     {
      name:'B255',
      center_wavelength_mean:1654.4649658203,
      center_wavelength_stdev:0.8439999819,
      fwhm_mean:5.8429870605,
      fwhm_stdev:0.2129999995,
      description:'SWIR Band 255'
     },
     {
      name:'B256',
      center_wavelength_mean:1659.4736328125,
      center_wavelength_stdev:0.8429999948,
      fwhm_mean:5.8453631401,
      fwhm_stdev:0.2140000015,
      description:'SWIR Band 256'
     },
     {
      name:'B257',
      center_wavelength_mean:1664.482421875,
      center_wavelength_stdev:0.8429999948,
      fwhm_mean:5.8477516174,
      fwhm_stdev:0.2150000036,
      description:'SWIR Band 257'
     },
     {
      name:'B258',
      center_wavelength_mean:1669.4910888672,
      center_wavelength_stdev:0.8429999948,
      fwhm_mean:5.8501534462,
      fwhm_stdev:0.2160000056,
      description:'SWIR Band 258'
     },
     {
      name:'B259',
      center_wavelength_mean:1674.5,
      center_wavelength_stdev:0.8420000076,
      fwhm_mean:5.8525662422,
      fwhm_stdev:0.2160000056,
      description:'SWIR Band 259'
     },
     {
      name:'B260',
      center_wavelength_mean:1679.5086669922,
      center_wavelength_stdev:0.8420000076,
      fwhm_mean:5.8549947739,
      fwhm_stdev:0.2169999927,
      description:'SWIR Band 260'
     },
     {
      name:'B261',
      center_wavelength_mean:1684.5173339844,
      center_wavelength_stdev:0.8420000076,
      fwhm_mean:5.8574318886,
      fwhm_stdev:0.2179999948,
      description:'SWIR Band 261'
     },
     {
      name:'B262',
      center_wavelength_mean:1689.5260009766,
      center_wavelength_stdev:0.8410000205,
      fwhm_mean:5.8598856926,
      fwhm_stdev:0.2189999968,
      description:'SWIR Band 262'
     },
     {
      name:'B263',
      center_wavelength_mean:1694.5345458984,
      center_wavelength_stdev:0.8410000205,
      fwhm_mean:5.8623495102,
      fwhm_stdev:0.2189999968,
      description:'SWIR Band 263'
     },
     {
      name:'B264',
      center_wavelength_mean:1699.5432128906,
      center_wavelength_stdev:0.8410000205,
      fwhm_mean:5.8648266792,
      fwhm_stdev:0.2199999988,
      description:'SWIR Band 264'
     },
     {
      name:'B265',
      center_wavelength_mean:1704.5518798828,
      center_wavelength_stdev:0.8410000205,
      fwhm_mean:5.8673167229,
      fwhm_stdev:0.2210000008,
      description:'SWIR Band 265'
     },
     {
      name:'B266',
      center_wavelength_mean:1709.5606689453,
      center_wavelength_stdev:0.8399999738,
      fwhm_mean:5.8698196411,
      fwhm_stdev:0.2220000029,
      description:'SWIR Band 266'
     },
     {
      name:'B267',
      center_wavelength_mean:1714.5692138672,
      center_wavelength_stdev:0.8399999738,
      fwhm_mean:5.8723330498,
      fwhm_stdev:0.2230000049,
      description:'SWIR Band 267'
     },
     {
      name:'B268',
      center_wavelength_mean:1719.5780029297,
      center_wavelength_stdev:0.8399999738,
      fwhm_mean:5.8748602867,
      fwhm_stdev:0.2230000049,
      description:'SWIR Band 268'
     },
     {
      name:'B269',
      center_wavelength_mean:1724.5867919922,
      center_wavelength_stdev:0.8389999866,
      fwhm_mean:5.8774027824,
      fwhm_stdev:0.2240000069,
      description:'SWIR Band 269'
     },
     {
      name:'B270',
      center_wavelength_mean:1729.5954589844,
      center_wavelength_stdev:0.8389999866,
      fwhm_mean:5.8799548149,
      fwhm_stdev:0.224999994,
      description:'SWIR Band 270'
     },
     {
      name:'B271',
      center_wavelength_mean:1734.6041259766,
      center_wavelength_stdev:0.8389999866,
      fwhm_mean:5.882519722,
      fwhm_stdev:0.2259999961,
      description:'SWIR Band 271'
     },
     {
      name:'B272',
      center_wavelength_mean:1739.6129150391,
      center_wavelength_stdev:0.8389999866,
      fwhm_mean:5.8850975037,
      fwhm_stdev:0.2269999981,
      description:'SWIR Band 272'
     },
     {
      name:'B273',
      center_wavelength_mean:1744.6214599609,
      center_wavelength_stdev:0.8379999995,
      fwhm_mean:5.8876876831,
      fwhm_stdev:0.2269999981,
      description:'SWIR Band 273'
     },
     {
      name:'B274',
      center_wavelength_mean:1749.6301269531,
      center_wavelength_stdev:0.8379999995,
      fwhm_mean:5.8902897835,
      fwhm_stdev:0.2280000001,
      description:'SWIR Band 274'
     },
     {
      name:'B275',
      center_wavelength_mean:1754.6387939453,
      center_wavelength_stdev:0.8379999995,
      fwhm_mean:5.8929057121,
      fwhm_stdev:0.2290000021,
      description:'SWIR Band 275'
     },
     {
      name:'B276',
      center_wavelength_mean:1759.6475830078,
      center_wavelength_stdev:0.8370000124,
      fwhm_mean:5.8955335617,
      fwhm_stdev:0.2300000042,
      description:'SWIR Band 276'
     },
     {
      name:'B277',
      center_wavelength_mean:1764.65625,
      center_wavelength_stdev:0.8370000124,
      fwhm_mean:5.8981719017,
      fwhm_stdev:0.2310000062,
      description:'SWIR Band 277'
     },
     {
      name:'B278',
      center_wavelength_mean:1769.6650390625,
      center_wavelength_stdev:0.8370000124,
      fwhm_mean:5.9008259773,
      fwhm_stdev:0.2310000062,
      description:'SWIR Band 278'
     },
     {
      name:'B279',
      center_wavelength_mean:1774.6737060547,
      center_wavelength_stdev:0.8370000124,
      fwhm_mean:5.903491497,
      fwhm_stdev:0.2319999933,
      description:'SWIR Band 279'
     },
     {
      name:'B280',
      center_wavelength_mean:1779.6823730469,
      center_wavelength_stdev:0.8360000253,
      fwhm_mean:5.9061689377,
      fwhm_stdev:0.2329999954,
      description:'SWIR Band 280'
     },
     {
      name:'B281',
      center_wavelength_mean:1784.6910400391,
      center_wavelength_stdev:0.8360000253,
      fwhm_mean:5.9088587761,
      fwhm_stdev:0.2339999974,
      description:'SWIR Band 281'
     },
     {
      name:'B282',
      center_wavelength_mean:1789.6995849609,
      center_wavelength_stdev:0.8360000253,
      fwhm_mean:5.9115614891,
      fwhm_stdev:0.2349999994,
      description:'SWIR Band 282'
     },
     {
      name:'B283',
      center_wavelength_mean:1794.7081298828,
      center_wavelength_stdev:0.8360000253,
      fwhm_mean:5.9142770767,
      fwhm_stdev:0.2360000014,
      description:'SWIR Band 283'
     },
     {
      name:'B284',
      center_wavelength_mean:1799.7170410156,
      center_wavelength_stdev:0.8349999785,
      fwhm_mean:5.9170041084,
      fwhm_stdev:0.2360000014,
      description:'SWIR Band 284'
     },
     {
      name:'B285',
      center_wavelength_mean:1804.7255859375,
      center_wavelength_stdev:0.8349999785,
      fwhm_mean:5.9197435379,
      fwhm_stdev:0.2370000035,
      description:'SWIR Band 285'
     },
     {
      name:'B286',
      center_wavelength_mean:1809.7342529297,
      center_wavelength_stdev:0.8349999785,
      fwhm_mean:5.9224944115,
      fwhm_stdev:0.2380000055,
      description:'SWIR Band 286'
     },
     {
      name:'B287',
      center_wavelength_mean:1814.7432861328,
      center_wavelength_stdev:0.8339999914,
      fwhm_mean:5.925260067,
      fwhm_stdev:0.2389999926,
      description:'SWIR Band 287'
     },
     {
      name:'B288',
      center_wavelength_mean:1819.751953125,
      center_wavelength_stdev:0.8339999914,
      fwhm_mean:5.9280371666,
      fwhm_stdev:0.2399999946,
      description:'SWIR Band 288'
     },
     {
      name:'B289',
      center_wavelength_mean:1824.7604980469,
      center_wavelength_stdev:0.8339999914,
      fwhm_mean:5.9308257103,
      fwhm_stdev:0.2409999967,
      description:'SWIR Band 289'
     },
     {
      name:'B290',
      center_wavelength_mean:1829.7692871094,
      center_wavelength_stdev:0.8339999914,
      fwhm_mean:5.9336285591,
      fwhm_stdev:0.2409999967,
      description:'SWIR Band 290'
     },
     {
      name:'B291',
      center_wavelength_mean:1834.7779541016,
      center_wavelength_stdev:0.8330000043,
      fwhm_mean:5.936439991,
      fwhm_stdev:0.2419999987,
      description:'SWIR Band 291'
     },
     {
      name:'B292',
      center_wavelength_mean:1839.7864990234,
      center_wavelength_stdev:0.8330000043,
      fwhm_mean:5.9392695427,
      fwhm_stdev:0.2430000007,
      description:'SWIR Band 292'
     },
     {
      name:'B293',
      center_wavelength_mean:1844.7951660156,
      center_wavelength_stdev:0.8330000043,
      fwhm_mean:5.9421072006,
      fwhm_stdev:0.2440000027,
      description:'SWIR Band 293'
     },
     {
      name:'B294',
      center_wavelength_mean:1849.8038330078,
      center_wavelength_stdev:0.8330000043,
      fwhm_mean:5.9449577332,
      fwhm_stdev:0.2450000048,
      description:'SWIR Band 294'
     },
     {
      name:'B295',
      center_wavelength_mean:1854.8125,
      center_wavelength_stdev:0.8320000172,
      fwhm_mean:5.9478211403,
      fwhm_stdev:0.2460000068,
      description:'SWIR Band 295'
     },
     {
      name:'B296',
      center_wavelength_mean:1859.8214111328,
      center_wavelength_stdev:0.8320000172,
      fwhm_mean:5.950697422,
      fwhm_stdev:0.2460000068,
      description:'SWIR Band 296'
     },
     {
      name:'B297',
      center_wavelength_mean:1864.830078125,
      center_wavelength_stdev:0.8320000172,
      fwhm_mean:5.9535861015,
      fwhm_stdev:0.2469999939,
      description:'SWIR Band 297'
     },
     {
      name:'B298',
      center_wavelength_mean:1869.8388671875,
      center_wavelength_stdev:0.8320000172,
      fwhm_mean:5.9564862251,
      fwhm_stdev:0.2479999959,
      description:'SWIR Band 298'
     },
     {
      name:'B299',
      center_wavelength_mean:1874.8474121094,
      center_wavelength_stdev:0.8309999704,
      fwhm_mean:5.9593987465,
      fwhm_stdev:0.248999998,
      description:'SWIR Band 299'
     },
     {
      name:'B300',
      center_wavelength_mean:1879.8562011719,
      center_wavelength_stdev:0.8309999704,
      fwhm_mean:5.9623250961,
      fwhm_stdev:0.25,
      description:'SWIR Band 300'
     },
     {
      name:'B301',
      center_wavelength_mean:1884.8646240234,
      center_wavelength_stdev:0.8309999704,
      fwhm_mean:5.965259552,
      fwhm_stdev:0.2509999871,
      description:'SWIR Band 301'
     },
     {
      name:'B302',
      center_wavelength_mean:1889.8734130859,
      center_wavelength_stdev:0.8299999833,
      fwhm_mean:5.9682116508,
      fwhm_stdev:0.2520000041,
      description:'SWIR Band 302'
     },
     {
      name:'B303',
      center_wavelength_mean:1894.8820800781,
      center_wavelength_stdev:0.8299999833,
      fwhm_mean:5.9711723328,
      fwhm_stdev:0.2520000041,
      description:'SWIR Band 303'
     },
     {
      name:'B304',
      center_wavelength_mean:1899.8907470703,
      center_wavelength_stdev:0.8299999833,
      fwhm_mean:5.9741487503,
      fwhm_stdev:0.2529999912,
      description:'SWIR Band 304'
     },
     {
      name:'B305',
      center_wavelength_mean:1904.8995361328,
      center_wavelength_stdev:0.8299999833,
      fwhm_mean:5.9771342278,
      fwhm_stdev:0.2540000081,
      description:'SWIR Band 305'
     },
     {
      name:'B306',
      center_wavelength_mean:1909.908203125,
      center_wavelength_stdev:0.8289999962,
      fwhm_mean:5.980132103,
      fwhm_stdev:0.2549999952,
      description:'SWIR Band 306'
     },
     {
      name:'B307',
      center_wavelength_mean:1914.9168701172,
      center_wavelength_stdev:0.8289999962,
      fwhm_mean:5.9831457138,
      fwhm_stdev:0.2560000122,
      description:'SWIR Band 307'
     },
     {
      name:'B308',
      center_wavelength_mean:1919.9255371094,
      center_wavelength_stdev:0.8289999962,
      fwhm_mean:5.9861707687,
      fwhm_stdev:0.2569999993,
      description:'SWIR Band 308'
     },
     {
      name:'B309',
      center_wavelength_mean:1924.9343261719,
      center_wavelength_stdev:0.8289999962,
      fwhm_mean:5.9892039299,
      fwhm_stdev:0.2579999864,
      description:'SWIR Band 309'
     },
     {
      name:'B310',
      center_wavelength_mean:1929.9427490234,
      center_wavelength_stdev:0.8280000091,
      fwhm_mean:5.9922523499,
      fwhm_stdev:0.2579999864,
      description:'SWIR Band 310'
     },
     {
      name:'B311',
      center_wavelength_mean:1934.9515380859,
      center_wavelength_stdev:0.8280000091,
      fwhm_mean:5.9953122139,
      fwhm_stdev:0.2590000033,
      description:'SWIR Band 311'
     },
     {
      name:'B312',
      center_wavelength_mean:1939.9603271484,
      center_wavelength_stdev:0.8280000091,
      fwhm_mean:5.9983839989,
      fwhm_stdev:0.2599999905,
      description:'SWIR Band 312'
     },
     {
      name:'B313',
      center_wavelength_mean:1944.9688720703,
      center_wavelength_stdev:0.8280000091,
      fwhm_mean:6.001470089,
      fwhm_stdev:0.2610000074,
      description:'SWIR Band 313'
     },
     {
      name:'B314',
      center_wavelength_mean:1949.9775390625,
      center_wavelength_stdev:0.8270000219,
      fwhm_mean:6.0045661926,
      fwhm_stdev:0.2619999945,
      description:'SWIR Band 314'
     },
     {
      name:'B315',
      center_wavelength_mean:1954.986328125,
      center_wavelength_stdev:0.8270000219,
      fwhm_mean:6.0076766014,
      fwhm_stdev:0.2630000114,
      description:'SWIR Band 315'
     },
     {
      name:'B316',
      center_wavelength_mean:1959.9949951172,
      center_wavelength_stdev:0.8270000219,
      fwhm_mean:6.0107979774,
      fwhm_stdev:0.2639999986,
      description:'SWIR Band 316'
     },
     {
      name:'B317',
      center_wavelength_mean:1965.0036621094,
      center_wavelength_stdev:0.8270000219,
      fwhm_mean:6.0139317513,
      fwhm_stdev:0.2649999857,
      description:'SWIR Band 317'
     },
     {
      name:'B318',
      center_wavelength_mean:1970.0123291016,
      center_wavelength_stdev:0.8259999752,
      fwhm_mean:6.0170788765,
      fwhm_stdev:0.2660000026,
      description:'SWIR Band 318'
     },
     {
      name:'B319',
      center_wavelength_mean:1975.0207519531,
      center_wavelength_stdev:0.8259999752,
      fwhm_mean:6.020236969,
      fwhm_stdev:0.2660000026,
      description:'SWIR Band 319'
     },
     {
      name:'B320',
      center_wavelength_mean:1980.0296630859,
      center_wavelength_stdev:0.8259999752,
      fwhm_mean:6.0234069824,
      fwhm_stdev:0.2669999897,
      description:'SWIR Band 320'
     },
     {
      name:'B321',
      center_wavelength_mean:1985.0384521484,
      center_wavelength_stdev:0.8259999752,
      fwhm_mean:6.0265884399,
      fwhm_stdev:0.2680000067,
      description:'SWIR Band 321'
     },
     {
      name:'B322',
      center_wavelength_mean:1990.0469970703,
      center_wavelength_stdev:0.8249999881,
      fwhm_mean:6.0297827721,
      fwhm_stdev:0.2689999938,
      description:'SWIR Band 322'
     },
     {
      name:'B323',
      center_wavelength_mean:1995.0557861328,
      center_wavelength_stdev:0.8249999881,
      fwhm_mean:6.0329909325,
      fwhm_stdev:0.2700000107,
      description:'SWIR Band 323'
     },
     {
      name:'B324',
      center_wavelength_mean:2000.064453125,
      center_wavelength_stdev:0.8249999881,
      fwhm_mean:6.0362091064,
      fwhm_stdev:0.2709999979,
      description:'SWIR Band 324'
     },
     {
      name:'B325',
      center_wavelength_mean:2005.0732421875,
      center_wavelength_stdev:0.8249999881,
      fwhm_mean:6.0394430161,
      fwhm_stdev:0.2720000148,
      description:'SWIR Band 325'
     },
     {
      name:'B326',
      center_wavelength_mean:2010.0819091797,
      center_wavelength_stdev:0.8249999881,
      fwhm_mean:6.0426836014,
      fwhm_stdev:0.2730000019,
      description:'SWIR Band 326'
     },
     {
      name:'B327',
      center_wavelength_mean:2015.0905761719,
      center_wavelength_stdev:0.824000001,
      fwhm_mean:6.0459413528,
      fwhm_stdev:0.273999989,
      description:'SWIR Band 327'
     },
     {
      name:'B328',
      center_wavelength_mean:2020.0992431641,
      center_wavelength_stdev:0.824000001,
      fwhm_mean:6.0492095947,
      fwhm_stdev:0.275000006,
      description:'SWIR Band 328'
     },
     {
      name:'B329',
      center_wavelength_mean:2025.1077880859,
      center_wavelength_stdev:0.824000001,
      fwhm_mean:6.0524907112,
      fwhm_stdev:0.275000006,
      description:'SWIR Band 329'
     },
     {
      name:'B330',
      center_wavelength_mean:2030.1164550781,
      center_wavelength_stdev:0.824000001,
      fwhm_mean:6.0557823181,
      fwhm_stdev:0.2759999931,
      description:'SWIR Band 330'
     },
     {
      name:'B331',
      center_wavelength_mean:2035.1251220703,
      center_wavelength_stdev:0.8230000138,
      fwhm_mean:6.0590858459,
      fwhm_stdev:0.27700001,
      description:'SWIR Band 331'
     },
     {
      name:'B332',
      center_wavelength_mean:2040.1339111328,
      center_wavelength_stdev:0.8230000138,
      fwhm_mean:6.0624046326,
      fwhm_stdev:0.2779999971,
      description:'SWIR Band 332'
     },
     {
      name:'B333',
      center_wavelength_mean:2045.1427001953,
      center_wavelength_stdev:0.8230000138,
      fwhm_mean:6.0657343864,
      fwhm_stdev:0.2790000141,
      description:'SWIR Band 333'
     },
     {
      name:'B334',
      center_wavelength_mean:2050.1516113281,
      center_wavelength_stdev:0.8230000138,
      fwhm_mean:6.0690751076,
      fwhm_stdev:0.2800000012,
      description:'SWIR Band 334'
     },
     {
      name:'B335',
      center_wavelength_mean:2055.1599121094,
      center_wavelength_stdev:0.8220000267,
      fwhm_mean:6.0724272728,
      fwhm_stdev:0.2809999883,
      description:'SWIR Band 335'
     },
     {
      name:'B336',
      center_wavelength_mean:2060.1687011719,
      center_wavelength_stdev:0.8220000267,
      fwhm_mean:6.0757932663,
      fwhm_stdev:0.2820000052,
      description:'SWIR Band 336'
     },
     {
      name:'B337',
      center_wavelength_mean:2065.1772460938,
      center_wavelength_stdev:0.8220000267,
      fwhm_mean:6.0791707039,
      fwhm_stdev:0.2829999924,
      description:'SWIR Band 337'
     },
     {
      name:'B338',
      center_wavelength_mean:2070.1860351562,
      center_wavelength_stdev:0.8220000267,
      fwhm_mean:6.0825619698,
      fwhm_stdev:0.2840000093,
      description:'SWIR Band 338'
     },
     {
      name:'B339',
      center_wavelength_mean:2075.1948242188,
      center_wavelength_stdev:0.8220000267,
      fwhm_mean:6.0859642029,
      fwhm_stdev:0.2849999964,
      description:'SWIR Band 339'
     },
     {
      name:'B340',
      center_wavelength_mean:2080.2033691406,
      center_wavelength_stdev:0.82099998,
      fwhm_mean:6.0893778801,
      fwhm_stdev:0.2860000134,
      description:'SWIR Band 340'
     },
     {
      name:'B341',
      center_wavelength_mean:2085.2121582031,
      center_wavelength_stdev:0.82099998,
      fwhm_mean:6.0928053856,
      fwhm_stdev:0.2870000005,
      description:'SWIR Band 341'
     },
     {
      name:'B342',
      center_wavelength_mean:2090.2209472656,
      center_wavelength_stdev:0.82099998,
      fwhm_mean:6.0962424278,
      fwhm_stdev:0.2879999876,
      description:'SWIR Band 342'
     },
     {
      name:'B343',
      center_wavelength_mean:2095.2294921875,
      center_wavelength_stdev:0.82099998,
      fwhm_mean:6.099694252,
      fwhm_stdev:0.2879999876,
      description:'SWIR Band 343'
     },
     {
      name:'B344',
      center_wavelength_mean:2100.23828125,
      center_wavelength_stdev:0.8199999928,
      fwhm_mean:6.1031575203,
      fwhm_stdev:0.2890000045,
      description:'SWIR Band 344'
     },
     {
      name:'B345',
      center_wavelength_mean:2105.2465820312,
      center_wavelength_stdev:0.8199999928,
      fwhm_mean:6.1066336632,
      fwhm_stdev:0.2899999917,
      description:'SWIR Band 345'
     },
     {
      name:'B346',
      center_wavelength_mean:2110.2556152344,
      center_wavelength_stdev:0.8199999928,
      fwhm_mean:6.110121727,
      fwhm_stdev:0.2910000086,
      description:'SWIR Band 346'
     },
     {
      name:'B347',
      center_wavelength_mean:2115.2641601562,
      center_wavelength_stdev:0.8199999928,
      fwhm_mean:6.1136212349,
      fwhm_stdev:0.2919999957,
      description:'SWIR Band 347'
     },
     {
      name:'B348',
      center_wavelength_mean:2120.2729492188,
      center_wavelength_stdev:0.8199999928,
      fwhm_mean:6.1171312332,
      fwhm_stdev:0.2930000126,
      description:'SWIR Band 348'
     },
     {
      name:'B349',
      center_wavelength_mean:2125.2817382812,
      center_wavelength_stdev:0.8190000057,
      fwhm_mean:6.1206579208,
      fwhm_stdev:0.2939999998,
      description:'SWIR Band 349'
     },
     {
      name:'B350',
      center_wavelength_mean:2130.2902832031,
      center_wavelength_stdev:0.8190000057,
      fwhm_mean:6.1241941452,
      fwhm_stdev:0.2949999869,
      description:'SWIR Band 350'
     },
     {
      name:'B351',
      center_wavelength_mean:2135.2990722656,
      center_wavelength_stdev:0.8190000057,
      fwhm_mean:6.1277422905,
      fwhm_stdev:0.2960000038,
      description:'SWIR Band 351'
     },
     {
      name:'B352',
      center_wavelength_mean:2140.3078613281,
      center_wavelength_stdev:0.8190000057,
      fwhm_mean:6.1313023567,
      fwhm_stdev:0.2969999909,
      description:'SWIR Band 352'
     },
     {
      name:'B353',
      center_wavelength_mean:2145.31640625,
      center_wavelength_stdev:0.8180000186,
      fwhm_mean:6.1348776817,
      fwhm_stdev:0.2980000079,
      description:'SWIR Band 353'
     },
     {
      name:'B354',
      center_wavelength_mean:2150.3249511719,
      center_wavelength_stdev:0.8180000186,
      fwhm_mean:6.1384620667,
      fwhm_stdev:0.298999995,
      description:'SWIR Band 354'
     },
     {
      name:'B355',
      center_wavelength_mean:2155.3337402344,
      center_wavelength_stdev:0.8180000186,
      fwhm_mean:6.1420588493,
      fwhm_stdev:0.3000000119,
      description:'SWIR Band 355'
     },
     {
      name:'B356',
      center_wavelength_mean:2160.3422851562,
      center_wavelength_stdev:0.8180000186,
      fwhm_mean:6.1456670761,
      fwhm_stdev:0.300999999,
      description:'SWIR Band 356'
     },
     {
      name:'B357',
      center_wavelength_mean:2165.3510742188,
      center_wavelength_stdev:0.8180000186,
      fwhm_mean:6.1492905617,
      fwhm_stdev:0.3019999862,
      description:'SWIR Band 357'
     },
     {
      name:'B358',
      center_wavelength_mean:2170.3598632812,
      center_wavelength_stdev:0.8169999719,
      fwhm_mean:6.1529250145,
      fwhm_stdev:0.3030000031,
      description:'SWIR Band 358'
     },
     {
      name:'B359',
      center_wavelength_mean:2175.3684082031,
      center_wavelength_stdev:0.8169999719,
      fwhm_mean:6.1565718651,
      fwhm_stdev:0.3039999902,
      description:'SWIR Band 359'
     },
     {
      name:'B360',
      center_wavelength_mean:2180.3774414062,
      center_wavelength_stdev:0.8169999719,
      fwhm_mean:6.1602296829,
      fwhm_stdev:0.3050000072,
      description:'SWIR Band 360'
     },
     {
      name:'B361',
      center_wavelength_mean:2185.3859863281,
      center_wavelength_stdev:0.8169999719,
      fwhm_mean:6.163901329,
      fwhm_stdev:0.3059999943,
      description:'SWIR Band 361'
     },
     {
      name:'B362',
      center_wavelength_mean:2190.3947753906,
      center_wavelength_stdev:0.8169999719,
      fwhm_mean:6.1675834656,
      fwhm_stdev:0.3070000112,
      description:'SWIR Band 362'
     },
     {
      name:'B363',
      center_wavelength_mean:2195.4033203125,
      center_wavelength_stdev:0.8159999847,
      fwhm_mean:6.1712794304,
      fwhm_stdev:0.3079999983,
      description:'SWIR Band 363'
     },
     {
      name:'B364',
      center_wavelength_mean:2200.4118652344,
      center_wavelength_stdev:0.8159999847,
      fwhm_mean:6.1749868393,
      fwhm_stdev:0.3089999855,
      description:'SWIR Band 364'
     },
     {
      name:'B365',
      center_wavelength_mean:2205.4206542969,
      center_wavelength_stdev:0.8159999847,
      fwhm_mean:6.1787075996,
      fwhm_stdev:0.3100000024,
      description:'SWIR Band 365'
     },
     {
      name:'B366',
      center_wavelength_mean:2210.4291992188,
      center_wavelength_stdev:0.8159999847,
      fwhm_mean:6.1824350357,
      fwhm_stdev:0.3109999895,
      description:'SWIR Band 366'
     },
     {
      name:'B367',
      center_wavelength_mean:2215.4377441406,
      center_wavelength_stdev:0.8159999847,
      fwhm_mean:6.1861815453,
      fwhm_stdev:0.3120000064,
      description:'SWIR Band 367'
     },
     {
      name:'B368',
      center_wavelength_mean:2220.4467773438,
      center_wavelength_stdev:0.8149999976,
      fwhm_mean:6.1899399757,
      fwhm_stdev:0.3129999936,
      description:'SWIR Band 368'
     },
     {
      name:'B369',
      center_wavelength_mean:2225.4555664062,
      center_wavelength_stdev:0.8149999976,
      fwhm_mean:6.1937074661,
      fwhm_stdev:0.3140000105,
      description:'SWIR Band 369'
     },
     {
      name:'B370',
      center_wavelength_mean:2230.4641113281,
      center_wavelength_stdev:0.8149999976,
      fwhm_mean:6.1974868774,
      fwhm_stdev:0.3149999976,
      description:'SWIR Band 370'
     },
     {
      name:'B371',
      center_wavelength_mean:2235.4729003906,
      center_wavelength_stdev:0.8149999976,
      fwhm_mean:6.2012815475,
      fwhm_stdev:0.3160000145,
      description:'SWIR Band 371'
     },
     {
      name:'B372',
      center_wavelength_mean:2240.4816894531,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2050871849,
      fwhm_stdev:0.3170000017,
      description:'SWIR Band 372'
     },
     {
      name:'B373',
      center_wavelength_mean:2245.4899902344,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2089042664,
      fwhm_stdev:0.3179999888,
      description:'SWIR Band 373'
     },
     {
      name:'B374',
      center_wavelength_mean:2250.4987792969,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2127342224,
      fwhm_stdev:0.3190000057,
      description:'SWIR Band 374'
     },
     {
      name:'B375',
      center_wavelength_mean:2255.5073242188,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2165765762,
      fwhm_stdev:0.3199999928,
      description:'SWIR Band 375'
     },
     {
      name:'B376',
      center_wavelength_mean:2260.5161132812,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2204318047,
      fwhm_stdev:0.3210000098,
      description:'SWIR Band 376'
     },
     {
      name:'B377',
      center_wavelength_mean:2265.5246582031,
      center_wavelength_stdev:0.8140000105,
      fwhm_mean:6.2242980003,
      fwhm_stdev:0.3219999969,
      description:'SWIR Band 377'
     },
     {
      name:'B378',
      center_wavelength_mean:2270.5334472656,
      center_wavelength_stdev:0.8130000234,
      fwhm_mean:6.228178978,
      fwhm_stdev:0.3230000138,
      description:'SWIR Band 378'
     },
     {
      name:'B379',
      center_wavelength_mean:2275.5422363281,
      center_wavelength_stdev:0.8130000234,
      fwhm_mean:6.232070446,
      fwhm_stdev:0.324000001,
      description:'SWIR Band 379'
     },
     {
      name:'B380',
      center_wavelength_mean:2280.5510253906,
      center_wavelength_stdev:0.8130000234,
      fwhm_mean:6.2359743118,
      fwhm_stdev:0.3249999881,
      description:'SWIR Band 380'
     },
     {
      name:'B381',
      center_wavelength_mean:2285.5598144531,
      center_wavelength_stdev:0.8130000234,
      fwhm_mean:6.2398934364,
      fwhm_stdev:0.326000005,
      description:'SWIR Band 381'
     },
     {
      name:'B382',
      center_wavelength_mean:2290.568359375,
      center_wavelength_stdev:0.8130000234,
      fwhm_mean:6.2438197136,
      fwhm_stdev:0.3269999921,
      description:'SWIR Band 382'
     },
     {
      name:'B383',
      center_wavelength_mean:2295.5769042969,
      center_wavelength_stdev:0.8119999766,
      fwhm_mean:6.247759819,
      fwhm_stdev:0.3289999962,
      description:'SWIR Band 383'
     },
     {
      name:'B384',
      center_wavelength_mean:2300.5856933594,
      center_wavelength_stdev:0.8119999766,
      fwhm_mean:6.2517142296,
      fwhm_stdev:0.3300000131,
      description:'SWIR Band 384'
     },
     {
      name:'B385',
      center_wavelength_mean:2305.5942382812,
      center_wavelength_stdev:0.8119999766,
      fwhm_mean:6.2556796074,
      fwhm_stdev:0.3310000002,
      description:'SWIR Band 385'
     },
     {
      name:'B386',
      center_wavelength_mean:2310.6030273438,
      center_wavelength_stdev:0.8119999766,
      fwhm_mean:6.2596588135,
      fwhm_stdev:0.3319999874,
      description:'SWIR Band 386'
     },
     {
      name:'B387',
      center_wavelength_mean:2315.6115722656,
      center_wavelength_stdev:0.8119999766,
      fwhm_mean:6.2636504173,
      fwhm_stdev:0.3330000043,
      description:'SWIR Band 387'
     },
     {
      name:'B388',
      center_wavelength_mean:2320.6203613281,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2676510811,
      fwhm_stdev:0.3339999914,
      description:'SWIR Band 388'
     },
     {
      name:'B389',
      center_wavelength_mean:2325.6291503906,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2716665268,
      fwhm_stdev:0.3350000083,
      description:'SWIR Band 389'
     },
     {
      name:'B390',
      center_wavelength_mean:2330.6379394531,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2756962776,
      fwhm_stdev:0.3359999955,
      description:'SWIR Band 390'
     },
     {
      name:'B391',
      center_wavelength_mean:2335.646484375,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2797346115,
      fwhm_stdev:0.3370000124,
      description:'SWIR Band 391'
     },
     {
      name:'B392',
      center_wavelength_mean:2340.6550292969,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2837891579,
      fwhm_stdev:0.3379999995,
      description:'SWIR Band 392'
     },
     {
      name:'B393',
      center_wavelength_mean:2345.6638183594,
      center_wavelength_stdev:0.8109999895,
      fwhm_mean:6.2878541946,
      fwhm_stdev:0.3389999866,
      description:'SWIR Band 393'
     },
     {
      name:'B394',
      center_wavelength_mean:2350.6723632812,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.2919316292,
      fwhm_stdev:0.3400000036,
      description:'SWIR Band 394'
     },
     {
      name:'B395',
      center_wavelength_mean:2355.6811523438,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.2960209846,
      fwhm_stdev:0.3420000076,
      description:'SWIR Band 395'
     },
     {
      name:'B396',
      center_wavelength_mean:2360.6899414062,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.3001246452,
      fwhm_stdev:0.3429999948,
      description:'SWIR Band 396'
     },
     {
      name:'B397',
      center_wavelength_mean:2365.6984863281,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.3042397499,
      fwhm_stdev:0.3440000117,
      description:'SWIR Band 397'
     },
     {
      name:'B398',
      center_wavelength_mean:2370.7072753906,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.3083672523,
      fwhm_stdev:0.3449999988,
      description:'SWIR Band 398'
     },
     {
      name:'B399',
      center_wavelength_mean:2375.7160644531,
      center_wavelength_stdev:0.8100000024,
      fwhm_mean:6.3125076294,
      fwhm_stdev:0.3459999859,
      description:'SWIR Band 399'
     },
     {
      name:'B400',
      center_wavelength_mean:2380.724609375,
      center_wavelength_stdev:0.8090000153,
      fwhm_mean:6.3166589737,
      fwhm_stdev:0.3470000029,
      description:'SWIR Band 400'
     },
     {
      name:'B401',
      center_wavelength_mean:2385.7331542969,
      center_wavelength_stdev:0.8090000153,
      fwhm_mean:6.3208250999,
      fwhm_stdev:0.34799999,
      description:'SWIR Band 401'
     },
     {
      name:'B402',
      center_wavelength_mean:2390.7421875,
      center_wavelength_stdev:0.8090000153,
      fwhm_mean:6.325003624,
      fwhm_stdev:0.3490000069,
      description:'SWIR Band 402'
     },
     {
      name:'B403',
      center_wavelength_mean:2395.7507324219,
      center_wavelength_stdev:0.8090000153,
      fwhm_mean:6.3291935921,
      fwhm_stdev:0.351000011,
      description:'SWIR Band 403'
     },
     {
      name:'B404',
      center_wavelength_mean:2400.7592773438,
      center_wavelength_stdev:0.8090000153,
      fwhm_mean:6.3333954811,
      fwhm_stdev:0.3519999981,
      description:'SWIR Band 404'
     },
     {
      name:'B405',
      center_wavelength_mean:2405.7678222656,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3376121521,
      fwhm_stdev:0.3529999852,
      description:'SWIR Band 405'
     },
     {
      name:'B406',
      center_wavelength_mean:2410.7768554688,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3418416977,
      fwhm_stdev:0.3540000021,
      description:'SWIR Band 406'
     },
     {
      name:'B407',
      center_wavelength_mean:2415.7854003906,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3460812569,
      fwhm_stdev:0.3549999893,
      description:'SWIR Band 407'
     },
     {
      name:'B408',
      center_wavelength_mean:2420.7941894531,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3503351212,
      fwhm_stdev:0.3560000062,
      description:'SWIR Band 408'
     },
     {
      name:'B409',
      center_wavelength_mean:2425.8029785156,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3545999527,
      fwhm_stdev:0.3569999933,
      description:'SWIR Band 409'
     },
     {
      name:'B410',
      center_wavelength_mean:2430.8112792969,
      center_wavelength_stdev:0.8080000281,
      fwhm_mean:6.3588795662,
      fwhm_stdev:0.3589999974,
      description:'SWIR Band 410'
     },
     {
      name:'B411',
      center_wavelength_mean:2435.8200683594,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.3631701469,
      fwhm_stdev:0.3600000143,
      description:'SWIR Band 411'
     },
     {
      name:'B412',
      center_wavelength_mean:2440.8286132812,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.367474556,
      fwhm_stdev:0.3610000014,
      description:'SWIR Band 412'
     },
     {
      name:'B413',
      center_wavelength_mean:2445.8374023438,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.3717904091,
      fwhm_stdev:0.3619999886,
      description:'SWIR Band 413'
     },
     {
      name:'B414',
      center_wavelength_mean:2450.8459472656,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.376121521,
      fwhm_stdev:0.3630000055,
      description:'SWIR Band 414'
     },
     {
      name:'B415',
      center_wavelength_mean:2455.8549804688,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.3804626465,
      fwhm_stdev:0.3639999926,
      description:'SWIR Band 415'
     },
     {
      name:'B416',
      center_wavelength_mean:2460.8635253906,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.3848166466,
      fwhm_stdev:0.3659999967,
      description:'SWIR Band 416'
     },
     {
      name:'B417',
      center_wavelength_mean:2465.8723144531,
      center_wavelength_stdev:0.8069999814,
      fwhm_mean:6.3891839981,
      fwhm_stdev:0.3670000136,
      description:'SWIR Band 417'
     },
     {
      name:'B418',
      center_wavelength_mean:2470.8811035156,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.3935670853,
      fwhm_stdev:0.3680000007,
      description:'SWIR Band 418'
     },
     {
      name:'B419',
      center_wavelength_mean:2475.8898925781,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.3979597092,
      fwhm_stdev:0.3689999878,
      description:'SWIR Band 419'
     },
     {
      name:'B420',
      center_wavelength_mean:2480.8986816406,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.4023666382,
      fwhm_stdev:0.3700000048,
      description:'SWIR Band 420'
     },
     {
      name:'B421',
      center_wavelength_mean:2485.9069824219,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.4067845345,
      fwhm_stdev:0.3720000088,
      description:'SWIR Band 421'
     },
     {
      name:'B422',
      center_wavelength_mean:2490.9157714844,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.4112167358,
      fwhm_stdev:0.3729999959,
      description:'SWIR Band 422'
     },
     {
      name:'B423',
      center_wavelength_mean:2495.9243164062,
      center_wavelength_stdev:0.8059999943,
      fwhm_mean:6.4156637192,
      fwhm_stdev:0.3740000129,
      description:'SWIR Band 423'
     },
     {
      name:'B424',
      center_wavelength_mean:2500.9331054688,
      center_wavelength_stdev:0.8050000072,
      fwhm_mean:6.4201197624,
      fwhm_stdev:0.375,
      description:'SWIR Band 424'
     },
     {
      name:'B425',
      center_wavelength_mean:2505.9416503906,
      center_wavelength_stdev:0.8050000072,
      fwhm_mean:6.4245905876,
      fwhm_stdev:0.3770000041,
      description:'SWIR Band 425'
     },
     {
      name:'B426',
      center_wavelength_mean:2510.9506835938,
      center_wavelength_stdev:0.8050000072,
      fwhm_mean:6.4290728569,
      fwhm_stdev:0.3779999912,
      description:'SWIR Band 426'
     },
     {
      name:'B427',
      scale:1.0,
      units:'degrees',
      description:'Aerosol Optical Depth'
     },
     {
      name:'B428',
      scale:1.0,
      units:'degrees',
      description:'Aspect used as input to ATCOR'
     },
     {
      name:'B429',
      scale:1.0,
      units: 'Flag: 1=shadow; 0=no shadow',
      description:'Cast Shadow mask used as input to ATCOR'
     },
     {
      name:'B430',
      scale:1.0,
      'gee:classes': [
              {
                value: 0,
                color: '0a0a0a',
                description: 'geocoded background',
              },
              {
                value: 1,
                color: '135e9c',
                description: 'water',
              },
              {
                value: 2,
                color: '063d08',
                description: 'DDV reference',
              },
             {
                value: 3,
                color: 'e1e3e1',
                description: 'non-reference',
              },
             {
                value: 4,
                color: '383734',
                description: 'topographic shadow',
              },
      ],
    description:'Dark Dense Vegetation Classification'
     },
     {
      name:'B431',
      scale: 1.0,
      description:'Haze Cloud Water Map generate by ATCOR',
      'gee:classes': [
          {
            value: 0,
            color: '000000',
            description: 'geocoded background',
          },
          {
            value: 1,
            color: '474747',
            description: 'shadow',
          },
          {
            value: 2,
            color: '9db8d1',
            description: 'thin cirrus (water)',
          },
          {
            value: 3,
            color: '5a6978',
            description: 'medium cirrus (water)',
          },
          {
            value: 4,
            color: '3d4a57',
            description: 'thick cirrus (water)',
          },
          {
            value: 5,
            color: '5d7554',
            description: 'land (clear)',
          },
          {
            value: 6,
            color: '454d42',
            description: 'saturated',
          },
          {
            value: 7,
            color: 'f7f7f7',
            description: 'snow/ice',
          },
          {
            value: 8,
            color: 'd5e3d3',
            description: 'thin cirrus (land)',
          },
          {
            value: 9,
            color: '9da89b',
            description: 'medium cirrus (land)',
          },
          {
            value: 10,
            color: '5a6359',
            description: 'thick cirrus (land)',
          },
          {
            value: 11,
            color: 'ced4cd',
            description: 'thin haze (land)',
          },
          {
            value: 12,
            color: '8c918c',
            description: 'medium haze (land)',
          },
          {
            value: 13,
            color: 'ceddde',
            description: 'thin haze/glint (water)',
          },
          {
            value: 14,
            color: '849596',
            description: 'med. haze/glint (water)',
          },
          {
            value: 15,
            color: '98a39b',
            description: 'cloud (land)',
          },
          {
            value: 16,
            color: '9899a3',
            description: 'cloud (water)',
          },
          {
            value: 17,
            color: '135e9c',
            description: 'water',
          },          
          {
            value: 18,
            color: 'e1e8ed',
            description: 'cirrus cloud',
          },
          {
            value: 19,
            color: '9ea7ad',
            description: 'cirrus cloud (thick)',
          },
          {
            value: 20,
            color: 'dffa11',
            description: 'bright',
          },
          {
            value: 21,
            color: '383734',
            description: 'topographic shadow',
          },
          {
            value: 22,
            color: '4f4f4e',
            description: 'cloud (building) shadow',
          },
      ]
     },
     {
      name:'B432',
      scale:1.0,
      units:'degrees',
      description:'Illumination Factor used as input to ATCOR'
     },
     {
      name:'B433',
      scale:1.0,
      units:'meters',
      description:'Path length between sensor and surface'
     },
     {
      name:'B434',
      scale:1.0,
      units:'percent',
      description:'Sky View Factor used as input to ATCOR'
     },
     {
      name:'B435',
      scale:1.0,
      units:'degrees',
      description:'Slope used as input to ATCOR'
     },
     {
      name:'B436',
      scale:1.0,
      units:'meters',
      description:'Smooth Surface Elevation used as input to ATCOR'
     },
     {
      name:'B437',
      scale:1.0,
      units:'kilometers',
      description:'Visibility Index Map - sea level values of visibility index / total optical thickeness'
     },
     {
      name:'B438',
      scale:1.0,
      units:'centimeters',
      description:'Water Vapor Column - (cm)*1000 ground-to-space used in ATCOR'
     },
     {
      name:'B439',
      scale:1.0,
      units:'degrees',
      description:'to-sensor Azimuth Angle'
     },
     {
      name:'B440',
      scale:1.0,
      units:'degrees',
      description:'to-sensor Zenith Angle'
     },
     {
      name:'B441',
      scale:1.0,
        'gee:classes': [
            {
            value: 0,
            color: '239e2f',
            description: 'mostly clear: <10% cloud cover',
            },
            {
            value: 1,
            color: 'f5ee1d',
            description: 'partly cloudy: 10-50% cloud cover',
            },
            {
            value: 2,
            color: 'c40a0a',
            description: 'mostly cloudy: >50% cloud cover',
            },
      ],
      description:'Weather Quality Indicator - estimated percentage of overhead cloud cover during acquisition'
     },
     {
      name:'B442',
      scale:1.0,
      units:'date yyyy-mm-dd',
      description:'Acquisition Date, YYYYMMDD'
     }
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 39.8283,
          lon: -98.5795,
          zoom: 9, 
        },
        image_visualization: {
          band_vis: {
            min: [
              1000.0,
            ],
            max: [
              14000.0,
            ],
            gamma: [
              2.5,
            ],
            bands: [
              'B053',
              'B035',
              'B019',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'See [NEON citation guidelines](https://www.neonscience.org/data-samples/guidelines-policies/citing)',
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    All data collected by NEON and provided as data products, with the exception
    of data related to rare, threatened, or endangered (RTE) species, are
    released to the public domain under [Creative Commons CC0 1.0 "No Rights
    Reserved"](https://creativecommons.org/publicdomain/zero/1.0/). No
    copyright has been applied to NEON data; any person may copy, modify, or
    distribute the data, for commercial or non-commercial purposes, without
    asking for permission. NEON data may still be subject to other laws or
    rights such as for privacy, and NEON makes no warranties about the data and
    disclaims all liability. When using or citing NEON data, no implication
    should be made about endorsement by NEON. In most countries, data and facts
    are not copyrightable.  By putting NEON data into the public domain, we
    encourage broad use, particularly in scientific analyses and data
    aggregations. However, please be aware of the following scholarly norms:
    NEON data should be used in a way that is mindful of the limitations of the
    data, using the documentation associated with the data packages as a guide. 
    Please refer to [NEON Data Guidelines and Policies](https://www.neonscience.org/data-samples/guidelines-policies)
    for detailed information on how to properly use and cite NEON data, as well as
    best practices for publishing research that uses NEON data.
  |||,
}