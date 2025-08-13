Produced by Land &#38; Carbon Lab Global Pasture Watch initiative, the current dataset provides 
Gross Primary Productivity (GPP) values globally at 30-m spatial resolution from 2000 onwards. 
GPP values are modeled via a **light use efficiency (LUE)** approach, 
where [**GLAD Landsat ARD** (collection-2)](https://glad.umd.edu/ard/home) are aggregated every two months 
([Consoli et al., 2024](https://peerj.com/articles/18585/)) and combined with 1-km **MODIS 
temperature** data and 1° **CERES Photosynthetically Active Radiation** (PAR). 

To keep the dataset flexible, the maximum light use efficiency (LUEmax) is set to 1 gC/m²/day/MJ 
for **all land cover types**, allowing the users to later calibrate the 
GPP values according to specific land cover maps or regional conditions.

**Bi-monthly uncalibrated Gross Primary Productivity (uGPP)** values (available in [OpenLandMap STAC](https://stac.openlandmap.org/gpw_ugpp.daily-30m/collection.json)) are averated by each year and accumulated over the full 365-day period to produce
global annual uGPP values, expressed in units of gC/m²/year.

**Grassland GPP** values are computed on-the-fly using [GEE App](https://global-pasture-watch.projects.earthengine.app/view/ggpp-30m).

**Limitations:** 

- **Input data resolution mismatch**: The dataset is provided at 30 m resolution, but key input variables for temperature (MOD11A1) 
and photosynthetically active radiation (CERES PAR) were derived from much coarser products (1 km and ~111 km, respectively).
The downscaling of this information can introduce uncertainty and may not capture fine-scale microclimatic conditions affecting plant productivity.

- **Data artifacts**: The dataset contains known visual artifacts, including vertical stripes ("stripe effect") in some areas, which are a result 
of issues with the Landsat 7 sensor (Scan Line Corrector failure) and the subsequent gap-filling process used to create the underlying 
reflectance archive ([Consoli et al., 2024](https://peerj.com/articles/18585/)). These artifacts can disrupt the spatial continuity 
of GPP estimates during cloudy and snow cover periods

- **Temporal resolution**: The data is produced at a bimonthly temporal resolution. This timeframe may not be sufficient 
to capture key growth periods or a plant's rapid responses (intense rainfall) to environmental changes, making 
it difficult to accurately capture productivity peaks and seasonal variation.

- **Grassland calibration**: Grassland GPP values are calculated using a single maximum light use efficiency (LUEmax) 
parameter (0.86 gC/m²/year/MJ) for all global grasslands, based on the MOD17 algorithm. This value is not optimized 
for specific grassland types or local conditions. As a result, the model shows a tendency to underestimate GPP when 
compared to ground-based flux tower measurements.

- **Dependence on grassland maps accuracy**: The accuracy of the grassland GPP values is contingent on the accuracy of the 
underlying [GPW grassland maps](https://developers.google.com/earth-engine/datasets/catalog/projects_global-pasture-watch_assets_ggc-30m_v1_grassland_c).
Any misclassification of land cover in the source maps (e.g., shrublands or croplands identified as grassland) will 
lead to corresponding errors in the GPP estimates for those locations.

**For more information see [Isik et. al, 2025](https://doi.org/10.7717/peerj.19774),
[Zenodo](https://doi.org/10.5281/zenodo.15675358) and 
[https://github.com/wri/global-pasture-watch](https://github.com/wri/global-pasture-watch)**