local id = 'projects/ee-pkurelab/assets/LHScat';
local subdir = 'ee-pkurelab';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local units = import 'units.libsonnet';

{
  
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'LHScat',
  'gee:type': ee_const.gee_type.image_collection,
  description:
  |||
    The LHScat dataset is the first long-term (since 1992), high-resolution (∼8.9 km) 
    monthly satellite radar backscatter dataset over global land areas. It integrated 
    signals from the European Remote Sensing satellite (ERS; 1992–2001; C-band; 5.3 GHz),
    Quick Scatterometer (QSCAT, 1999–2009; Ku-band; 13.4 GHz), and the Advanced 
    SCATterometer (ASCAT; since 2007; C-band; 5.255 GHz). The 6-year data gap between 
    C-band ERS and ASCAT was filled by modelling a substitute C-band signal during 1999–2009 
    from Ku-band QSCAT signals and climatic information. The quality of the merged radar 
    signal was assessed by computing the Pearson correlation coefficient (Pearsonr) and root mean square error (RMSE) 
    between the C-band and the corrected Ku-band signals in the overlapping years (1999–2001 and 2007–2009). 
    To facilitate storage, the radar signals were scaled by a factor of 100 and converted to unsigned Int16.
    For more detailed information, please refer to the paper describing LHScat dataset(https://essd.copernicus.org/articles/15/1577/2023/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'radar',
    'c-bands',
    'ku-band',
    'qscat',
    'ascat',
    'ers',
  ],
  providers: [
    ee.producer_provider('PKURELAB', 'https://pkurelab.github.io'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-04-01T00:00:00Z', '2021-08-31T00:00:00Z'),
  summaries: {
      gsd: [
      8900,
    ],
    'gee:schema': [
      {
        name: 'Satellite',
        description: 'The satellite source of the signal. The values are as follows:1. ERS; 2. ERS and QSCAT; 3. QSCAT; 4. ASCAT and QSCAT; 5. ASCAT ',
        type: ee_const.var_type.int,
      }
    ],
    'eo:bands': [
      {
        name: 'radar_singles',
        description: 'The dataset is available from April 1992 to August 2021, with a spatial resolution of 8.9 km. To facilitate storage, the radar signals were scaled by a factor of 100 and converted to unsigned Int16.',
        'gee:units': units.meter,
      }
    ],
    'gee:visualizations': [{
      display_name: 'radar_singles',
      lookat: {lon: 100.0, lat: 53.0, zoom: 4},
      image_visualization: {
        band_vis: {
          min: [-2000],
          max: [500],
          palette: ['green', 'yellow', 'red', 'firebrick'],
          bands: ['radar_singles'],
        },
      },
    }],
  },


  'sci:citation': 'Tao, S., Ao, Z., Wigneron, J.-P., Saatchi, S., Ciais, P., Chave, J., Le Toan, T., Frison, P.-L., Hu, X., Chen, C., Fan, L., Wang, M., Zhu, J., Zhao, X., Li, X., Liu, X., Su, Y., Hu, T., Guo, Q., Wang, Z., Tang, Z., Liu, Y. Y., and Fang, J.: A global long-term, high-resolution satellite radar backscatter data record (1992–2022+): merging C-band ERS/ASCAT and Ku-band QSCAT, Earth Syst. Sci. Data, 15, 1577–1596, https://doi.org/10.5194/essd-15-1577-2023, 2023.
                  Tao, S., Chave, J., Frison, P.-L., Le Toan, T., Ciais, P., Fang, J., Wigneron, J.-P., Santoro, M., Yang, H., Li, X., Labrière, N., and Saatchi, S.: Increasing and widespread vulnerability of intact tropical rainforests to repeated droughts, Proc. Natl. Acad. Sci. USA, 119, e2116626119, https://doi.org/10.1073/pnas.2116626119, 2022.',
  
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}