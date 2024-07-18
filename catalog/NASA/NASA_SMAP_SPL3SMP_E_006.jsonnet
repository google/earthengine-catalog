// TODO(simonf): mark this collection as deprecating the V5 one
// once we confirm all assets are ingested.
local id = 'NASA/SMAP/SPL3SMP_E/006';
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
    ee_const.ext_ver
  ],
  id: id,
  title: 'SPL3SMP_E.006 SMAP L3 Radiometer Global Daily 9 km Soil Moisture',

  version: '6',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Data prior from 2023-12-04 are available in the older
    [NASA/SMAP/SPL3SMP_E/005](NASA_SMAP_SPL3SMP_E_005) collection.
    They will eventually be reprocessed and added to this collection.

    This Level-3 (L3) soil moisture product provides a daily composite of global
    land surface conditions retrieved by the Soil Moisture Active Passive (SMAP)
    L-Band radiometer. The daily data here were collected from the descending
    (local solar time of 6 am) and ascending (local solar time of 6 pm) passes.

    The SMAP mission is an orbiting observatory that measures the amount of
    water in the surface soil everywhere on Earth. A detailed description can be
    found in the
    [SMAP Handbook](https://smap.jpl.nasa.gov/system/internal_resources/details/original/178_SMAP_Handbook_FINAL_1_JULY_2014_Web.pdf).
    It was launched in January 2015 and started operation in April 2015. The
    radar instrument, ceasing operation in early 2015 due to failure of radar
    power supply, collected close to 3 months of science data. The prime mission
    phase of three years was completed in 2018, and since then SMAP has been in
    extended operation phase.

    SMAP measures soil moisture every 2-3 days. This permits changes around
    the world to be observed over time scales ranging from major storms to
    repeated measurements of changes over the seasons.

    Everywhere on Earth not covered with water or not frozen, SMAP measures how
    much water is in the top layer of soil. It also distinguishes between ground
    that is frozen or thawed. Where the ground is not frozen, SMAP measures the
    amount of water found between the minerals, rocky material, and organic
    particles found in soil everywhere in the world (SMAP measures liquid water
    in the top layer of ground but is not able to measure the ice.)

    SPL3SMP_E data are transformed to
    [geographic coordinates using GDAL libraries](https://github.com/google/earthengine-catalog/blob/main/pipelines/smap_convert_l3.py)
    before the data are ingested into Google Earth Engine.

    See the
    [SMAP L3 Soil Moisture User Guide](https://nsidc.org/sites/default/files/spl3smp_e-v005-userguide.pdf)
    and references therein for additional documentation and algorithm details.

    See
    [basic](https://developers.google.com/earth-engine/tutorials/community/smap-soil-moisture)
    and
    [advanced](https://developers.google.com/earth-engine/tutorials/community/anomalies-analysis-smo-and-pre)
    tutorials to learn how to use SMAP data in Earth Engine.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'drought',
    'nasa',
    'smap',
    'soil_moisture',
    'surface',
    'weather'
  ],
  'gee:provider_ids': [
    'C2776463943-NSIDC_ECS',
  ],
  providers: [
    ee.producer_provider('Google and NSIDC', 'https://nsidc.org/data/spl3smp_e/versions/6'),
    ee.host_provider(self_ee_catalog_url),
  ],
  // TODO(simonf): this should eventually go back to 2015-03-31T12:00:00Z
  // once the older data are reprocessed.
  // Check the dates at https://n5eil01u.ecs.nsidc.org/SMAP/SPL3SMP_E.006/
  extent: ee.extent(-180.0, -84, 180.0, 84, '2023-12-04T12:00:00Z', null),
  summaries: {
    gsd: [
      9000.0,
    ],
    'eo:bands': [
      {
        name: 'soil_moisture_am',
        description: |||
          Retrieved soil moisture estimate from the
          disaggregated/downscaled vertical polarization brightness temperature
          at 9-km grid cell; AM overpass
        |||,
        'gee:units': units.volume_fraction,
      },
      {
        name: 'tb_h_corrected_am',
        description: |||
          Weighted average of horizontally polarized brightness
          temperatures. This value represents the corrected land brightness
          temperature if the water fraction is lower than 0.9
          (otherwise no correction is applied) or represents the corrected water
          brightness temperature if the water fraction is greater than 0.1
          (otherwise no correction is applied); AM overpass
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'tb_v_corrected_am',
        description: |||
          Weighted average of vertically polarized brightness
          temperatures. This value represents the corrected land brightness
          temperature if the water fraction is lower than 0.9
          (otherwise no correction is applied) or represents the corrected water
          brightness temperature if the water fraction is greater than 0.1
          (otherwise no correction is applied); AM overpass
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'vegetation_water_content_am',
        description: |||
          Vegetation water content at 9-km spatial scale. This
          parameter is used as input ancillary data parameter to the SPL2SMAP
          processing software when the baseline algorithm is used. The valid
          minimum and maximum below are subject to further analysis. AM overpass
        |||,
        'gee:units': units.area_density,
      },
      {
        name: 'retrieval_qual_flag_am',
        description: |||
          0 = Pass: Soil moisture  with acceptable quality;
          1 = Fail: Soil moisture does  with unacceptable quality; AM overpass
        |||,
      },
      {
        name: 'tb_qual_flag_h_am',
        description: |||
          0= brightness temperatures with unacceptable quality;
          1= brightness temperatures with acceptable quality; AM overpass
        |||,
      },
      {
        name: 'tb_qual_flag_v_am',
        description: |||
          0= brightness temperatures with unacceptable quality;
          1= brightness temperatures with acceptable quality; AM overpass
        |||,
      },
      {
        name: 'soil_moisture_pm',
        description: |||
          Retrieved soil moisture estimate from the
          disaggregated/downscaled vertical polarization brightness temperature
          at 9-km grid cell; PM overpass
        |||,
        'gee:units': units.volume_fraction,
      },
      {
        name: 'tb_h_corrected_pm',
        description: |||
          Weighted average of horizontally polarized brightness
          temperatures. This value represents the corrected land brightness
          temperature if the water fraction is lower than 0.9 (otherwise no
          correction is applied) or represents the corrected water brightness
          temperature if the water fraction is greater than 0.1 (otherwise no
          correction is applied); PM overpass
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'tb_v_corrected_pm',
        description: |||
          Weighted average of vertically polarized brightness
          temperatures. This value represents the corrected land brightness
          temperature if the water fraction is lower than 0.9 (otherwise no
          correction is applied) or represents the corrected water brightness
          temperature if the water fraction is greater than 0.1 (otherwise no
          correction is applied); PM overpass
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'vegetation_water_content_pm',
        description: |||
          Vegetation water content at 9-km spatial scale. This
          parameter is used as input ancillary data parameter to the SPL2SMAP
          processing software when the baseline algorithm is used. The valid
          minimum and maximum below are subject to further analysis. PM overpass
        |||,
        'gee:units': units.area_density,
      },
      {
        name: 'retrieval_qual_flag_pm',
        description: |||
          0 = Pass: Soil moisture  with acceptable quality;
          1 = Fail: Soil moisture does  with unacceptable quality;  PM overpass
        |||,
      },
      {
        name: 'tb_qual_flag_h_pm',
        description: |||
          0= brightness temperatures with unacceptable quality;
          1= brightness temperatures with acceptable quality; PM overpass
        |||,
      },
      {
        name: 'tb_qual_flag_v_pm',
        description: |||
          0= brightness temperatures with unacceptable quality;
          1= brightness temperatures with acceptable quality; PM overpass
        |||,
      },
      {
        name: 'soil_moisture_am_anomaly',
        description: |||
          Experimental. Difference of the 30-day average of 'soil_moisture_am',
          centered on asset date, relative to the same 30-day period averaged
          across years from 2015 to present, excluding asset year.

          See
          [this script](https://github.com/google/earthengine-community/blob/master/datasets/smap_anomaly_l3.py)
          for anomaly computations.
        |||
      },
      {
        name: 'soil_moisture_pm_anomaly',
        description: |||
          Experimental. Difference of the 30-day average of 'soil_moisture_pm',
          centered on asset date, relative to the same 30-day period averaged
          across years from 2015 to present, excluding asset year.

          See
          [this script](https://github.com/google/earthengine-community/blob/master/datasets/smap_anomaly_l3.py)
          for anomaly computations.
        |||
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil Moisture',
        lookat: {
          lat: -6.746,
          lon: 46.529,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.5,
            ],
            palette: [
              '0300ff',
              '418504',
              'efff07',
              'efff07',
              'ff0303',
            ],
            bands: [
              'soil_moisture_am',
            ],
          },
        },
      },
    ],
    tb_h_corrected_am: {
      minimum: 0,
      maximum: 330,
      'gee:estimated_range': false,
    },
    tb_v_corrected_am: {
      minimum: 0,
      maximum: 330,
      'gee:estimated_range': false,
    },
    vegetation_water_content_am: {
      minimum: 0.0,
      maximum: 30.0,
      'gee:estimated_range': false,
    },
    retrieval_qual_flag_am: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    },
    tb_qual_flag_h_am: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    },
    tb_qual_flag_v_am: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    },
    tb_h_corrected_pm: {
      minimum: 0,
      maximum: 330,
      'gee:estimated_range': false,
    },
    tb_v_corrected_pm: {
      minimum: 0,
      maximum: 330,
      'gee:estimated_range': false,
    },
    vegetation_water_content_pm: {
      minimum: 0.0,
      maximum: 30.0,
      'gee:estimated_range': false,
    },
    retrieval_qual_flag_pm: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    },
    tb_qual_flag_h_pm: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    },
    tb_qual_flag_v_pm: {
      minimum: 0,
      maximum: 65536,
      'gee:estimated_range': false,
    }

  },
  'sci:citation':|||
      **O'Neill, P. E., S. Chan, E. G. Njoku, T. Jackson, R. Bindlish,
      J. Chaubell, and A. Colliander. 2021. SMAP Enhanced L3 Radiometer Global
      and Polar Grid Daily 9 km EASE-Grid Soil Moisture, Version 5.
      [Indicate subset used]. Boulder, Colorado USA. NASA National Snow and Ice
      Data Center Distributed Active Archive Center.
      [doi:10.5067/4DQ54OUIJ9DL](https://doi.org/10.5067/4DQ54OUIJ9DL)
  |||,
  'sci:publications': [
    {
      citation: |||
        Entekhabi et al., 2014
        D. Entekhabi, S. Yueh, P. O'Neill, K. Kellogg et al. SMAP Handbook -
        Soil Moisture Active Passive: Mapping Soil Moisture and Freeze/thaw From
        Space. SMAP Project, Jet Propulsion Laboratory, Pasadena, CA (2014)
        [SMAP Handbook](https://smap.jpl.nasa.gov/system/internal_resources/details/original/178_SMAP_Handbook_FINAL_1_JULY_2014_Web.pdf)
      |||
    },
    {
      citation: |||
        Chan, S. K., R. Bindlish, P. E. O'Neill, E. Njoku, T. Jackson,
        A. Colliander, F. Chen, M. Burgin, S. Dunbar, J. Piepmeier, S. Yueh,
        D. Entekhabi, M. H. Cosh, T. Caldwell, J. Walker, X. Wu, A. Berg,
        T. Rowlandson, A. Pacheco, H. McNairn, M. Thibeault,
        J. Martinez-Fernandez, A. Gonzalez-Zamora, M. Seyfried, D. Bosch,
        P. Starks, D. Goodrich, J. Prueger, M. Palecki, E. E. Small, M. Zreda,
        J.-C. Calvet, W. T. Crow, and Y. Kerr. 2016. "Assessment of the SMAP
        Passive Soil Moisture Product" IEEE Transactions on Geoscience and
        Remote Sensing, 54 (8): 4994-5007
        [10.1109/tgrs.2016.2561938](https://doi.org/10.1109/tgrs.2016.2561938)
      |||,
      doi: '10.1109/tgrs.2016.2561938',
    },
    {
      citation: |||
        Chan, S., R. Bindlish, P. O'Neill, T. Jackson, E. Njoku, S. Dunbar,
        J. Chaubell, J. Piepmeier, S. Yueh, D. Entekhabi, A. Colliander,
        F. Chen, M. Cosh, T. Caldwell, J. Walker, A. Berg, H. McNairn,
        M. Thibeault, J. Mart&iacute;nez-Fern&aacute;ndez, F. Uldall,
        M. Seyfried, D. Bosch, P. Starks, C. Holifield Collins, J. Prueger,
        R. van der Velde, J. Asanuma, M. Palecki, E. Small, M. Zreda, J. Calvet,
        W. Crow, and Y. Kerr. 2018.  "Development and assessment of the SMAP
        enhanced passive soil moisture product." Remote Sensing of Environment,
        204: 931-941
        [10.1016/j.rse.2017.08.025](https://doi.org/10.1016/j.rse.2017.08.025)
      |||,
      doi: '10.1016/j.rse.2017.08.025',
    },
    {
      citation: |||
        Chaubell, M. J., J. Asanuma, A. A. Berg, D. D. Bosch, T. Caldwell,
        M. H. Cosh, C. H. Collins, J. Martinez-Fernandez, M. Seyfried,
        P. J. Starks, Z. Su, S. H. Yueh, M. Thibeault, J. Walker, R. S. Dunbar,
        A. Colliander, F. Chen, S. K. Chan, D. Entekhabi, R. Bindlish, and
        P. E. O'Neill. 2020. "Improved SMAP Dual-Channel Algorithm for the
        Retrieval of Soil Moisture." IEEE Transactions on Geoscience and Remote
        Sensing, 1-12
        [10.1109/tgrs.2019.2959239](https://doi.org/10.1109/tgrs.2019.2959239)
      |||,
      doi: '10.1109/tgrs.2019.2959239'
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
