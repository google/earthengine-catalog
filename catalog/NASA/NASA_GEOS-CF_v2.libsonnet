{
  description: |||
    The Goddard Earth Observing System Composition Forecast (GEOS-CF) system is
    a global constituent prediction system from
    NASA's [Global Modeling and Assimilation Office(GMAO)](
    https://gmao.gsfc.nasa.gov/). 

    GEOS-CF offers a tool for atmospheric chemistry research, with the goal
    to supplement NASA's broad range of space-based and in-situ observations.
    GEOS-CF expands on the GEOS weather and aerosol modeling system by
    introducing the [GEOS-Chem](http://wiki.seas.harvard.edu/geos-chem/)
    chemistry module to provide hindcasts and 5-days forecasts of atmospheric
    constituents including ozone (O<sub>3</sub>), carbon monoxide (CO), nitrogen dioxide
    (NO<sub>2</sub>), sulfur dioxide (SO<sub>2</sub>), coarse particulate matter 
    (PM<sub>10</sub>), and fine particulate matter (PM<sub>2.5</sub>). The
    chemistry module integrated in GEOS-CF is identical to the offline GEOS-Chem
    model and readily benefits from the innovations provided by the GEOS-Chem
    community. Outputs are provided globally at 0.25&deg; horizontal resolution. 
    Please refer to the [GEOS-CF Product Page](https://gmao.gsfc.nasa.gov/gmao-products/geos-cf/) for more details.

    In October 2025, a major update to the GEOS-CF system was introduced as 
    GEOS-CF v2. This change included updates to the GEOS atmospheric general 
    circulation model and the GEOS-Chem chemical model, replaying meteorology to 
    [GEOS IT](https://gmao.gsfc.nasa.gov/gmao-products/geos-it/), direct assimilation 
    of stratospheric profiles and column ozone from NASA Aura OMI and MLS instruments, 
    and updates to the anthropogenic emission source. Evaluation of these updates is 
    ongoing; results will be added into this description as they become available. 
    [Preliminary results](https://gmao.gsfc.nasa.gov/science-snapshots/improved-atmospheric-composition-forecasting-in-geos-cf-version-2/) 
    suggest that, in relation to GEOS-CF v1, GEOS-CF v2 dramatically 
    improves the representation of PM<sub>2.5</sub> and SO<sub>2</sub> near the surface. 
    Representations of O<sub>3</sub> and NO<sub>2</sub> are generally improved throughout
    most of the atmospheric column, with and NO<sub>2</sub> being substantially lower in GEOS-CF v2 compared with v1. 
    While representation of near-surface O<sub>3</sub> is improved compared to GEOS-CF v1, 
    there remain high biases compared with ozone monitor data from the US Environmental Protection Agency.

    Users of GEOS-CF are encouraged to treat outputs from the original system (v1) 
    and the new system (v2) separately in their analysis, due to the extensive changes 
    between the systems.
  |||,
  sci_citation: |||
    Keller, C. A., Knowland, K. E., Duncan, B. N., Liu, J., Anderson, D. C.,
    Das, S., ... & Pawson, S. (2021). Description of the NASA GEOS composition
    forecast modeling system GEOS-CF v1.0. Journal of Advances in Modeling
    Earth Systems, 13(4), e2020MS002413.
    [doi:10.1029/2020MS002413](https://doi.org/10.1029/2020MS002413)
    
    Knowland, K. E., Keller, C. A., Wales, P. A., Wargan, K., Coy, L., 
    Johnson, M.S., ... & Pawson, S. (2022). NASA GEOS Composition Forecast Modeling 
    System GEOS‐CF v1.0: Stratospheric Composition. Journal of Advances in Modeling
    Earth Systems, 14, e2021MS002852. 
    [doi:10.1029/2021MS002852](https://doi.org/10.1029/2021MS002852)

    Note: these citations refer to the original GEOS-CF (v1) system; citations describing 
    the new (v2) system will be added following publication.
  |||,
  gee_terms_of_use: |||
    Unless otherwise noted, all NASA-produced data may be used for any purpose
    without prior permission. For more information and exceptions visit the
    [NASA Data & Information Policy page](https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy).
  |||,
}
