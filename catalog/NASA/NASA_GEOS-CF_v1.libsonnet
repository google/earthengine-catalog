{
  description: |||
    The Goddard Earth Observing System Composition Forecast (GEOS-CF) system is
    a global constituent prediction system from NASA's [Global Modeling and Assimilation Office (GMAO)](https://gmao.gsfc.nasa.gov/).

    GEOS-CF offers a new tool for atmospheric chemistry research, with the goal
    to supplement NASA's broad range of space-based and in-situ observations.
    GEOS-CF expands on the GEOS weather and aerosol modeling system by
    introducing the [GEOS-Chem](http://wiki.seas.harvard.edu/geos-chem/)
    chemistry module to provide hindcasts and 5-days forecasts of atmospheric
    constituents including ozone (O<sub>3</sub>), carbon monoxide (CO), nitrogen dioxide
    (NO<sub>2</sub>), sulfur dioxide (SO<sub>2</sub>), and fine particulate matter (PM<sub>2.5</sub>). The
    chemistry module integrated in GEOS-CF is identical to the offline GEOS-Chem
    model and readily benefits from the innovations provided by the GEOS-Chem
    community. Model outputs are provided on a 0.25&deg; latitude-longitude grid.
    Please refer to the [GEOS-CF Product Page](https://gmao.gsfc.nasa.gov/gmao-products/geos-cf/) for more details.

    [Evaluation of GEOS-CF](https://doi.org/10.1029/2020MS002413) against satellite, ozonesonde, and surface
    observations for years 2018&ndash;2019 shows realistic simulated
    concentrations of O<sub>3</sub>, NO<sub>2</sub>, and CO, with normalized mean biases of &minus;0.1
    to 0.3, normalized root mean square errors between 0.1&ndash;0.4, and
    correlations between 0.3&ndash;0.8. Comparisons against surface observations
    highlight the successful representation of air pollutants in many regions of
    the world and during all seasons, yet also highlight current limitations,
    such as a global high bias in SO<sub>2</sub> and an overprediction of summertime O<sub>3</sub>
    over the Southeast United States.
    GEOS-CF v1 generally overestimates aerosols by 20%&ndash;50% due to known
    issues in GEOS-Chem v12.0.1 that have been addressed in later versions. The
    5-days forecasts have skill scores comparable to the 1-day hindcast. Model
    skills can be improved significantly by applying a bias-correction to the
    surface model output using a machine-learning approach.

    **Please Note:** A new version of GEOS-CF, v2, was released in January 2026. The updates 
    to the GEOS-CF system include updates to the GEOS atmospheric general 
    circulation model and the GEOS-Chem chemical model, replaying meteorology 
    to [GEOS IT](https://gmao.gsfc.nasa.gov/gmao-products/geos-it/), direct assimilation of stratospheric profiles and column ozone, 
    and updates to the anthropogenic emission source. Many of the same products 
    are available, and some new products have been added, but other products have 
    been discontinued. Furthermore, GEOS-CF v2 data will not be back-processed to
    cover the same period as GEOS-CF v1. For this reason, we consider GEOS-CF v2 
    to be a continuation and supplement to the GEOS-CF v data record, but not a 
    replacement for GEOS-CF v1 data. Please see the [GEOS-CF system description](https://gmao.gsfc.nasa.gov/gmao-products/geos-cf/system-description_geos-cf/) 
    for a summary of the updates, and consider the 
    [preliminary GEOS-CF v2 evaluation results](https://gmao.gsfc.nasa.gov/science-snapshots/improved-atmospheric-composition-forecasting-in-geos-cf-version-2/) 
    when deciding which version to use in your analysis.
  |||,
  sci_citation: |||
    Keller, C. A., Knowland, K. E., Duncan, B. N., Liu, J., Anderson, D. C.,
    Das, S., ... & Pawson, S. (2021). Description of the NASA GEOS composition
    forecast modeling system GEOS-CF v1. 0. Journal of Advances in Modeling
    Earth Systems, 13(4), e2020MS002413.
    [doi:10.1029/2020MS002413](https://doi.org/10.1029/2020MS002413)
  |||,
  gee_terms_of_use: |||
    Unless otherwise noted, all NASA-produced data may be used for any purpose
    without prior permission. For more information and exceptions visit the
    [NASA Data & Information Policy page](https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy).
  |||,
}
