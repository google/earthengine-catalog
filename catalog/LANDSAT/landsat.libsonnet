local l7_drift = |||

  Note that [Landsat 7's orbit has been drifting to an earlier acquisition time since
  2017](https://www.sciencedirect.com/science/article/pii/S2666017221000134?via%3Dihub).
|||;

local tier1 = |||

    Landsat scenes with the highest available data quality
    are placed into Tier 1 and are considered suitable for time-series processing
    analysis. Tier 1 includes Level-1 Precision Terrain (L1TP) processed data
    that have well-characterized radiometry and are inter-calibrated across the
    different Landsat sensors. The georegistration of Tier 1 scenes will be
    consistent and within prescribed tolerances [<=12 m root mean square error
    (RMSE)]. All Tier 1 Landsat data can be considered consistent and
    inter-calibrated (regardless of sensor) across the full collection. See more
    information [in the USGS
    docs](https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collections).
|||;

local tier1_rt = tier1 + |||

    The T1_RT collection contains both Tier 1 and Real-Time (RT) assets.
    Newly-acquired Landsat 7 ETM+ and Landsat 8 OLI/TIRS data are processed
    upon downlink but use predicted ephemeris, initial bumper mode parameters,
    or initial TIRS line of sight model parameters. The data is placed in the
    Real-Time tier and made available for immediate download. Once the data
    have been reprocessed with definitive ephemeris, updated bumper mode
    parameters and refined TIRS parameters, the products are transitioned to
    either Tier 1 or Tier 2 and removed from the Real-Time tier. The transition
    delay from Real-Time to Tier 1 or Tier 2 is between 14 and 26 days.
|||;

local tier2 = |||
    Scenes not meeting Tier 1 criteria during
    processing are assigned to Tier 2. This includes Systematic terrain (L1GT) and
    Systematic (L1GS) processed scenes, as well as any L1TP scenes that do not meet
    the Tier 1 specifications due to significant cloud cover, insufficient ground
    control, and other factors. Users interested in Tier 2 scenes can analyze the
    RMSE and other properties to determine the suitability for use in individual
    applications and studies. See more information [in the USGS
    docs](https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collections).
|||;

local toa = |||
  Calibration coefficients are extracted from the image metadata. See
  [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
  for details on the TOA computation.
|||;

{
  l7_drift: l7_drift,
  tier1: tier1,
  tier1_rt: tier1_rt,
  tier2: tier2,
  toa: toa
}
