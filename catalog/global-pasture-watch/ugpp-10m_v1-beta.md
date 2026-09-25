Produced by the [Time2Graze](https://www.globalmethanehub.org/2025/09/10/the-global-methane-hub-launches-international-project-to-develop-satellite-guided-grazing-to-cut-livestock-emissions/), 
and Land &#38; Carbon Lab Global Pasture Watch initiatives, this dataset provides near-real-time, daily 
uncalibrated Gross Primary Productivity (uGPP) at 10-m resolution for Argentina, Brazil, Colombia, Nigeria, 
Tanzania, Uganda, Uruguay, Zimbabwe.

uGPP is modeled with a light use efficiency (LUE) approach that follows the MOD17 algorithm with the
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

- **Beta version**: The dataset is provided as beta version. A full assessment of GPP values is being 
  conducted using hundreds of eddy-covariance towers from AmeriFlux, ChinaFlux, ICOS, JapanFlux, Swiss FluxNet 
  and TERN, and will be submitted to peer-review in the next months.
- **Thermal input resolution**: Ts comes from VIIRS (375 m–1 km) and is resampled to 10 m;
  sub-kilometre variation in uGPP originates only from fAPAR, PAR and Ws.
- **Temporal coverage**: daily values depend on cloud-free Sentinel-2 overpasses; gaps occur under
  persistent cloud and no gap-filling is applied in this near-real-time version.
- **Calibration**: uGPP is uncalibrated (LUEmax = 1); users are responsible for choosing an
  appropriate LUEmax for their region or land cover. Grassland values using the default 0.86 tend to
  underestimate GPP relative to eddy-covariance towers.
- **Optical water scalar**: LSWI replaces reanalysis VPD and may under- or over-represent water stress
  for deep-rooted woody vegetation.

For more information see [Isik et al., 2025](https://doi.org/10.7717/peerj.19774) and
[Isik et al., 2026](https://doi.org/10.3390/rs18162745). The production pipeline is 
available in [CodeBerg repository](https://codeberg.org/global-pasture-watch/forage-10-pipeline-gee/src/branch/main/f10/calculate_gpp_gee.py).