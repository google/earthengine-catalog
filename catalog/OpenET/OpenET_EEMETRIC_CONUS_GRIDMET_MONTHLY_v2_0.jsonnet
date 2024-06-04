local id = 'OpenET/EEMETRIC/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';
local version = '2.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'OpenET CONUS eeMETRIC Monthly Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Google Earth Engine implementation of the Mapping Evapotranspiration
    at high Resolution with Internalized Calibration model (eeMETRIC)

    eeMETRIC applies the advanced METRIC algorithms and process of Allen
    et al. (2007; 2015) and Allen et al. (2013b), where a singular
    relationship between the near surface air temperature difference (dT)
    and delapsed land surface temperature (TsDEM) is used to estimate sensible
    heat flux (H) and is applied to each Landsat scene. Automated selection of
    the hot and cold pixels for an image generally follows a statistical
    isolation procedure described by Allen et al. (2013a) and ReVelle, Kilic
    and Allen (2019a,b). The calibration of H in eeMETRIC utilizes alfalfa
    reference ET calculated from the NLDAS gridded weather dataset using a
    fixed 15% reduction in computed reference ET to account for known biases
    in the gridded data set. The fixed reduction does not impact the
    calibration accuracy of eeMETRIC and mostly reduces impacts of boundary
    layer buoyancy correction.

    The identification of candidates for pools of hot and cold pixels has
    evolved in the eeMETRIC implementation of METRIC. The new automated
    calibration process incorporates the combination of methodologies and
    approaches that stem from two development branches of EEFlux (Allen
    et al., 2015). The first branch focused on improving the automated pixel
    selection process using standard lapse rates for land surface temperature
    (LST) without any further spatial delapsing (ReVelle et al., 2019b). The
    second branch incorporated a secondary spatial delapsing of LST as well as
    changes to the pixel selection process (ReVelle et al., 2019a). The final,
    combined approach is described by Kilic et al. (2021).

    eeMETRIC employs the aerodynamic-related functions in complex terrain
    (mountains) developed by Allen et al. (2013b) to improve estimates for
    aerodynamic roughness, wind speed and boundary layer stability as related
    to estimated terrain roughness, position on a slope and wind direction.
    These functions tend to increase estimates for H (and reduce ET) on
    windward slopes and may reduce H (and increase ET) on leeward slopes.
    Other METRIC functions employed in eeMETRIC that have been added since
    the descriptions provided in Allen et al. (2007 and 2011) include
    reduction in soil heat flux (G) in the presence of organic mulch on the
    ground surface, use of an excess aerodynamic resistance for shrublands,
    use of the Perrier function for trees identified as forest (Allen et
    al., 2018; Santos et al., 2012) and aerodynamic estimation of evaporation
    from open water rather than using energy balance (Jensen and Allen 2016;
    Allen et al., 2018). In 2022, the Perrier function was applied to tree
    (orchard) crops and a 3-source partitioning of bulk surface temperature
    into canopy temperature, shaded soil temperature and sunlit soil
    temperature was applied to both orchards and vineyards. These latter
    applications were made where orchards and vineyards are identified by
    CDL or, in California, by a state-sponsored land use system. These
    functions and other enhancements to the original METRIC model are described
    in the most current METRIC users manual (Allen et al., 2018). eeMETRIC uses
    the atmospherically corrected surface reflectance and LST from Landsat
    Collection 2 Level 2, with fallback to Collection 2 Level 1 when needed for
    near real-time estimates.

    [Additional information](https://openetdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'openet',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '2013-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'build_date',
        description: 'Date assets were built',
        type: ee_const.var_type.string,
      },
      {
        name: 'cloud_cover_max',
        description: 'Maximum CLOUD_COVER_LAND percent value for Landsat images included in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'collections',
        description: 'List of Landsat collections for Landsat images included in the interpolation',
        type: ee_const.var_type.string,
      },
      {
        name: 'core_version',
        description: 'OpenET core library version',
        type: ee_const.var_type.string,
      },
      {
        name: 'end_date',
        description: 'End date of month',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_band',
        description: 'Band in et_reference_source that contains the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_resample',
        description: 'Spatial interpolation mode to resample daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_source',
        description: 'Collection ID for the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'interp_days',
        description: 'Maximum number of days before and after each image date to include in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'interp_method',
        description: 'Method used to interpolate between Landsat model estimates',
        type: ee_const.var_type.string,
      },
      {
        name: 'interp_source_count',
        description: 'Number of available images in the interpolation source image collection for the target month',
        type: ee_const.var_type.double,
      },
      {
        name: 'mgrs_tile',
        description: 'MGRS grid zone ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_name',
        description: 'OpenET model name',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_version',
        description: 'OpenET model version',
        type: ee_const.var_type.string,
      },
      {
        name: 'scale_factor_count',
        description: 'Scaling factor that should be applied to the count band',
        type: ee_const.var_type.double,
      },
      {
        name: 'scale_factor_et',
        description: 'Scaling factor that should be applied to the et band',
        type: ee_const.var_type.double,
      },
      {
        name: 'start_date',
        description: 'Start date of month',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: 'eeMETRIC ET value',
        'gee:units': units.millimeter,
      },
      {
        name: 'count',
        description: 'Number of cloud free values',
        'gee:units': units.count,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET eeMETRIC Monthly ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1400],
            palette: [
              '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b',
              '9fcb51', '80c256', '61b95c', '42b062', '45b677', '49bc8d',
              '4dc2a2', '51c8b8', '55cece', '4db4ba', '459aa7', '3d8094',
              '356681', '2d4c6e',
            ],
            bands: ['et'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.13031/irrig.2020-038',
  'sci:citation': |||
    Kilic, A., Allen, R.G., Blankenau, P., ReVelle, P., Ozturk, D. and
    Huntington, J., 2021. Global production and free access to Landsat-scale
    Evapotranspiration with EEFlux and eeMETRIC. In 6th Decennial National
    Irrigation Symposium, 6-8, December 2021, San Diego, California
    (p. 1). American Society of Agricultural and Biological Engineers.
    [doi:10.13031/irrig.2020-038](https://doi.org/10.13031/irrig.2020-038)
  |||,
  'sci:publications': [
    {
      citation: |||
        Allen, R.G., Tasumi, M., Morse, A. and Trezza, R., 2005. A Landsat-based
        energy balance and evapotranspiration model in Western US water rights
        regulation and planning. Irrigation and Drainage systems, 19,
        pp.251-268.
        [doi:10.1007/s10795-005-5187-z](https://doi.org/10.1007/s10795-005-5187-z)
      |||,
    },
    {
      citation: |||
        Allen, R.G., Tasumi, M. and Trezza, R., 2007. Satellite-based energy
        balance for mapping evapotranspiration with internalized calibration
        (METRIC)—Model. Journal of irrigation and drainage engineering, 133(4),
        pp.380-394.
        [doi:10.1029/2006JD007506](https://doi.org/10.1029/2006JD007506)
      |||,
    },
    {
      citation: |||
        Allen, R., Irmak, A., Trezza, R., Hendrickx, J.M., Bastiaanssen, W.  and
        Kjaersgaard, J., 2011. Satellite-based ET estimation in agriculture
        using SEBAL and METRIC. Hydrological Processes, 25(26), pp.4011-4027.
        [doi:10.1002/hyp.8408](https://doi.org/10.1002/hyp.8408)
      |||,
    },
    {
      citation: |||
        Allen, R.G., Burnett, B., Kramber, W., Huntington, J., Kjaersgaard, J.,
        Kilic, A., Kelly, C. and Trezza, R., 2013a. Automated calibration of the
        metric-landsat evapotranspiration process. JAWRA Journal of the American
        Water Resources Association, 49(3), pp.563-576.
        [doi:10.1111/jawr.12056](https://doi.org/10.1111/jawr.12056)
      |||,
    },
    {
      citation: |||
        Allen, R.G., Trezza, R., Kilic, A., Tasumi, M. and Li, H., 2013b.
        Sensitivity of Landsat-scale energy balance to aerodynamic variability
        in mountains and complex terrain. JAWRA Journal of the American Water
        Resources Association, 49(3), pp.592-604.
        [doi:10.1111/jawr.12055](https://doi.org/10.1111/jawr.12055)
      |||,
    },
    {
      citation: |||
        Allen, R.G., Morton, C., Kamble, B., Kilic, A., Huntington, J., Thau,
        D., Gorelick, N., Erickson, T., Moore, R., Trezza, R. and Ratcliffe, I.,
        2015. EEFlux: A Landsat-based evapotranspiration mapping tool on the
        Google Earth Engine. In 2015 ASABE/IA Irrigation Symposium: Emerging
        Technologies for Sustainable Irrigation-A Tribute to the Career of Terry
        Howell, Sr. Conference Proceedings (pp. 1-11). American Society of
        Agricultural and Biological Engineers.
        [doi:10.13031/irrig.20152143511](https://doi.org/10.13031/irrig.20152143511)
      |||,
    },
    {
      citation: |||
        Jensen, M.E. and R.G. Allen (ed.). 2016. Evaporation,
        evapotranspiration, and irrigation water requirements. Manuals of
        Practice no. 70 (2nd edition). Task Committee on Revision of Manual 70,
        2016, April. American Society of Civil Engineers. Reston, VA.  744 p.
        [doi:10.1061/9780784414057](https://doi.org/10.1061/9780784414057)
      |||,
    },
    {
      citation: |||
        Kilic, A., Allen, R., Trezza, R., Ratcliffe, I., Kamble, B., Robison,
        C. and Ozturk, D., 2016. Sensitivity of evapotranspiration retrievals
        from the METRIC processing algorithm to improved radiometric
        resolution of Landsat 8 thermal data and to calibration bias in
        Landsat 7 and 8 surface temperature. Remote Sensing of Environment,
        185, pp.198-209.
        [doi:10.1016/j.rse.2016.07.011](https://doi.org/10.1016/j.rse.2016.07.011)
      |||,
    },
    {
      citation: |||
        ReVelle, P., A. Kilic and R.G. Allen. 2019a. Updated Calibration
        Description: Spatial Delapsing in eeMETRIC. Research Note. School of
        Natural Resources, University of Nebraska-Lincoln and University of
        Idaho. 9 p.
      |||,
      // TODO(schwehr): Get a link to this document.
    },
    {
      citation: |||
        ReVelle, P., A. Kilic and R.G. Allen. 2019b. Updated Calibration
        Description: Automated Pixel Selection Method in eeMETRIC. Research
        Note. School of Natural Resources, University of Nebraska-Lincoln and
        University of Idaho. 20 p.
      |||,
      // TODO(schwehr): Get a link to this document.
    },
    {
      citation: |||
        Santos, C., Lorite, I.J., Allen, R.G. and Tasumi, M., 2012.  Aerodynamic
        parameterization of the satellite-based energy balance (METRIC) model
        for ET estimation in rainfed olive orchards of Andalusia, Spain. Water
        Resources Management, 26, pp.3267-3283.
        [doi:10.1007/s11269-012-0071-8](https://doi.org/10.1007/s11269-012-0071-8)
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
