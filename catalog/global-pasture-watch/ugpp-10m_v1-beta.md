Produced by the Land & Carbon Lab Global Pasture Watch initiative, this Time2Graze dataset provides
near-real-time, daily uncalibrated Gross Primary Productivity (uGPP) at 10-m spatial resolution
(0.01 ha, compatible with the paddock scale) for any emerged point on the globe.

uGPP is modelled with a light use efficiency (LUE) approach that follows the MOD17 algorithm with the
modifications of [Isik et al., 2025](https://doi.org/10.7717/peerj.19774). Each daily value is

```
uGPP = PAR x fAPAR x Ts x Ws
```

where:

- **PAR** is the daily all-sky photosynthetically active radiation retrieved at 10 m from Sentinel-2
  ([Isik et al., 2026](https://doi.org/10.3390/rs18162745));
- **fAPAR** is derived from the Sentinel-2 NDVI;
- **Ts** is a temperature scalar computed from daytime VIIRS land surface temperature (VNP21A1D),
  with cardinal temperatures Tmin = 0 °C, Tmax = 48 °C and Topt = 20.3 °C;
- **Ws** is a water scalar derived from the Sentinel-2 Land Surface Water Index (LSWI) instead of a
  reanalysis vapour pressure deficit.

The maximum light use efficiency (LUEmax) is fixed to 1 gC/m²/day/MJ for all land cover types, making
the product calibration-agnostic: any calibrated GPP is recovered by a single multiplication,
`GPP = LUEmax x uGPP`. The recommended default for grasslands is LUEmax = 0.86 gC/m²/day/MJ,
inherited from the MOD17 BPLUT.

The collection is produced and updated in near-real-time in Google Earth Engine from the Sentinel-2
Level-2A harmonized archive and VIIRS VNP21A1D land surface temperature. Images are organized per
Sentinel-2 acquisition (tile and date); the `ugpp` band stores uGPP in gC/m²/day as 16-bit integers
scaled by 10 (multiply by 0.1 to obtain gC/m²/day; the no-data value is -1).

**Effective resolution:** fAPAR and PAR are natively 10 m, the water scalar originates from 20-m
bands, and the thermal scalar is resolved at roughly 375 m to 1 km (VIIRS). Grid spacing is 10 m, but
thermal limitation does not vary below approximately 1 km.

**Limitations:**

- **Thermal input resolution**: Ts comes from VIIRS (375 m–1 km) and is resampled to 10 m;
  sub-kilometre variation in uGPP originates only from fAPAR, PAR and Ws.
- **Temporal coverage**: daily values depend on cloud-free Sentinel-2 overpasses; gaps occur under
  persistent cloud and no gap-filling is applied in this near-real-time version.
- **Calibration**: uGPP is uncalibrated (LUEmax = 1); users are responsible for choosing an
  appropriate LUEmax for their region or land cover. Grassland values using the default 0.86 tend to
  underestimate GPP relative to eddy-covariance towers.
- **Optical water scalar**: LSWI replaces reanalysis VPD and may under- or over-represent water stress
  for deep-rooted woody vegetation.

The product is evaluated against eddy-covariance towers from AmeriFlux, ChinaFlux, ICOS, JapanFlux,
Swiss FluxNet and TERN, analysed by IGBP class and hemisphere.

For more information see [Isik et al., 2025](https://doi.org/10.7717/peerj.19774),
[Isik et al., 2026](https://doi.org/10.3390/rs18162745) and the
[Global Pasture Watch GitHub site](https://github.com/wri/global-pasture-watch).
