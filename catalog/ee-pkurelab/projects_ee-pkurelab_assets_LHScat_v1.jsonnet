local id = 'projects/ee-pkurelab/assets/LHScat_v1';
local subdir = 'ee-pkurelab';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local units = import 'units.libsonnet';

{
  'gee:skip_indexing': true,
  
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'LHScat dataset',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The LHScat dataset is the first long-term (since 1992), high-resolution (∼8.9 km) 
    monthly satellite radar backscatter dataset over global land areas. It integrated 
    signals from the European Remote Sensing satellite (ERS; 1992–2001; C-band; 5.3 GHz),
    Quick Scatterometer (QSCAT, 1999–2009; Ku-band; 13.4 GHz), and the Advanced 
    SCATterometer (ASCAT; since 2007; C-band; 5.255 GHz). The 6-year data gap between 
    C-band ERS and ASCAT was filled by modelling a substitute C-band signal during 1999–2009 
    from Ku-band QSCAT signals and climatic information. The quality of the merged radar 
    signal was assessed by computing the Pearson r and root mean square error (RMSE) 
    between the C-band and the corrected Ku-band signals in the overlapping years (1999–2001 
    and 2007–2009). The components of LHScat dataset are as follows:
    Monthly radar signals: The dataset is available from April 1992 to August 2021, with a spatial resolution of 8.9 km. 
    To facilitate storage, the radar signals were scaled by a factor of 100 and converted to unsigned Int16.
    Pearsonr: Pearsonr between the monthly C-band and corrected Ku-band signals in the overlapping years.
    RMSE: RMSE between the monthly C-band and corrected Ku-band signals in the overlapping years.
    Satellite: The satellite source of the signal. The values are as follows:1. ERS; 2. ERS and QSCAT; 3. QSCAT; 4. ASCAT and QSCAT; 5. ASCAT .
    Since the signals were merged from several sensors, the Pearsonr and RMSE values can be used to select pixels with high data merging quality. 
    For more detailed information, please refer to the paper describing LHScat dataset(https://essd.copernicus.org/articles/15/1577/2023/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'radar',
    'C-bands',
    'Ku-band',
    'QSCAT',
    'ASCAT',
    'ERS',
  ],
  providers: [
    ee.producer_provider('pkurelab', 'https://pkurelab.github.io'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-04-01T00:00:00Z', '2021-10-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'Monthly radar signals',
        description: 'The dataset is available from April 1992 to August 2021, with a spatial resolution of 8.9 km. To facilitate storage, the radar signals were scaled by a factor of 100 and converted to unsigned Int16.',
        type: ee_const.var_type.int,
      }，
      {
        name: 'Pearsonr',
        description: 'Pearsonr between the monthly C-band and corrected Ku-band signals in the overlapping years.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RMSE',
        description: 'RMSE between the monthly C-band and corrected Ku-band signals in the overlapping years.',
        type: ee_const.var_type.double,
      }
    ]
  },
  gsd: [
    8900,
  ],
  
  platform: [
    'ERS',
    'MetOp',
    'QSCAT'
  ],

  instruments: [
    'C-band scatterometer',
    'SeaWinds'
  ],

  'sci:citation': 'Tao, S., Ao, Z., Wigneron, J.-P., Saatchi, S., Ciais, P., Chave, J., Le Toan, T., Frison, P.-L., Hu, X., Chen, C., Fan, L., Wang, M., Zhu, J., Zhao, X., Li, X., Liu, X., Su, Y., Hu, T., Guo, Q., Wang, Z., Tang, Z., Liu, Y. Y., and Fang, J.: A global long-term, high-resolution satellite radar backscatter data record (1992–2022+): merging C-band ERS/ASCAT and Ku-band QSCAT, Earth Syst. Sci. Data, 15, 1577–1596, https://doi.org/10.5194/essd-15-1577-2023, 2023.
                  Tao, S., Chave, J., Frison, P.-L., Le Toan, T., Ciais, P., Fang, J., Wigneron, J.-P., Santoro, M., Yang, H., Li, X., Labrière, N., and Saatchi, S.: Increasing and widespread vulnerability of intact tropical rainforests to repeated droughts, Proc. Natl. Acad. Sci. USA, 119, e2116626119, https://doi.org/10.1073/pnas.2116626119, 2022.'
  
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
  The LHScat dataset is publicly released by the PKURE Lab at Peking University for non-commercial use. 
  All rights to the dataset are held by the PKURE Lab. For more details, please refer to the paper describing the LHScat dataset: 
  https://essd.copernicus.org/articles/15/1577/2023/.
  |||,
}