local units = import 'units.libsonnet';

{
  description: |||
    The RCMAP (Rangeland Condition Monitoring Assessment and Projection)
    dataset quantifies the percent cover of rangeland components across
    western North America using Landsat imagery from 1985-2023. The RCMAP
    product suite consists of ten fractional components: annual herbaceous,
    bare ground, herbaceous, litter, non-sagebrush shrub, perennial herbaceous,
    sagebrush, shrub, tree, and shrub height in addition to the temporal
    trends of each component. Several enhancements were made to the RCMAP
    process relative to prior generations. First, high-resolution training
    was revised using an improved neural-net classifier and modelling approach.
    These data serve as foundation to the RCMAP approach. The training
    database was further improved by incorporating additional datasets. Next,
    the Landsat compositing approach was improved to better capture the range
    of conditions from across each year and through time. These composites are
    based on Collection 2 Landsat data with improved geolocation accuracy and
    dynamic range. Finally, the Canadian portion of the sagebrush biome was
    included, which expanded the study area by 29,199 km2.

    Processing efficiency has been increased using open-source software and
    USGS High-Performance Computing (HPC) resources. The mapping area included
    eight regions which were subsequently mosaicked. These data can be used to
    answer critical questions regarding the influence of climate change and
    the suitability of management practices. Component products can be
    downloaded at
    [Multi-Resolution Land Characteristics Consortium](https://www.mrlc.gov/data).

    The temporal patterns were assessed in each RCMAP component with two
    approaches, 1) linear trends and 2) a breaks and stable states method
    with an 8-year temporal moving window based on structural change at the
    pixel level. Linear trend products include slope and p-value calculated
    from least squares linear regression. The slope represents the average
    percent cover change per year over the times-series and the p-value
    reflects the confidence of change in each pixel. The structural change
    method partitions the time-series into segments of similar slope values,
    with statistically significant breakpoints indicating perturbations to the
    prior trajectory. The break point trends analysis suite relies on
    structural break methods, resulting in the identification of the number
    and timing of breaks in the time-series, and the significance of each
    segment. The following statistics were produced: 1) for each component,
    each year, the presence/absence of breaks, 2) the slope, p-value, and
    standard error of the segment occurring in each year, 3) the overall
    model R2 (quality of model fit to the temporal profile), and 4) an index,
    Total Change Intensity. This index reflects the total amount of change
    occurring across components in that pixel. The linear and structural
    change methods generally agreed on patterns of change, but the latter
    found breaks more often, with at least one break point in most pixels.
    The structural change model provides more robust statistics on the
    significant minority of pixels with non-monotonic trends, while
    detrending some interannual signal potentially superfluous from a
    long-term perspective.
  |||,
  bands_prefix: [
    'annual_herbaceous',
    'bare_ground',
    'herbaceous',
    'litter',
    'sagebrush',
    'shrub',
    'shrub_height',
    'non_sagebrush_shrub',
    'perennial_herbaceous',
    'tree'
  ],
  band_description: {
    _break_point: [
      'Number of structural breaks observed in the',
      units.count,
    ],
    _linear_model_pvalue: [
      'P-value of linear trends model for',
      units.p_value,
    ],
    _linear_model_slope: [
      'Slope of linear trends model for',
      units.percent_change_per_year,
    ],
    _most_recent_break_point: [
      'Year of most recent break in the time-series for each component of',
      units.year,
    ],
  },
  // The code replaces band_name with the actual band_name at runtime.
  band_description_yearly: {
    _break_point: [
      |||
        Annual structural breaks in each component of band_name present or
        absent
      |||,
      units.count,
    ],
    _segment_pvalue: [
      |||
        P-values of structural break segments within each component of
        band_name per year
      |||,
      units.p_value,
    ],
    _segment_slope: [
      |||
        Annual slope of structural break segments within each component of
        band_name
      |||,
      units.percent_change_per_year,
    ],
  },
  publication: [
    {
      citation: |||
        Rigge, M., H. Shi, C. Homer, P. Danielson, and B. Granneman. 2019.
        Long-term trajectories of fractional component change in the Northern
        Great Basin, USA. Ecosphere 10(6):e02762.
        [doi:10.1002/ecs2.2762](https://doi.org/10.1002/ecs2.2762)
      |||,
      doi: '10.1002/ecs2.2762',
    },
    {
      citation: |||
        Rigge, M., C. Homer, L. Cleeves, D. K. Meyer, B. Bunde, H. Shi, G. Xian,
        S. Schell, and M. Bobo. 2020. Quantifying western U.S. rangelands as
        fractional components with multi-resolution remote sensing and in situ
        data. Remote Sensing 12.
        [doi:10.3390/rs12030412](https://doi.org/10.3390/rs12030412)
      |||,
      doi: '10.3390/rs12030412',
    },
    {
      citation: |||
        Rigge, M., C. Homer, H. Shi, D. Meyer, B. Bunde, B. Granneman,
        K. Postma, P. Danielson, A. Case, and G. Xian.
        2021. Rangeland Fractional Components Across the Western United States
        from 1985 to 2018. Remote Sensing 13:813.
        [doi:10.3390/rs13040813](https://doi.org/10.3390/rs13040813)
      |||,
      doi: '10.3390/rs13040813',
    },
  ],
  citation: |||
    Rigge, M.B., Bunde, B., Postma, K., and Shi, H., 2024,
    Rangeland Condition Monitoring Assessment and Projection (RCMAP)
    Fractional Component Time-Series Across the Western U.S. 1985-2023:
    U.S. Geological Survey data release,
    [doi:10.5066/P9SJXUI1](https://doi.org/10.5066/P9SJXUI1).
  |||,
  terms_of_use: |||
    This work was authored as part of the Contributor's official duties as an
    Employee of the United States Government and is therefore a work of the
    United States Government. In accordance with 17 U.S.C. 105, no copyright
    protection is available for such works under U.S. Law. This is an Open
    Access article that has been identified as being free of known restrictions
    under copyright law, including all related and neighboring rights
    (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify,
    distribute and perform the work, even for commercial purposes, all without
    asking permission.
  |||,
}
