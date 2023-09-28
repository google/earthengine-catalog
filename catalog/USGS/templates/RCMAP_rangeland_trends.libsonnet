local units = import 'units.libsonnet';

{
  description: |||
    The RCMAP product suite includes nine fractional components: annual
    herbaceous, bare ground, herbaceous, litter, non-sagebrush shrub, perennial
    herbaceous, sagebrush, shrub, and tree. It also includes rule-based error
    maps and the temporal trends of each component. Data characterize the
    percentage of each 30-meter pixel in the Western United States covered by
    each component for each year from 1985-2021, providing change information
    for 36 years.

    The temporal patterns in each RCMAP component are assessed with two
    approaches:
    1) linear trends and 2) a breaks and stable states method with an 8-year
    temporal moving window based on structural change at the pixel level.
    Linear trend products include slope and p-value calculated from least
    squares linear regression. The slope represents the average percent cover
    change per year over the time series and the p-value reflects the
    confidence of change in each pixel. The structural change method partitions
    the time series into segments of similar slope values, with statistically
    significant break-points indicating perturbations to the prior trajectory.
    The break point trends analysis suite relies on structural break methods,
    resulting in the identification of the number and timing of breaks in the
    following statistics are produced: 1) for each component, each year, the
    presence/absence of breaks, 2) the slope, p-value, and standard error of
    the segment occurring in each year, 3) the overall model R2 (quality of
    model fit to the temporal profile), and 4) an index, Total Change Intensity.
    This index reflects the total amount of change occurring across components
    in that pixel. The linear and structural change methods generally agreed on
    patterns of change, but the latter found breaks more often, with at least
    one break point in most pixels. The structural change model provides more
    robust statistics on the significant minority of pixels with non-monotonic
    trends, while detrending some interannual signal potentially superfluous
    from a long-term perspective.
  |||,
  bands_prefix: [
    'annual_herbaceous',
    'bare_ground',
    'herbaceous',
    'litter',
    'sagebrush',
    'shrub',
    'non_sagebrush_shrub',
    'perennial_herbaceous',
    'tree',
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
    Rigge, M.B., Bunde, B., Postma, K., Shi, H., 2022, Rangeland Condition
    Monitoring Assessment and Projection (RCMAP) Fractional Component
    Time-Series Across the Western U.S. 1985-2021: U.S. Geological Survey data
    release.
    [doi:10.5066/P9ODAZHC](https://doi.org/10.5066/P9ODAZHC)
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
